class ImageHolder {
  PImage[] drawings;
  PImage[] symbols;
  PImage[] words;
  
  ImageHolder() {
  
  }
  
  
  // Getters
  PImage[] getDrawings() {
    return this.drawings;
  }
  
  PImage[] getSymbols() {
    return this.symbols;
  }
  
  // Update
  void update(PImage[] newDrawings) {
    if (newDrawings.length == 2) {
        // append to end of current drawings array?
    } else {
      // Show error
    }
  }
}
