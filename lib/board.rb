class Board
  
  attr_accessor :cells
  
  def initialize
    self.reset!
  end
  
  def reset!
    @cells = Array.new(9, " ")
  end
  
  def display
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "-----------"
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "-----------"
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end 
  
  def position(input)
    cells[input.to_i-1]
  end 
  
  def update(input, player) 
    input = input.to_i-1
    cells[input] = player.token
  end   
  
  def full?
    cells.all? {|token| token == "X" || token == "O" }
  end   
  
  def turn_count
    counter = 0
    cells.each {|x| if x != " " then counter +=1 end}
    counter
  end  
  
  def taken?(input)
    !(position(input) == " " || position(input) == "")
  end
  
  def valid_move?(input)
    !taken?(input) && input.to_i.between?(1,9) ? true : false
  end   
  
end   