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
    

    play_again = ""
      until play_again.downcase == "n" || play_again.downcase == "no"
    puts "Would you like to play again?"
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
