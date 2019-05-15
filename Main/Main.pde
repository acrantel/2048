Board board;
PFont f;
void setup() {
  //f = loadFont("ProcessingSansPro-Semibold-100.vlw");
  //board = new Board();
  //size(750 , 750);
  PlayerAI ai = new PlayerAI();
  long b = ai.replace(0, 1, 1, 4);
  b = ai.replace(b, 2, 2, 3);
  b = ai.replace(b, 2, 3, 3);
  System.out.println(b);
  System.out.println("Swiped left: " + ai.swipeLeft(b));
  System.out.println("Swiped right: " + ai.swipeRight(b));
  
}
void draw() {
  //board.draw();
}
