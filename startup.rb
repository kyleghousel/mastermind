require 'colorize'

module TitleScreen
    
  def display_title
    puts "  
 _____________________________________________________________________________________________
|                                                                                             |
|    ███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗██████╗      |
|    ████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗     |
|    ██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║██║  ██║     |
|    ██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██║  ██║     |
|    ██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██████╔╝     |
|    ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝      |
|                                                                github.com/kyleghousel/      |
|_____________________________________________________________________________________________|
".light_green
  end

end

module Instructions

  def print_instructions
    puts "Welcome to Mastermind. Let's get started.".light_green
    puts "
    How To Play:

    One player becomes the codemaker, the other the codebreaker. The codemaker chooses a pattern of four code pegs (1-6). 
    Players decide in advance whether duplicates and spaces are allowed (Game Difficulty). If so, the codemaker may even choose four same-colored 
    code pegs or four blanks.  The codemaker enters the chosen pattern in the input field in the console when prompted, 
    visible to the codemaker but not to the codebreaker.

    The codebreaker tries to guess the pattern, in both order and color, within twelve turns. Each guess is made by placing a row of 
    code pegs on the decoding board. Once placed, the codemaker provides feedback by displaying from zero to four key pegs, depicted by a key peg 
    ● or ○ in the terminal output. A ● is placed for each code peg from the guess which is correct in both color and position. A ○ indicates the 
    existence of a correct color code peg placed in the wrong position.
    
    If there are duplicate colors in the guess, they cannot all be awarded a key peg unless they correspond to the same number of duplicate 
    colors in the hidden code. For example, if the hidden code is red-red-blue-blue and the player guesses red-red-red-blue, the codemaker 
    will award two colored key pegs for the two correct reds, nothing for the third red as there is not a third red in the code, and a colored 
    key peg for the blue. No indication is given of the fact that the code also includes a second blue.
    
    Once feedback is provided, another guess is made; guesses and feedback continue to alternate until either the codebreaker guesses correctly, 
    or all rows on the decoding board are full.
    
    Traditionally, players can only earn points when playing as the codemaker. The codemaker gets one point for each guess the codebreaker makes. 
    An extra point is earned by the codemaker if the codebreaker is unable to guess the exact pattern within the given number of turns. 
    (An alternative is to score based on the number of key pegs placed.) The winner is the one who has the most points after the agreed-upon 
    number of games are played.

    '(Mastermind (board game)', Wikipedia, https://en.wikipedia.org/wiki/Mastermind_(board_game)".light_green
  end

end