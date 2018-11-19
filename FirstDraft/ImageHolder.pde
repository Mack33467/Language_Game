public class ImageHolder {
  ArrayList<PImage> drawings;
  ArrayList<PImage> symbols;
  ArrayList<PImage> words;
  
  public ImageHolder() {
  
  }
  
  
  // Getters
  ArrayList<PImage> getDrawings() {
    return this.drawings;
  }  
  ArrayList<PImage> getSymbols() {
    return this.symbols;
  }
  
  // Update
  void update(ArrayList<PImage> newDrawings) {
    if (newDrawings.size() == 2) {
      this.drawings.addAll(newDrawings);
    } else {
      // TODO: Show error to user in separate window
      System.out.println("Only 2 new drawings can be added at a time, you "
        + "attempted to add " + newDrawings.size() + ".");
    }
  }
}
