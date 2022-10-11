require_relative "room"

class Hotel

    def initialize(name, hash)
        @name = name
        @rooms = {}

        hash.each do |room_name, capacity|
            @rooms[room_name] = Room.new(capacity)
        end
    end

    def name
        new_name = []
        split = @name.split(" ")
        split.each do |names|
            new_name << names.capitalize()
        end
        new_name.join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(room_name)
        if @rooms.has_key?(room_name)
            return true
        end
        false
    end

    def check_in(person, room_name)
        if !self.room_exists?(room_name)
            puts "sorry, room does not exist"
        else
            if @rooms[room_name].add_occupant(person)
                puts "check in successful"
            else
                puts "sorry, room is full"
            end
        end
    end

    def has_vacancy?
        @rooms.each do |room_name, room_instance |
            if !room_instance.full?
                return true
            end
        end
        false
    end

    def list_rooms
        @rooms.each do |k,v|
            puts "#{k} has #{@rooms[k].available_space}"
        end
    end



  
end
