
void keyPressed() {
  System.out.println(key);
    if (key == 'w' || key == 'W' || (key == CODED && keyCode == UP)) {
      board.swipeUp();
    } else if (key == 'a' || key == 'A' || (key == CODED && keyCode == LEFT)) {
      board.swipeLeft();
    } else if (key == 's' || key == 'S' || (key == CODED && keyCode == DOWN)) {
      board.swipeDown();
    } else if (key == 'd' || key == 'D' || (key == CODED && keyCode == RIGHT)) {
      board.swipeRight();
    }
  
}
