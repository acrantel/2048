// expectiminimax? https://stackoverflow.com/questions/22342854/what-is-the-optimal-algorithm-for-the-game-2048/22498940#22498940
class PlayerAI {
  public PlayerAI() {
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
  
  public void step() {
  }
  
  public int merges(Move move, long brd) {
    return 0;
  }
  
  public long swipe(int dir, long brd) {
    for (int row = 0; row < 4; row++) {
      int notFilled = 3;
      for (int col = 3; col > 0; col--) {
        
      }
    }
    return 0;
  }
  /** Replaces the 4 bit section at row/col with the least 4 bits of toReplace.
   * Rows and columns start counting from 0. */
  private long replace(long brd, int row, int col, int toReplace) {
    return (brd & (~(15 << ((row*4+col)*4))) ) | ((toReplace & 15) << ((row*4+col)*4));
  }
  
  private int valueAt(long brd, int row, int col) {
    return (int)(brd >>> ((row*4+col)*4)) & 15;
  }
  public long swipeRight(long brd) {
    for (int r = 0; r < 4; r++) {
      int notFilled = 3;
      for (int c = 3; c >= 0; c--) {
        int tileVal = valueAt(brd, r, c);
        if (tileVal != 0) {
          replace(brd, r, c, 0);
          replace(brd, r, notFilled, tileVal);
          notFilled--;
        }
      }
      int colToCombine = 2;
      while (colToCombine >= 0) {
        if (valueAt(brd, r, colToCombine) != 0 && valueAt(brd, r, colToCombine) == valueAt(brd, r, colToCombine+1)) {
          replace(brd, r, colToCombine+1, valueAt(brd, r, colToCombine)*2);
          replace(brd, r, colToCombine, 0);
          for (int i = colToCombine; i >= 1; i--) {
            replace(brd, r, i, valueAt(brd, r, i-1));
            replace(brd, r, i-1, 0);
          }
        }
        colToCombine--;
      }
    }
    return brd;
  }
  public long swipeLeft(long brd) {
    for (int row = 0; row < 4; row++) {
      int notFilled = 0; 
      for (int col = 0; col < 4; col++) {
        if (valueAt(brd, row, col) == 0) {
          int temp = valueAt(brd, row, col);
          replace(brd, row, col, 0);
          replace(brd, row, notFilled, temp);
          notFilled++;
        }
      }
      int colToCombine = 1;
      while (colToCombine <= 3) {
        if (valueAt(brd, row, colToCombine) != 0 && valueAt(brd, row, colToCombine) == valueAt(brd, row, colToCombine-1)) {
          replace(brd, row, colToCombine-1, valueAt(brd, row, colToCombine)*2);
          replace(brd, row, colToCombine, 0);
          for (int i = colToCombine; i < 3; i++) {
            replace(brd, row, i, valueAt(brd, row, i+1);
            replace(brd, row, i+1, 0);
          }
        }
        colToCombine++;
      }
    }
    return brd;
  }
  
  //public void swipeUp() {
  //  boolean edited = false;
  //  for (int col = 0; col < 4; col++) {
  //    int notFilled = 0;
  //    for (int row = 0; row < 4; row++) {
  //      if (board[row][col] != null) {
  //        Tile temp = board[row][col];
  //        board[row][col] = null;
  //        board[notFilled][col] = temp;
  //        if (row != notFilled) {
  //          edited = true;
  //        }
  //        notFilled++;
  //      }
  //    }
  //    int rowToCombine = 1;
  //    while (rowToCombine <= 3) {
  //      if (board[rowToCombine][col] != null && board[rowToCombine][col].equals(board[rowToCombine-1][col])) {
  //        board[rowToCombine-1][col] = new Tile(board[rowToCombine][col].getValue()*2);
  //        board[rowToCombine][col] = null;
  //        for (int i = rowToCombine; i < 3; i++) {
  //          board[i][col] = board[i+1][col];
  //          board[i+1][col] = null;
  //        }
  //        edited = true;
  //      }
  //      rowToCombine++;
  //    }
  //  }
  //  if (edited) {
  //    addTiles();
  //  }
  //}
}
