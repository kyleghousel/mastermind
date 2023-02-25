# Define the Mastermind class
class Mastermind
  attr_reader :codemaker, :codebreaker, :code

  def initialize(codemaker, codebreaker, code)
    @codemaker = codemaker
    @codebreaker = codebreaker
    @code = code
    @previous_guesses = []
    @computer_score = 0
    @player_score = 0
  end

  def play_mastermind
    round_won = false
    round = 1

    until round_won || round > 12 do
      puts "Round #{round}"
      if @codebreaker.name == "Computer"
        guess = @codebreaker.generate_guess # call generate_guess method of ComputerPlayer
        puts "The computer's guess is: #{guess}"
        @player_score += 1
      else
        puts "Enter your guess to crack the code."
        guess = gets.chomp
        guess = guess.split("")
        @computer_score += 1
        p guess
        if guess.length != 4
          puts "Your guess is invalid. Keep it to four characters."
          next
        end
      end

      feedback = ""
      guessed_elements_matched = []
      guess.each_with_index do |element, index|
        if @code[index] == element
          feedback += "● "
          guessed_elements_matched << element
        elsif @code.include?(element) && !guessed_elements_matched.include?(element)
          feedback += "○ "
          guessed_elements_matched << element
        end
      end

      if guess == @code
        round_won = true
        puts "You cracked the code!"
      else
        puts feedback
        round += 1
      end
    end

    puts "Player: #{@player_score}    Computer: #{@computer_score}"
  end
end

# Define the HumanPlayer class
class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def generate_guess
    puts "Enter your guess to crack the code."
    guess = gets.chomp
    guess = guess.split("")
    if guess.length != 4
      puts "Your guess is invalid. Keep it to four characters."
      generate_guess # recursively call the method until a valid guess is entered
    else
      guess
    end
  end

  def generate_code
    code = Array.new()
    puts "Enter your code:"
    enter_code = gets.chomp
    enter_code = enter_code.split("")
    if enter_code.length != 4
      puts "Invalid code. The code must be four characters long."
      generate_code # recursively call the method until a valid code is entered
    elsif (!enter_code.all? { |c| ("1".."6").include?(c) })
      puts "Invalid code. Only numbers 1-6 are accepted."
      generate_code # recursively call the method until a valid code is entered
    else
      enter_code
    end
  end
end

# Define the ComputerPlayer class
class ComputerPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def generate_code
    computer_code = []
    4.times do
      rand_num = rand(7)
      if rand_num == 6
      computer_code << " "
      else
      computer_code << (rand_num + 1).to_s
      end
    end
    computer_code
  end

  def generate_guess
    # Generate all possible combinations of 4 digits (1 to 6)
    all_guesses = (1..6).to_a.repeated_permutation(4).to_a

    # Remove previous incorrect guesses from the list of possible guesses
    if @previous_guesses.length > 0
      all_guesses -= @previous_guesses
    end

    # If no previous guesses, pick a random guess
    if all_guesses.length == 1296
      guess = [1,1,2,2].shuffle
    else
      guess = all_guesses.sample
    end
  
    # Store the guess in the list of previous guesses
    @previous_guesses << guess
  
    # Return guess array
    guess
  end
end

# Initialize score variables
score_codebreaker = 0
score_codemaker = 0

def setup_mastermind(breaker, maker)
  puts "What is your name?"
  username = gets.chomp
  if breaker == "human" && maker == "computer"
    codebreaker = HumanPlayer.new(username)
    codemaker = ComputerPlayer.new("Computer")
  elsif breaker == "computer" && maker == "human"
    codebreaker = ComputerPlayer.new("Computer")
    codemaker = HumanPlayer.new(username)
  else
    # Swap roles if necessary
    codebreaker = maker
    codemaker = breaker
  end

  # Create an instance of the Mastermind class and call play_mastermind on it
  mm = Mastermind.new(codemaker, codebreaker, codemaker.generate_code)
  winner = mm.play_mastermind

  # Update score
  if winner == "codebreaker"
    score_codebreaker += 1
  else
    score_codemaker += 1
  end

  # Print the score
  puts "Score: Codebreaker #{score_codebreaker}, Codemaker #{score_codemaker}"

  # Ask if the players want to play again
  puts "Play again? Y or N"
  reply = gets.chomp.downcase
  if reply == "y" || reply == "yes"
    # Swap roles and pass to setup_mastermind
    setup_mastermind(maker, breaker)
  else
    puts "Thank you for playing. Goodbye."
  end
end


def play_again(breaker, maker)
  setup_mastermind(breaker, maker)
end

def start_mm
  puts "Welcome to Mastermind. Would you like to play as the codemaker, or the codebreaker?"
  user_input = gets.chomp
  user_input.downcase
  if user_input == "codemaker"
    setup_mastermind("PC", user_input)
  elsif user_input == "codebreaker"
    setup_mastermind(user_input, "PC")
  else
    puts "Invalid response."
    start_mm()
  end  
end

start_mm()

