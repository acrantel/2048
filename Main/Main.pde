Board board;
boolean runAI;
PlayerAI ai;
PFont f;
void setup() {
  f = loadFont("Corbel-100.vlw");
  board = new Board();
  runAI = false;
  ai = new PlayerAI();
  size(750 , 750);
}
void draw() {
  if (ai) {
  }
  board.draw();
}
