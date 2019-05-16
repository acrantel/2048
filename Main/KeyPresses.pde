
void keyPressed() {
    if (key == 'w' || key == 'W' || (key == CODED && keyCode == UP)) {
      mainBoard.swipeUp();
    } else if (key == 'a' || key == 'A' || (key == CODED && keyCode == LEFT)) {
      mainBoard.swipeLeft();
    } else if (key == 's' || key == 'S' || (key == CODED && keyCode == DOWN)) {
      mainBoard.swipeDown();
    } else if (key == 'd' || key == 'D' || (key == CODED && keyCode == RIGHT)) {
      mainBoard.swipeRight();
    } else if (key == ' ' || key == 'm') {
      System.out.println("space");
      ai.move(mainBoard);
    }
  
}
