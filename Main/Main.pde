Board mainBoard;
PFont f;
AI ai;
void setup() {
  f = loadFont("ProcessingSansPro-Semibold-100.vlw");
  mainBoard = new Board();
  size(750 , 750);
  ai = new AI();
  
}
void draw() {
  ai.move(mainBoard);
  mainBoard.draw();
}
