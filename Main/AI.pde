class AI {
  public AI() {
  }
  // the number of moves to search ahead by
  private int searchAhead = 2;
  
  public void move(Board brd) {
    long b = 0; //<>//
    for (int r = 0; r < 4; r++) {
      for (int c = 0; c < 4; c++) {
        if (brd.at(r, c) != null) {
          b = replace(b, r, c, (int)(Math.log(brd.at(r, c).getValue())/Math.log(2)));
        }
      }
    } //<>//
    int best = move(b);
    switch (best) {
      case 0: brd.swipeUp(); break;
      case 1: brd.swipeLeft(); break;
      case 2: brd.swipeDown(); break;
      case 3: brd.swipeRight(); break;
      default: System.out.println("Bug in move - reached default move");
    }
  }
   //<>//
  public int move(long brd) {
    int bestMove = 0;
    int bestHeuristic = Integer.MIN_VALUE;
    for (int i = 0; i < 4; i++) {
      long swiped = swipe(brd, i);
      if (swiped != brd) {
        int result = expectiminimax(swipe(brd, i), searchAhead * 2, 1);
        if (result > bestHeuristic) {
          bestHeuristic = result;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }
  
  // higher heuristic value is better //<>//
  /** odd depth means this node is the AI's move,
   * even depth = the game's move (random tile placed) 
   * Returns a value that represents how good the board passed in is*/
  public int expectiminimax(long brd, int depth, double probability) {
    if (depth == 0 || probability < .001) {
      return heuristic(brd);
    } else if (depth % 2 != 0) { // our move
      // return value of maximum-valued child node
      int best = 0;
      for (int i = 0; i < 4; i++) {
        long swipeResult = swipe(brd, i);
        if (brd != swipeResult) {
          best = Math.max(best, expectiminimax(swipe(brd, i), depth-1, probability));
        }
      }
      return best;
    } else { // the computer's random placement of a tile
      // return the weighted average of all child node values
      double avg = 0;
      int emptyCount = 0;
      for (int r = 0; r < 4; r++) {
        for (int c = 0; c < 4; c++) {
          if (valueAt(brd, r, c) == 0) {
            emptyCount++;
            avg += .1*probability * expectiminimax(replace(brd, r, c, 2), depth-1, probability*.1);
            avg += .9*probability * expectiminimax(replace(brd, r, c, 1), depth-1, probability*.9);
          }
        }
      }
      return (int)avg / emptyCount;
    }
  }
  /** Returns how good this board is */
  private int heuristic(long brd) {
    int ans = 0;
    ans += this.blankSpaces(brd) * 10;
    if (valueAt(brd, 0, 0) == 10) {
      ans += 100;
    } else if (valueAt(brd, 0, 0) == 11) {
      ans += 200;
    } else if (valueAt(brd, 0, 0) > 11) {
      ans += 300;
    }
    int maxL = maxLocation(brd);
    int maxRow = maxL / 4;
    int maxCol = maxL % 4;
    long maxRemoved = replace(brd, maxRow, maxCol, 0);
    int maxL2 = maxLocation(maxRemoved);
    int maxRow2 = maxL2 / 4;
    int maxCol2 = maxL2 % 4;
    long maxRemoved2 = replace(maxRemoved, maxRow2, maxCol2, 0);
    int maxL3 = maxLocation(maxRemoved2);
    int maxRow3 = maxL3 / 4;
    int maxCol3 = maxL3 % 4;
    long maxRemoved3 = replace(maxRemoved2, maxRow3, maxCol3, 0);
    int maxL4 = maxLocation(maxRemoved3);
    int maxRow4 = maxL4 / 4;
    int maxCol4 = maxL4 % 4;
    if (maxL == 0) {
      ans += 1000;
      if (valueAt(brd, 1, 0) >= valueAt(brd, 0, 0) - 2 || valueAt(brd, 0, 1) >= valueAt(brd, 0, 0) - 2) { ans += 50; }
    } else {
      ans -= 100;
    }
    if (valueAt(brd, 1, 0) <= valueAt(brd, 0, 0) - 2 || valueAt(brd, 0, 1) <= valueAt(brd, 0, 0) - 2) {
      ans -= 100;
    }
    ans -= Math.abs(maxRow - maxRow2) == 1 && Math.abs(maxCol - maxCol2) == 1 ? 200 : 0;
    ans -= Math.abs(maxRow - maxRow3) == 1 && Math.abs(maxCol - maxCol3) == 1 ? 200 : 0;
    ans += Math.abs(maxRow - maxRow2) == 1 && Math.abs(maxCol - maxCol2) == 0 ? 300 : 0;
    ans += Math.abs(maxRow - maxRow2) == 0 && Math.abs(maxCol - maxCol2) == 1 ? 300 : 0;
    ans += Math.abs(maxRow3 - maxRow2) == 1 && Math.abs(maxCol3 - maxCol2) == 0 ? 200 : 0;
    ans += Math.abs(maxRow3 - maxRow2) == 0 && Math.abs(maxCol3 - maxCol2) == 1 ? 200 : 0;
    ans += Math.abs(maxRow3 - maxRow4) == 1 && Math.abs(maxCol3 - maxCol4) == 0 ? 100 : 0;
    ans += Math.abs(maxRow3 - maxRow4) == 0 && Math.abs(maxCol3 - maxCol4) == 1 ? 100 : 0;
    
    ans += valueAt(brd, 3, 3) <= 1 ? 10 : 0;
    ans += valueAt(brd, 3, 2) <= 1 ? 9 : 0;
    ans += valueAt(brd, 2, 3) <= 1 ? 9 : 0;
    ans += valueAt(brd, 2, 2) <= 2 ? 8 : 0;
    ans += valueAt(brd, 1, 3) <= 2 ? 8 : 0;
    ans += valueAt(brd, 3, 1) <= 2 ? 8 : 0;
    int maxMergesPossible = 0;
    for (int i = 0; i < 4; i++) {
      int res = getMerges(brd, i);
      if (res > maxMergesPossible) {
        maxMergesPossible = res;
      }
    }
    ans += Math.pow(2, maxMergesPossible) * 10; 
    
    for (int sum = 0; sum <= 6; sum++) {
      for (int r = 0; r <= 3; r++) {
        int c = sum - r;
        if (c >= 0 && c <= 3) {
          ans += r+1 <= 3 && valueAt(brd, r+1, c) <= valueAt(brd, r, c) ? 50 : 0;
          ans += r+1 <= 3 && c+1 <= 3 && valueAt(brd, r+1, c+1) <= valueAt(brd, r, c) ? 50 : 0;
          ans += c+1 <= 3 && valueAt(brd, r, c+1) <= valueAt(brd, r, c) ? 50 : 0;
        }
      }
    }
    return ans;
  } //<>//
  
  private int getMerges(long brd, int dir) {
    long res = swipe(brd, dir);
    int beforeCount = 0;
    int afterCount = 0;
    for (int r = 0; r < 4; r++) {
      for (int c = 0; c < 4; c++) {
        beforeCount = valueAt(brd, r, c) != 0 ? 1 : 0;
        afterCount = valueAt(res, r, c) != 0 ? 1 : 0;
      }
    }
    return afterCount - beforeCount;
  }
  
  /** 0  1  2  3
   *  4  5  6  7
   *  8  9  10 11
   *  12 13 14 15 
   * Returns the location of the maximum value in the board, searching row by row */
  private int maxLocation(long brd) {
    int maxLoc = 0;
    int maxNum = 0;
    for (int r = 0; r < 4; r++) {
      for (int c = 0; c < 4; c++) {
        if (valueAt(brd, r, c) > maxNum) {
          maxNum = valueAt(brd, r, c);
          maxLoc = r*4 + c;
        }
      }
    }
    return maxLoc;
  }
  
  private int blankSpaces(long brd) {
    int ans = 0;
    for (int r = 0; r < 4; r++) {
      for (int c = 0; c < 4; c++) {
        if (valueAt(brd, r, c) == 0) {
          ans++;
        }
      }
    }
    return ans;
  }
  
  /** Replaces the 4 bit section at row/col with the least 4 bits of toReplace.
   * Rows and columns start counting from 0. */
  private long replace(long brd, int row, int col, int toReplace) {
    return (brd & (~(15L << ((row*4+col)*4))) ) | ((toReplace & 15L) << ((row*4+col)*4));
  }
  
  /** Returns the value at brd[row][col] */
  private int valueAt(long brd, int row, int col) {
    return (int)((brd >>> ((row*4+col)*4)) & 15L);
  }
  
  public long swipe(long brd, int dir) {
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
          brd = replace(brd, r, colToCombine+1, valueAt(brd, r, colToCombine)+1);
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
    for (int row = 0; row < 4; row++) {
      int notFilled = 0; 
      for (int col = 0; col < 4; col++) {
        if (valueAt(brd, row, col) != 0) {
          int temp = valueAt(brd, row, col);
          brd = replace(brd, row, col, 0);
          brd = replace(brd, row, notFilled, temp);
          notFilled++;
        }
      }
      int colToCombine = 1;
      while (colToCombine <= 3) {
        if (valueAt(brd, row, colToCombine) != 0 && valueAt(brd, row, colToCombine) == valueAt(brd, row, colToCombine-1)) {
          brd = replace(brd, row, colToCombine-1, valueAt(brd, row, colToCombine)+1);
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
          brd = replace(brd, rowToCombine-1, col, valueAt(brd, rowToCombine, col)+1);
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
          brd = replace(brd, rowToCombine+1, col, valueAt(brd, rowToCombine, col)+1);
          brd = replace(brd, rowToCombine, col, 0);
          for (int i = rowToCombine; i >= 1; i--) {
            brd = replace(brd, i, col, valueAt(brd, i-1, col));
            brd = replace(brd, i-1, col, 0);
          }
        }
        rowToCombine--;
      }
    }
    return brd;
  }
  
}
