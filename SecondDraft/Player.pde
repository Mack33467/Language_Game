import javafx.util.Pair;
public class Player {
  
  HashMap<Pair<String, String>, PImage> contrData; // Data the player has contributed to the game
  HashMap<String, Boolean> alphaBoard; // All of the letters of the alphabet and whether the player has used them.
  
  // Constructor for the Player Object
  public Player() {
     this.contrData = new HashMap<Pair<String, String>, PImage>();
     this.alphaBoard = new HashMap<String, Boolean>(26);
     for (int i = 0; i < 26; i++) {
       char c = 'A';
       c += i;
       this.alphaBoard.put(Character.toString(c), false);
     }
  }
    
  /**
   * Determines whether or not a player has already designed a letter.
   * 
   * @param letter The letter the player selected
   * @return true if the player has not designed a letter, false if it has not
  **/
  boolean validLetter(String letter) {
    return ((this.contrData.size() == 0) || !this.alphaBoard.containsKey(letter));
  }
  
  /**
   * Lets the player draw on the canvas
   * @param canvas The canvas the player is using
  **/
  void drawImage(PImage canvas) {
    if (mousePressed) {
      canvas.set(mouseX, mouseY, palette[6]);
    }
  }
  
  /**
   * Adds the player's letter to their alpha board so that they can not use it again.
   * Adds their creation and its associated letter and word to their game data.
  **/
  void submitImage(String letter, String word, PImage canvas) {
    this.alphaBoard.put(letter, true);
    this.contrData.put(new Pair(letter, word),canvas);
  }
  
  
  
}
