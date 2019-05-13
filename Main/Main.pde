Board board;
PFont f;
void setup() {
  f = loadFont("ProcessingSansPro-Semibold-48");
  board = new Board();
  size(750 , 750);
}
void draw() {
  board.draw();
}
