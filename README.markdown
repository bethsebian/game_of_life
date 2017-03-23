## Conway's Game of Life

Read all about [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway's_Game_of_Life).

### Capabilities

1.  Transforms all cells in matrix according to Game of Life rules
    *   Any _live_ cell with fewer than two live neighbors dies, as if caused by underpopulation.
    *   Any _live_ cell with two or three live neighbors lives on to the next generation.
    *   Any _live_ cell with more than three live neighbors dies, as if by overpopulation.
    *   Any _dead_ cell with exactly three live neighbors becomes a live cell, as if by reproduction.
2.  Supports multiple transformations for given matrix.
3.  Ensures transformation doesn't incorrectly consider neighbor cells' future conditions when evaluating its own transformation.

### Limitations/Features to Add

1.  Develop ability to add new cells and corresponding neighbor relationships where appropriate.
    *   Current cell only cascades through a given matrix of cells.
    *   Current cell cannot turn an unoccupied neighbor position to live cell (this ability is necessary for matrix to reflect full growth).
2.  Consider alternatives for traversing the matrix 4 times for every transformation (set_next_condition_all, untouch_all, update_condition_all, untouch_all).
3.  Clean up test seeding. Arrangement has some pretty wonky, time-intensive, and difficult to read setups.
4.  Add runner file with basic command line interface (NICE TO HAVE).
5.  Create module featuring of common seed patterns (block, beehive, tub, blinker, glider). These could be used both for testing and as available seeds for CLI user (NICE TO HAVE).
