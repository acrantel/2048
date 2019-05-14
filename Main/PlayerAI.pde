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
      for (int i = 0; i < 
    }
    return 0;
  }
  private int heuristic(long brd) {
    return 0;
  }
  
  public void step() {
  }
  
  private int merges(Move move, long brd) {
    return 0;
  }
  private long swipe(int dir, long brd) {
    for (int row = 0; row < 4; row++) {
      int notFilled = 3;
      for (int col = 3; col > 0; col--) {
      }}
  }
  private long replace(long brd, int row, int col, int toReplace) {
    return 
  }
  
  
  public void swipeRight() {
    boolean edited = false;
    // implement the swipe and merge right
    for (int row = 0; row < 4; row++) {
      int notFilled = 3;
      for (int col = 3; col >= 0; col--) {
        if (board[row][col] != null) {
          Tile temp = board[row][col];
          board[row][col] = null;
          board[row][notFilled] = temp;
          if (col != notFilled) {
            edited = true;
          }
          notFilled--;
        }
      }
      int colToCombine = 2;
      while (colToCombine >= 0) {
        if (board[row][colToCombine] != null && board[row][colToCombine].equals(board[row][colToCombine+1])) {
          board[row][colToCombine+1] = new Tile(board[row][colToCombine].getValue()*2);
          board[row][colToCombine] = null;
          for (int i = colToCombine; i >= 1; i--) {
            board[row][i] = board[row][i-1];
            board[row][i-1] = null;
          }
          edited = true;
        }
        colToCombine--;
      }
    }
    if (edited) {
      addTiles();
    }
  }
  public void swipeLeft() {
    boolean edited = false;
    for (int row = 0; row < 4; row++) {
      int notFilled = 0;
      for (int col = 0; col < 4; col++) {
        if (board[row][col] != null) {
          Tile temp = board[row][col];
          board[row][col] = null;
          board[row][notFilled] = temp;
          if (notFilled != col) {
            edited = true;
          }
          notFilled++;
        }
      }
      int colToCombine = 1;
      while (colToCombine <= 3) {
        if (board[row][colToCombine] != null && board[row][colToCombine].equals(board[row][colToCombine-1])) {
          board[row][colToCombine-1] = new Tile(board[row][colToCombine].getValue()*2);
          board[row][colToCombine] = null;
          for (int i = colToCombine; i < 3; i++) {
            board[row][i] = board[row][i+1];
            board[row][i+1] = null;
          }
          edited = true;
        }
        colToCombine++;
      }
    }
    if (edited) {
      addTiles();
    }
  }
  public void swipeUp() {
    boolean edited = false;
    for (int col = 0; col < 4; col++) {
      int notFilled = 0;
      for (int row = 0; row < 4; row++) {
        if (board[row][col] != null) {
          Tile temp = board[row][col];
          board[row][col] = null;
          board[notFilled][col] = temp;
          if (row != notFilled) {
            edited = true;
          }
          notFilled++;
        }
      }
      int rowToCombine = 1;
      while (rowToCombine <= 3) {
        if (board[rowToCombine][col] != null && board[rowToCombine][col].equals(board[rowToCombine-1][col])) {
          board[rowToCombine-1][col] = new Tile(board[rowToCombine][col].getValue()*2);
          board[rowToCombine][col] = null;
          for (int i = rowToCombine; i < 3; i++) {
            board[i][col] = board[i+1][col];
            board[i+1][col] = null;
          }
          edited = true;
        }
        rowToCombine++;
      }
    }
    if (edited) {
      addTiles();
    }
  }
  public void swipeDown() {
    boolean edited = false;
    for (int col = 0; col < 4; col++) {
      int notFilled = 3;
      for (int row = 3; row >= 0; row--) {
        if (board[row][col] != null) {
          Tile temp = board[row][col];
          board[row][col] = null;
          board[notFilled][col] = temp;
          if (notFilled != row) {
            edited = true;
          }
          notFilled--;
        }
      }
      int rowToCombine = 2; 
      while (rowToCombine >= 0) {
        if (board[rowToCombine][col] != null && board[rowToCombine][col].equals(board[rowToCombine+1][col])) {
          board[rowToCombine+1][col] = new Tile(board[rowToCombine][col].getValue()*2);
          board[rowToCombine][col] = null;
          for (int i = rowToCombine; i >= 1; i--) {
            board[i][col] = board[i-1][col];
            board[i-1][col] = null;
          }
          edited = true;
          rowToCombine--;
        }
      }
    }
    if (edited) {
      addTiles();
    }
  }
}
