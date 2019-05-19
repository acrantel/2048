import java.util.Map;
Board mainBoard;
PFont f;
AI ai;
void setup() {
  f = loadFont("ProcessingSansPro-Semibold-100.vlw");
  mainBoard = new Board();
  size(800, 600);
  surface.setTitle("2048");
  PImage icon = loadImage("icon-48.png");
  surface.setIcon(icon);
  ai = new AI();
  
}
void draw() {
  mainBoard.drawBoard();
}
