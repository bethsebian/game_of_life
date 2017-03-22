require './lib/game'

game = Game.new
run = true

while run == true
  puts "Enter 't' to create life. Enter 'end' to end it all."
  input = gets.chomp
  if input == "t"
    game.transform
    puts game.alive_cells_count
  end
  if input == "end"
    run = false
  end
end
