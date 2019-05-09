// Written by Serena Li
class Board {
  Tile[][] board = new Tile[4][4];
  
  /** Sets the board back to its starting state 
   * (Two "2" tiles in random places) */
  public void reset() {
    int[] randomizer = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
    int rand1 = int(random(16));
    int temp = randomizer[rand1];
    randomizer[rand1] = randomizer[15];
    randomizer[15] = temp;
    int rand2 = randomizer[int(random(15))];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        board[i][i] = null;
      }
    }
    board[rand1 / 4][rand1 % 4] = new Tile(2);
    board[rand2 / 4][rand2 % 4] = new Tile(2);
  }
  
  void swipeRight() {
    for (int row = 0; row < 4; row++) {
      int notFilled = 3;
      for (int col = 3; col >= 0; col--) {
        if (board[row][col] != null) {
          board[row][notFilled] = board[row][col];
          board[row][col] = null;
          notFilled--;
        }
      }
      int colToCombine = 2;
      while (colToCombine >= 0) {
        if (board[row][colToCombine].equals(board[row][colToCombine+1])) {
          board[row][colToCombine+1] = new Tile(board[row][colToCombine].getValue()*2);
          board[row][colToCombine] = null;
          for (int i = colToCombine; i >= 1; i--) {
            board[row][i] = board[row][i-1];
            board[row][i-1] = null;
          }
          colToCombine--; // cannot do a "double" combine
        }
        colToCombine--;
      }
    }
  }
  void swipeLeft() {
    for (int row = 0; row < 4; row++) {
      int notFilled = 0;
      for (int col = 0; col < 4; col++) {
        if (board[row][col] != null) {
          board[row][notFilled] = board[row][col];
          board[row][col] = null;
          notFilled--;
        }
      }
      int colToCombine = 1;
      while (colToCombine <= 3) {
        if (board[row][colToCombine].equals(board[row][colToCombine-1])) {
          board[row][colToCombine-1] = new Tile(board[row][colToCombine].getValue()*2);
          board[row][colToCombine] = null;
          for (int i = colToCombine; i < 3; i++) {
            board[row][i] = board[row][i+1];
            board[row][i+1] = null;
          }
          colToCombine++;
        }
        colToCombine++;
      }
    }
  }
  void swipeUp() {
    for (int col = 0; col < 4; col++) {
      int notFilled = 0;
      for (int row = 0; row < 4; row++) {
        if (board[row][col] != null) {
          board[notFilled][col] = board[row][col];
          board[row][col] = null;
          notFilled++;
        }
      }
      int rowToCombine = 1;
      while (rowToCombine <= 3) {
        if (board[rowToCombine][col].equals(board[rowToCombine-1][col])) {
          board[rowToCombine-1][col] = new Tile(board[rowToCombine][col].getValue()*2));
          board[rowToCombine][col] = null;
          for (int i = rowToCombine; i < 3; i++) {
            board[i][col] = board[i+1][col];
            board[i+1][col] = null;
          }
          rowToCombine++;
        }
        rowToCombine++;
      }
    }
  }
  void swipeDown() {
    for (int col = 0; col < 4; col++) {
      int notFilled = 3;
      for (int row = 3; row >= 0; row--) {
        if (board[row][col] != null) {
          board[notFilled][col] = board[row][col];
          board[row][col] = null;
          notFilled--;
        }
      }
      int rowToCombine = 2; 
      while (rowToCombine >= 0) {
        if (board[rowToCombine][col].equals(board[rowToCombine+1][col]) {
          board[rowToCombine+1][col] = new Tile(board[rowToCombine][col].getValue()*2);
          board[rowToCombine][col] = null;
          for (int i = rowToCombine; i >= 1; i--) {
            board[i][col] = board[i-1][col];
            board[i-1][col] = null;
          }
          rowToCombine--;
        }
        rowToCombine--;
      }
    }
  }
}
