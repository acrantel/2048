class Tile {
  private int value;
  private color[] colors = new color[] {
    color(255, 229, 204), color(255, 204, 153), color(255, 178, 102), 
     color (255, 153, 51), color(255, 128, 0), color(255, 102, 102), color(255, 255, 102),
     color(255, 255, 0), color (204, 204, 0),color (153, 153, 0), 
   color (102, 204, 0), color(0, 0, 0) };
  private color[] fontColors = new color[]{
   color (64, 64, 64), color(64, 64, 64), color(255, 255, 255), 
    color (255, 255, 255), color(255, 255, 255), color(255, 255, 255), color(255, 255, 255), 
    color(255, 255, 255), color(255, 255, 255), color(255, 255, 255), color(255, 255, 255), 
    color(255, 255, 255)};
  public Tile(int value) {
    this.value = value;
  }
  public int getValue() {
    return value;
  }
  public color getColor() {
    int index = (int) (Math.log(getValue())/Math.log(2))-1; 
     return colors[index];
  }
  // returns the font color of the number for this tile
  public color getFontColor() {
    int index = (int)(Math.log(getValue())/Math.log(2))-1;
    return fontColors[index];
  }

  public boolean equals(Tile o) { 
      return (o.getValue() == getValue());
  }
}
