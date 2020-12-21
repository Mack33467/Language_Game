import jto.colorscheme.*;

public class AlphaSquare {
  int[] alphaPalette = {#3E1973, // Darkest Colored AlphaSquare
                        #5F0073, // Second-Darkest Colored AlphaSquare
                        #B31FFF,  // Lightest Colored AlphaSquare
                        255 // No Color
                        };
                        
  boolean filled;
  int apIndex; // alphaPalette index
  
  
  public AlphaSquare() {
    this.filled = false;
    this.apIndex = 3;
  }
  
  AlphaSquare(boolean filled) {
    this.filled = filled;
    
  }
  /**
    Colors in the AlphaSquare based on whether its associated letter has been updated
  */
  void colorIn() {
    if (this.apIndex > 0)
      apIndex--;
    int curColor = alphaPalette[apIndex];
    // Fill in AlphaSquare with curColor
  }
}
