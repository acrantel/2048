//N.M.
class Tile {
  private int value;
  private color[] colors = new color[] {
    color(240, 228, 219), color(239, 224, 202), color(248, 175, 129), // 2, 4, 8
    color(252, 147, 108), color(255, 121, 102), color(255, 77, 50), // 16, 32, 64
    color(248, 190, 94), color(245, 183, 80), color(249, 179, 69), // 128, 256, 512
    color(153, 175, 62), color(248, 169, 57), color(0, 0, 0) }; // 1024, 2048, all others
  private color[] fontColors = new color[] {
   color(104, 89, 81), color(104, 89, 81), color(255, 243, 230), // 2, 4, 8
   color(255, 243, 230), color(255, 243, 230), color(255, 243, 230), // 16, 32, 64
   color(255, 243, 230), color(255, 243, 230), color(255, 243, 230), // 128, 256, 512
   color(255, 243, 230), color(255, 243, 230), color(255, 243, 230), // 1024, 2048, all others
  };
  public Tile(int value) {
    this.value = value;
  }
  public int getValue() {
    return value;
  }
  public color getColor() {
    int index = (int) (Math.log(getValue())/Math.log(2))-1; 
     return colors[Math.min(index, colors.length-1)];
  }
  // returns the font color of the number for this tile
  public color getFontColor() {
    int index = (int)(Math.log(getValue())/Math.log(2))-1;
    return fontColors[Math.min(index, colors.length-1)];
  }

  public boolean equals(Tile o) { 
    if (o == null) {
      return false;
    } else {
      return (o.getValue() == getValue());
    }
  }
  public void drawTile(int x, int y, int tileWidth, int tileHeight, int curvature, int textSize) {
    fill(getColor());
    stroke(getColor());
    rect(x, y, tileWidth, tileHeight, curvature);
    fill(getFontColor());
    rectMode(CORNER);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    textSize(Math.min(textSize, tileWidth*.8 * textSize / textWidth(""+getValue())));
    text(""+getValue(), x, y, tileWidth, tileHeight);
  }
}
