public class ImageHolder {
  HashMap<String, PImage> drawings; // the entire drawing and the word associated with the drawing
  HashMap<String, PImage> symbols; // the symbol related to the particular selected letter
  //HashMap<String, HashMap<String, PImage>> gameData; // the final game data, consisting of the selected letter mapped to its associated word and image
  
  
  public ImageHolder() {
    this.drawings = new HashMap<String, PImage>();
    this.symbols = new HashMap<String, PImage>();
  }
  
  public void replaceDrawings(String letter, PImage drawing) {
    this.drawings.replace(letter, drawing);
  }
  
  // Getters
  ArrayList<PImage> getDrawings() {
    return (ArrayList<PImage>)this.drawings.values();
  }  
  ArrayList<PImage> getSymbols() {
    return (ArrayList<PImage>) this.symbols.values();
  }
  
  // Update
  void update(HashMap<String, PImage> newDrawings) {
    if (newDrawings.size() == 2) {
      this.drawings.putAll(newDrawings);
    } else {
      // TODO: Show error to user in separate window
      System.out.println("Only 2 new drawings can be added at a time, you "
        + "attempted to add " + newDrawings.size() + ".");
    }
  }
}
