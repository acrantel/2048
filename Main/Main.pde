Board board;
PFont f;
void setup() {
  f = loadFont("ProcessingSansPro-Semibold-100.vlw");
  board = new Board();
  size(750 , 750);
}
void draw() {
  board.draw();
}
