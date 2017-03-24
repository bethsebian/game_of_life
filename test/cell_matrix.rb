module CellMatrix
  # ..................................................
  # |  01  |  02  |  03  |  04  |  05  |  06  |  07  |
  # ..................................................
  # |  08  |  09  |  10  |  11  |  12  |  13  |  14  |
  # ..................................................
  # |  15  |  16  |  17  |  18  |  19  |  20  |  21  |
  # ..................................................
  # |  22  |  23  |  24  |  25  |  26  |  27  |  28  |
  # ..................................................
  # |  29  |  30  |  31  |  32  |  33  |  34  |  35  |
  # ..................................................
  # |  36  |  37  |  38  |  39  |  40  |  41  |  42  |
  # ..................................................
  # |  43  |  44  |  45  |  46  |  47  |  48  |  49  |
  # ..................................................

  def cell_matrix
    cells = (1..49).map { |num| [num, Cell.new] }.to_h
    connect_neighbors(cells)
    cells
  end

  def connect_neighbors(cells)
    cells.each do |pos, cell|
      cell.introduce_neighbors(neighbors(cells, pos, cell))
    end
  end

  def neighbors(cells, pos, cell)
    neighbors = {}
    neighbors[:top_left]      = cells[pos-8] unless top_boundary?(pos) || left_boundary?(pos)
    neighbors[:top_center]    = cells[pos-7] unless top_boundary?(pos)
    neighbors[:top_right]     = cells[pos-6] unless top_boundary?(pos) || right_boundary?(pos)
    neighbors[:left]          = cells[pos-1] unless left_boundary?(pos)
    neighbors[:right]         = cells[pos+1] unless right_boundary?(pos)
    neighbors[:bottom_left]   = cells[pos+6] unless bottom_boundary?(pos) || left_boundary?(pos)
    neighbors[:bottom_center] = cells[pos+7] unless bottom_boundary?(pos)
    neighbors[:bottom_right]  = cells[pos+8] unless bottom_boundary?(pos) || right_boundary?(pos)
    neighbors
  end

  def top_boundary?(pos)
    (0..7).to_a.include?(pos)
  end

  def bottom_boundary?(pos)
    (43..49).to_a.include?(pos)
  end

  def left_boundary?(pos)
    [1,8,15,22,29,36,43].to_a.include?(pos)
  end

  def right_boundary?(pos)
    [7,14,21,28,35,42,49].to_a.include?(pos)
  end

  def glider_matrix
    # [2,10,15,16,17]
    cells = cell_matrix
    cells[2].rouse
    cells[10].rouse
    cells[15].rouse
    cells[16].rouse
    cells[17].rouse
    cells
  end

  def beacon_matrix
    # [9,10,16,26,32,33]
    cells = cell_matrix
    cells[9].rouse
    cells[10].rouse
    cells[16].rouse
    cells[26].rouse
    cells[32].rouse
    cells[33].rouse
    cells
  end

  def beehive_matrix
    # [18,19,24,27,32,33]
    cells = cell_matrix
    cells[18].rouse
    cells[19].rouse
    cells[24].rouse
    cells[27].rouse
    cells[32].rouse
    cells[33].rouse
    cells
  end

  def block_matrix
    # [25,26,32,33]
    cells = cell_matrix
    cells[25].rouse
    cells[26].rouse
    cells[32].rouse
    cells[33].rouse
    cells
  end
end
