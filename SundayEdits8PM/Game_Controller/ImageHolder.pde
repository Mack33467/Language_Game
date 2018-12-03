import javafx.util.Pair;
public class ImageHolder {
  PImage drawing; // the entire drawing and the word associated with the drawing
  PImage symbol; // the symbol related to the particular selected letter
  //HashMap<String, HashMap<String, PImage>> gameData; // the final game data, consisting of the selected letter mapped to its associated word and image
  
  
  public ImageHolder() {
    this.drawing = new PImage();
    this.symbol = new PImage();
  }
  
  public ImageHolder(PImage drawing, PImage symbol) {
    this.drawing = drawing;
    this.symbol = symbol;
  }
  
  // Update
  public void update(PImage drawing, PImage symbol) {
    this.drawing = drawing;
    this.symbol = symbol;
  }
  
  // Getters
  PImage getDrawing() {
    return this.drawing;
  }  
  PImage getSymbol() {
    return this.symbol;
  }
}
