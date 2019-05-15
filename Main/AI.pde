// expectiminimax? https://stackoverflow.com/questions/22342854/what-is-the-optimal-algorithm-for-the-game-2048/22498940#22498940
class AI {
  public AI() {
  }
  
  // higher heuristic value is better
  /** even depth means this node is the AI's move,
   * odd depth = the game's move (random tile placed) */
  public int expectiminimax(long brd, int depth) {
    if (depth == 0) {
      return heuristic(brd);
    } else if (depth % 2 == 0) { // our move
      // check all possible moves (wasd) and choose the one that maximizes the heuristic value
      for (int i = 0; i < 4; i++) {
      }
    }
    return 0;
  }
  private int heuristic(long brd) {
    return 0;
  }
  
  /** Replaces the 4 bit section at row/col with the least 4 bits of toReplace.
   * Rows and columns start counting from 0. */
  private long replace(long brd, int row, int col, int toReplace) {
    return (brd & (~(15 << ((row*4+col)*4))) ) | ((toReplace & 15) << ((row*4+col)*4));
  }
  
  /** Returns the value at brd[row][col] */
  private int valueAt(long brd, int row, int col) {
    return (int)(brd >>> ((row*4+col)*4)) & 15;
  }
  
  public long swipe(int dir, long brd) {
    // ugly way of swiping in different directions for now
    switch (dir) {
      case 0: return swipeUp(brd);
      case 1: return swipeLeft(brd);
      case 2: return swipeDown(brd);
      case 3: return swipeRight(brd);
      default: return 0;
    }
  }
  
  public long swipeRight(long brd) {
    for (int r = 0; r < 4; r++) {
      int notFilled = 3;
      for (int c = 3; c >= 0; c--) {
        int tileVal = valueAt(brd, r, c);
        if (tileVal != 0) {
          brd = replace(brd, r, c, 0);
          brd = replace(brd, r, notFilled, tileVal);
          notFilled--;
        }
      }
      int colToCombine = 2;
      while (colToCombine >= 0) {
        if (valueAt(brd, r, colToCombine) != 0 && valueAt(brd, r, colToCombine) == valueAt(brd, r, colToCombine+1)) {
          brd = replace(brd, r, colToCombine+1, valueAt(brd, r, colToCombine)*2);
          brd = replace(brd, r, colToCombine, 0);
          for (int i = colToCombine; i >= 1; i--) {
            brd = replace(brd, r, i, valueAt(brd, r, i-1));
            brd = replace(brd, r, i-1, 0);
          }
        }
        colToCombine--;
      }
    }
    return brd;
  }
  
  public long swipeLeft(long brd) {
    for (int row = 0; row < 4; row++) { //<>//
      int notFilled = 0; 
      for (int col = 0; col < 4; col++) {
        if (valueAt(brd, row, col) == 0) {
          int temp = valueAt(brd, row, col);
          brd = replace(brd, row, col, 0);
          brd = replace(brd, row, notFilled, temp);
          notFilled++;
        }
      }
      int colToCombine = 1;
      while (colToCombine <= 3) {
        if (valueAt(brd, row, colToCombine) != 0 && valueAt(brd, row, colToCombine) == valueAt(brd, row, colToCombine-1)) {
          brd = replace(brd, row, colToCombine-1, valueAt(brd, row, colToCombine)*2);
          brd = replace(brd, row, colToCombine, 0);
          for (int i = colToCombine; i < 3; i++) {
            brd = replace(brd, row, i+1, 0);
          }
        }
        colToCombine++;
      }
    }
    return brd;
  }
  
  public long swipeUp(long brd) {
    for (int col = 0; col < 4; col++) {
      int notFilled = 0;
      for (int row = 0; row < 4; row++) {
        if (valueAt(brd, row, col) != 0) {
          int temp = valueAt(brd, row, col);
          brd = replace(brd, row, col, 0);
          brd = replace(brd, notFilled, col, temp);
          notFilled++;
        }
      }
      int rowToCombine = 1;
      while (rowToCombine <= 3) {
        if (valueAt(brd, rowToCombine, col) != 0 && valueAt(brd, rowToCombine, col) == valueAt(brd, rowToCombine-1, col)) {
          brd = replace(brd, rowToCombine-1, col, valueAt(brd, rowToCombine, col));
          brd = replace(brd, rowToCombine, col, 0);
          for (int i = rowToCombine; i < 3; i++) {
            brd = replace(brd, i, col, valueAt(brd, i+1, col));
            brd = replace(brd, i+1, col, 0);
          }
        }
          rowToCombine++;
      }
    }
    return brd;
  }
  
  public long swipeDown(long brd) {
    for (int col = 0; col < 4; col++) {
      int notFilled = 3;
      for (int row = 3; row >= 0; row--) {
        if (valueAt(brd, row, col) != 0) {
          int temp = valueAt(brd, row, col);
          brd = replace(brd, row, col, 0);
          brd = replace(brd, notFilled, col, temp);
          notFilled--;
        }
      }
      int rowToCombine = 2; 
      while (rowToCombine >= 0) {
        if (valueAt(brd, rowToCombine, col) != 0 && valueAt(brd, rowToCombine, col) == valueAt(brd, rowToCombine+1, col)) {
          brd = replace(brd, rowToCombine+1, col, valueAt(brd, rowToCombine, col)*2);
          brd = replace(brd, rowToCombine, col, 0);
          for (int i = rowToCombine; i >= 1; i--) {
            brd = replace(brd, i, col, valueAt(brd, i-1, col));
            brd = replace(brd, i-1, col, 0);
          }
          rowToCombine--;
        }
      }
    }
    return brd;
  }
  
}
