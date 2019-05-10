// Written by Serena Li
class Board {
  private Tile[][] board;
  private color borderColor;
  private color emptyColor;
  
  /** Initializes a new 4x4 Board with two tiles
   * in random places, and default colors */
  public Board() {
    board = new Tile[4][4];
    reset();
    borderColor = color(188, 173, 162);
    emptyColor = color(206, 193, 181);
  }
  
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
  
  public void draw() {
    int boardWidth = Math.min(width, height);
    int unitsPerTile = 7;
    int tileWidth = boardWidth*(unitsPerTile-1)/(unitsPerTile*4+1);
    fill(borderColor);
    stroke(borderColor);
    rect(0, 0, boardWidth, boardWidth, boardWidth/50);
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        fill(board[row][col] == null ? emptyColor : board[row][col].getColor());
        stroke(board[row][col] == null ? emptyColor : board[row][col].getColor());
        rect(boardWidth*(col*(unitsPerTile)+1)/(unitsPerTile*4+1), boardWidth*(row*(unitsPerTile)+1)/(unitsPerTile*4+1), tileWidth, tileWidth, tileWidth/20);
        if (board[row][col] != null) { // draw the number
          textFont(f, boardWidth/6);
          textAlign(CENTER);
          fill(board[row][col].getFontColor());
          float x = boardWidth*(col*unitsPerTile+unitsPerTile/2.0)/(unitsPerTile*4+1);
          float y = boardWidth*(row*unitsPerTile+unitsPerTile/2.0)/(unitsPerTile*4+1);
          fill(color(12, 12, 12));
          rect(x, y, 4, 4);
          text(""+board[row][col].getValue(), x, y);
        }
      }
    }
      
  }
  
  
  public void swipeRight() {
    // implement the swipe and merge right
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
    addTile(2);
  }
  public void swipeLeft() {
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
    addTile(2);
  }
  public void swipeUp() {
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
          board[rowToCombine-1][col] = new Tile(board[rowToCombine][col].getValue()*2);
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
    addTile(2);
  }
  public void swipeDown() {
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
        if (board[rowToCombine][col].equals(board[rowToCombine+1][col])) {
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
    addTile(2);
  }
  /** Precondition: There must be at least one space open on the board */
  private void addTile(int value) {
    int[] open = new int[16];
    int openCount = 0;
    for (int i = 0; i < 16; i++) {
      if (board[i/4][i%4] == null) {
        open[openCount] = i;
        openCount++;
      }
    }
    int tile = int(random(openCount));
    board[tile/4][tile%4] = new Tile(value);
  }
}
