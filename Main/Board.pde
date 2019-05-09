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
    board[rand1 / 4][rand1 % 4] = Tile.getTile(2);
    board[rand1 / 4][rand1 % 4] = Tile.getTile(2);
  }
  
  void swipeRight() {
    
  }
  void swipeLeft() {
  }
  void swipeUp() {
  }
  void swipeDown() {
  }
}
