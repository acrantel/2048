
void keyPressed() {
    if (key == 'w' || key == 'W' || (key == CODED && keyCode == UP)) {
      board.swipeUp();
      System.out.println("up");
    } else if (key == 'a' || key == 'A' || (key == CODED && keyCode == LEFT)) {
      board.swipeLeft();
      System.out.println("left");
    } else if (key == 's' || key == 'S' || (key == CODED && keyCode == DOWN)) {
      board.swipeDown();
      System.out.println("down");
    } else if (key == 'd' || key == 'D' || (key == CODED && keyCode == RIGHT)) {
      board.swipeRight();
      System.out.println("right");
    }
  
}
