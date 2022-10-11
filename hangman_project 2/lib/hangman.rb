class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample()
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length,"_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.each do |a_char|
      if a_char == char
        return true
      end
    end
    false
  end

  def get_matching_indices(char)
    new_arr = []
    @secret_word.each_char.with_index do |s_char, i|
      if s_char == char
        new_arr << i
      end
    end
    new_arr
  end

  def fill_indices(char, arr)
    arr.each do |idx|
      @guess_word[idx] = char
    end
  end
  
  def try_guess(char)
    if self.already_attempted?(char)
      puts "that has already been attempted"
      return false
    else   
      @attempted_chars << char
      arr = self.get_matching_indices(char)
      self.fill_indices(char, arr)

      if arr.empty?
        @remaining_incorrect_guesses -= 1
      end

      true
    end
  end


  def ask_user_for_guess
    puts "Enter a char:"
    guess = gets.chomp
    return self.try_guess(guess)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    end
    false
  end

  def lose?
    if remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    end
    false
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      return true
    end
    false
  end
end
