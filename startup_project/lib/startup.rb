require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees


    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        if salaries.has_key?(title)
            return true
        end
        false
    end

    def >(startup)
        if self.funding > startup.funding
            return true
        end
        false
    end

    def hire(employee_name, title)
        if valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise "This is an error"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee_instance)
        money_owed = @salaries[employee_instance.title]
        if @funding >= money_owed
            employee_instance.pay(money_owed)
            @funding -= money_owed
        else
            raise "There is not enough money"
        end
    end

    def payday
        employees.each do |employee|
            pay_employee(employee)
        end
    end

    def average_salary
        sum = 0
        employees.each do |employee|
            sum += @salaries[employee.title]
        end
        sum/size

    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding = @funding + startup.funding

        startup.salaries.each do |title, salary|
            if !@salaries.has_key?(title)
                @salaries[title] = salary
            end
        end

        @employees += startup.employees

        startup.close
        
    end







end
