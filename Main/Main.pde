Board board;
PFont f;
void setup() {
  f = loadFont("Corbel-100.vlw");
  board = new Board();
  size(1024, 768);
}
void draw() {
  board.draw();
}
