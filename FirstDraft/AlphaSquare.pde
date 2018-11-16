import jto.colorscheme.*;

public class AlphaSquare {
  boolean filled;
  // rgb values
  int rValue;
  int gValue;
  int bValue;
  // or use the jto colorscheme library
  Color asColor;
  
  AlphaSquare() {
    this.filled = false;
    //this.asColor = new Color();
    //this.asColor.setRgb(255);
  }
  
  AlphaSquare(boolean filled) {
    this.filled = filled;
  }
  /**
    Colors in the AlphaSquare based on whether its associated letter has been updated
  */
  void colorIn() {
    this.rValue++;
    // or
  }
}
