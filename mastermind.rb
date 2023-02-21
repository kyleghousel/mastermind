require 'colorize'
require_relative 'startup.rb'
include TitleScreen, Instructions

peg_one = "   1   ".black.on_light_red
peg_two = "   2   ".black.on_light_yellow
peg_three = "   3   ".black.on_light_green
peg_four = "   4   ".black.on_cyan
peg_five = "   5   ".black.on_light_blue
peg_six = "   6   ".black.on_magenta

TitleScreen::display_title
Instructions::print_instructions


class Mastermind
  attr_reader :codemaker, :codebreaker, :code
  def initialize(codemaker, codebreaker, code)
    @codemaker = codemaker
    @codebreaker = codebreaker
    @code = code
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
      computer_code << rand_num + 1
      end
    end
    p computer_code
  end
end

class Codebreaker
  attr_reader :name
  def initialize(name)
    @name = name
  end 
end

def play_mastermind()
  puts "Would you like to play as the Codemaker or the Codebreaker?"
  user_response = gets.chomp
  #until user_response.downcase == "codemaker" || user_response.downcase == "codebreaker" do
    if user_response.downcase == "codemaker"
      puts "Enter your name:"
      name1 = gets.chomp
      codemaker = Codemaker.new(name1)
      name2 = "Computer"
      puts "You are playing against #{name2}"
      codebreaker = Codebreaker.new(name2)
      code = codemaker.player_code_create()
      play = Mastermind.new(codemaker, codebreaker, code)
    elsif user_response.downcase == "codebreaker"
      puts "Enter your name:"
      name1 = gets.chomp
      codebreaker = Codebreaker.new(name1)
      name2 = "Computer"
      puts "You are playing against #{name2}"
      codemaker = Codemaker.new(name2)
      code = codemaker.computer_code_create()
      play = Mastermind.new(codemaker, codebreaker, code)
    else
      puts "Invalid response. Try again."
      play_mastermind()
    end
  #end 
end

play_mastermind()



