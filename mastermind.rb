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
