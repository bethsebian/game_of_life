## Conway's Game of Life

Read all about [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway's_Game_of_Life).

### Capabilities

1.   Transforms all cells in matrix according to Game of Life rules
  *   Any _live_ cell with fewer than two live neighbors dies, as if caused by underpopulation.
  *   Any _live_ cell with two or three live neighbors lives on to the next generation.
  *   Any _live_ cell with more than three live neighbors dies, as if by overpopulation.
  *   Any _dead_ cell with exactly three live neighbors becomes a live cell, as if by reproduction.
2.  Supports multiple transformations for given matrix.
3.  Ensures transformation doesn't incorrectly consider neighbor cells' future conditions when evaluating its own transformation.

### Limitations/Features to Add

1.  Does add new cells and corresponding relationships to neighbors to matrix.
  *   Only cascades through a given matrix of cells.
  *   Can not turn an unoccupied neighbor position to live (or dead for that matter) cell.
2.   Don't love that we traverse the matrix 4 times for every transformation (set_next_condition_all, untouch_all, update_condition_all, untouch_all). Consider alternatives.
3.   Test setup for seed patterns is pretty wonky, time-intensive, and difficult to read.
4.   Runner file with basic command line interface (NICE TO HAVE).
5.   Module featuring of common seed patterns (block, beehive, tub, blinker, glider). These could be used both for testing and as available seeds for CLI user (NICE TO HAVE).
