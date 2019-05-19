// Written by Serena Li
class Board {
  private Tile[][] board;
  private color borderColor;
  private color emptyColor;
  private color outsideColor;
  private int moves;
  private int score;
  
  /** Initializes a new 4x4 Board with two tiles
   * in random places, and default colors */
  public Board() {
    board = new Tile[4][4];
    reset();
    borderColor = color(188, 173, 162);
    emptyColor = color(206, 193, 181);
    outsideColor = color(251, 249, 240);
    moves = 0;
  }
  
  public Tile at(int r, int c) {
    return board[r][c];
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
  
  public void drawBoard() {
    textFont(f);
    textAlign(CENTER, CENTER);
    int boardWidth = Math.min(width * 3/4, height);
    int unitsPerTile = 7;
    int tileWidth = boardWidth*(unitsPerTile-1)/(unitsPerTile*4+1);
    int defaultTextSize = (int)(tileWidth*.6);
    fill(outsideColor);
    stroke(outsideColor);
    rect(0, 0, width, height);
    fill(borderColor);
    stroke(borderColor);
    rectMode(CORNER);
    rect(0, 0, boardWidth, boardWidth, boardWidth/50);
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        rectMode(CORNER);
        if (board[row][col] == null) {
          fill(emptyColor);
          stroke(emptyColor);
          rect(boardWidth*(col*(unitsPerTile)+1)/(unitsPerTile*4+1), boardWidth*(row*(unitsPerTile)+1)/(unitsPerTile*4+1), tileWidth, tileWidth, tileWidth/20);
        } else {
          board[row][col].drawTile(boardWidth*(col*(unitsPerTile)+1)/(unitsPerTile*4+1), boardWidth*(row*(unitsPerTile)+1)/(unitsPerTile*4+1), tileWidth, tileWidth, tileWidth/20, defaultTextSize);
        }
      }
    }
    // draw the # of moves and the score
    fill(color(104, 89, 81));
    rectMode(CORNER);
    textAlign(CENTER, CENTER);
    textSize((width - boardWidth)/4);
    text("Moves\n" + getMoves(), boardWidth, boardWidth/6, width - boardWidth, width - boardWidth);
    text("Score\n" + getScore(), boardWidth, boardWidth*1/2, width - boardWidth, width - boardWidth);
    textSize(15);
    text(""+ai.transposition.size(), boardWidth, boardWidth * 5/6);
      
  }
  /** Returns the number of points from this swipe (each merge is worth points) */
  public void swipeRight() {
    int points = 0;
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
      // do merges
      int colToCombine = 2;
      while (colToCombine >= 0) {
        if (board[row][colToCombine] != null && board[row][colToCombine].equals(board[row][colToCombine+1])) {
          points += board[row][colToCombine].getValue()*2;
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
    score += points;
  }
  /** Returns the number of points from this swipe (each merge is worth points) */
  public void swipeLeft() {
    int points = 0;
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
          points += board[row][colToCombine].getValue()*2;
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
    score += points;
  }
  
  /** Returns the number of points from this swipe (each merge is worth points) */
  public void swipeUp() {
    int points = 0;
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
          points += board[rowToCombine][col].getValue()*2;
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
    score += points;
  }
  
  /** Returns the number of points from this swipe (each merge is worth points) */
  public void swipeDown() {
    int points = 0;
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
          points += board[rowToCombine][col].getValue()*2;
          board[rowToCombine+1][col] = new Tile(board[rowToCombine][col].getValue()*2);
          board[rowToCombine][col] = null;
          for (int i = rowToCombine; i >= 1; i--) {
            board[i][col] = board[i-1][col];
            board[i-1][col] = null;
          }
          edited = true;
        }
        rowToCombine--;
      }
    }
    if (edited) {
      addTiles();
    }
    score += points;
  }
  // Checks if the game is over
  public boolean gameOver() {
    boolean over = true;
    for (int r = 0; r <= 3; r++) {
      for (int c = 0; c <= 3; c++) {
        if (board[r][c] == null) {
          over = false;
        } else {
          if (r <= 2) {
            over = board[r][c].equals(board[r+1][c]) ? false : over;
          }
          if (c <= 2) {
            over = board[r][c].equals(board[r][c+1]) ? false : over;
          }
        }
      }
    }
    return over;
  }
  
  public void addMove() {
    moves++;
  }
  public int getMoves() {
    return moves;
  }
  public int getScore() {
    return score;
  }
  /** Precondition: There must be at least one space open on the board */
  private void addTiles() {
    int valToAdd = random(1) > .1 ? 2 : 4;
    int[] open = new int[16];
    int openCount = 0;
    for (int i = 0; i < 16; i++) {
      if (board[i/4][i%4] == null) {
        open[openCount] = i;
        openCount++;
      }
    }
    if (openCount != 0) {
      int tile = int(random(openCount));
      board[open[tile]/4][open[tile]%4] = new Tile(valToAdd);
    }
  }
}
