require 'colorize'
require_relative 'startup.rb'
include TitleScreen, Instructions

#peg_one = "   1   ".black.on_light_red
#peg_two = "   2   ".black.on_light_yellow
#peg_three = "   3   ".black.on_light_green
#peg_four = "   4   ".black.on_cyan
#peg_five = "   5   ".black.on_light_blue
#peg_six = "   6   ".black.on_magenta

TitleScreen::display_title
Instructions::print_instructions

#def theme_music
  #ystem("open /Users/kylehousel/Downloads/neon-gaming-128925.mp3")
#end

#theme_music()


class Mastermind
  attr_reader :codemaker, :codebreaker, :code
  def initialize(codemaker, codebreaker, code)
    @codemaker = codemaker
    @codebreaker = codebreaker
    @code = code
    @previous_guesses = []
    @user = "User"
    @computer = "Computer"
    @user_score = 0
    @computer_score = 0
  end

  def play_mastermind
    round_won = false
    round = 1
    
    until round_won || round > 12 do
      puts "Round #{round}"
      if @codebreaker.name == "Computer"
        guess = generate_guess()
        puts "The computer's guess is: #{guess}"
        @user_score += 1
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
          # Update the scores
          if @codebreaker.name == "Computer"
            @computer_score += 1
          else
            @user_score += 1
          end
        else
          puts feedback
          round += 1
          #puts "Round #{round}"
        end
      end
      puts "Player: #{@user_score}    Computer: #{@computer_score}"
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

class Codemaker
  attr_reader :name
  attr_accessor :enter_code
 
  def initialize(name)
    @name = name
  end 
  
  def player_code_create  
    code = Array.new() 
    puts "Codemaker, please enter your code:"
    enter_code = gets.chomp
    code_check = false
    #need to ensure code does not include special characters
    until code_check do
      if enter_code.length > 4
        puts "Invalid code. The code must be four characters long. Please enter a new code."
        enter_code = gets.chomp
      elsif (!enter_code.match?(/^[1-6\s]+$/))
        puts "Invalid code. Only spaces or whole numbers 1-6 are accepted. Please enter a new code."
        enter_code = gets.chomp
      elsif (enter_code.match?(/^[1-6\s]+$/)) && (enter_code.length == 4)
        code_check = true
      else
        puts "Invalid code. Please enter a new one."
        enter_code = gets.chomp
      end
    end
    code = enter_code.split("")
    p code
  end

  def computer_code_create
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
end

class Codebreaker
  attr_reader :name
  def initialize(name)
    @name = name
  end 
end

def setup_mastermind()

  @user_scores ||= {}
  @computer_scores ||= {}

  puts "Would you like to play as the Codemaker or the Codebreaker?"
  user_response = gets.chomp
  if user_response.downcase == "codemaker"
    name1 = "User"
    codemaker = Codemaker.new(name1)
    name2 = "Computer"
    puts "You are playing against #{name2}"
    codebreaker = Codebreaker.new(name2)
    code = codemaker.player_code_create()
    @user_scores[codemaker.name] ||= 0
    @computer_scores[codebreaker.name] ||= 0
    play = Mastermind.new(codemaker, codebreaker, code)
  elsif user_response.downcase == "codebreaker"
    name1 = "User"
    codebreaker = Codebreaker.new(name1)
    name2 = "Computer"
    puts "You are playing against #{name2}"
    codemaker = Codemaker.new(name2)
    code = codemaker.computer_code_create()
    play = Mastermind.new(codemaker, codebreaker, code)
  else
    puts "Invalid response. Try again."
    setup_mastermind()
  end
  play.play_mastermind()
  play_again()
end

def play_again()
  puts "Play again? Y or N"
  reply = gets.chomp
  reply.downcase
  if reply == "y" || reply == "yes"
    setup_mastermind()
  else
    # Update the scores
    @user_scores[@codemaker.name] += @user_score
    @computer_scores[@codebreaker.name] += @computer_score
    puts "Total scores:"
    @user_scores.each { |player, score| puts "#{player}: #{score}" }
    @computer_scores.each { |player, score| puts "#{player}: #{score}" }
    puts "Thank you for playing. Goodbye."
  end
end

setup_mastermind()
