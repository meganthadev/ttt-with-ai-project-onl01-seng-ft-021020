class Game 
  
  attr_accessor :board, :player_1, :player_2
  
   WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]
  
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end
  
  def current_player
    @board.turn_count.even? ? @player_1 : @player_2
  end 
  
  def won?
    WIN_COMBINATIONS.detect do |combo|
      @board.cells[combo[0]] == @board.cells[combo[1]] &&
      @board.cells[combo[1]] == @board.cells[combo[2]] &&
      @board.taken?(combo[0]+1)
    end
  end 
  
  def winner
    if win_combo = won?
      @winner = @board.cells[win_combo.first]
    end
  end
  
  def start 
    game = Game.new
    until game.won?
     game.play
      end
    puts "\nWelcome to Command Line Tic Tac Toe!"
  puts "\nWhat kind of game will you like to play? Please choose player mode:
  0 - Computer VS Computer
  1 - You VS Computer
  2 - You VS Your friend"

  player_mode = gets.strip

  if player_mode == "1"
    puts "Do you want to go first? [y/ n]"
    if gets.strip == "y"
      Game.new(Players::Human.new("X"), Players::Computer.new("O"), Board.new).play
    else   Game.new(Players::Computer.new("X"), Players::Human.new("O"), Board.new).play
    end

  elsif player_mode == "0"
    Game.new(Players::Computer.new("X"), Players::Computer.new("O"), Board.new).play

  elsif player_mode == "2"
    Game.new(Players::Human.new("X"), Players::Human.new("O"), Board.new).play
  end
  puts "Would like to play again? [y/ n]"


    play_again = gets.strip
    play_again.downcase == "y" || play_again.downcase == "yes"
      game = Game.new
      until game.won?
        game.play
      end
    end
  end 
  
  def play 
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end 
  
  def turn 
    input = current_player.move(board)
      if board.valid_move?(input)
      board.update(input, current_player)
      board.display
    else
      puts "Please enter a valid move"
    turn
    end
  end
  
  
  def over?
    draw? || won?
  end

  def draw?  
    @board.full? && !won?
  end

end    
