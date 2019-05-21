import java.util.Map;
PFont f;
AI ai;
Board[] boards;
int succeed = 0;
int fail = 0;
boolean isAllGameOverStopped = false;
void setup() {
  f = loadFont("ProcessingSansPro-Semibold-100.vlw");
  ai = new AI();
  boards = new Board[20];
  for (int i = 0; i < boards.length; i++) {
    boards[i] = new Board();
  }
}
void draw() {
  boolean allGameOver = true;
  for (int i = 0; i < boards.length; i++) {
    if (!boards[i].gameOver()) {
      allGameOver = false;
      ai.move(boards[i]);
      if (boards[i].gameOver()) {
        int largest = getLargest(boards[i]);
        System.out.println(largest);
        if (largest >= 2048) {
          succeed++;
        } else {
          fail++;
        }
      }
    }
  }
  if (allGameOver && !isAllGameOverStopped) {
    System.out.println("Suceed: " + succeed);
    System.out.println("Fail: " + fail);
    isAllGameOverStopped = true;
  }
}

int getLargest(Board brd) {
  int largest = 0;
  for (int r = 0; r < 4; r++) {
    for (int c = 0; c < 4; c++) {
      largest = Math.max(largest, brd.at(r, c).getValue());
    }
  }
  return largest;
}
