public class Player {
  
  HashMap<String, ImageHolder> contrData; // Data the player has contributed to the game
  int curIndex;
  String lastLetterDrawn;
  // Constructor for the Player Object
  public Player() {
     ImageHolder playerHolder = new ImageHolder(createImage(displayWidth/2 - 20, (displayHeight/2), RGB), createImage(displayWidth/2 - 20, (displayHeight/2) - 200, RGB));
     this.contrData = new HashMap<String, ImageHolder>();
     this.contrData.put(new String(), playerHolder);
     this.curIndex = 0;
     this.lastLetterDrawn = "";
  }
    
  /**
   * Determines whether or not a player has already designed a letter.
   * 
   * @param letter The letter the player selected
   * @return true if the player has not designed a letter, false if it has not
  **/
  boolean validLetter(String letter) {
    return ((contrData.size() == 0) || !contrData.containsKey(letter));
  }
  
  ///**
  // * Lets the player draw on the canvas
  // * @param canvas The canvas the player is using
  //**/
  //void drawImage(PImage canvas) {
  //  if (mousePressed) {
  //    canvas.set(mouseX, mouseY, palette[6]);
  //  }
  //}
  
  /**
   * Adds the player's letter to their alpha board so that they cannot use it again.
   * Adds their creation and its associated letter and word to their game data.
  **/
  void submitData(String letter, PImage drawing, PImage symbol) {
    this.contrData.put(letter, new ImageHolder(drawing, symbol));
    lastLetterDrawn = letter;
  }
  
  void submitDataSymbol(String letter, PImage symbol) {
    this.contrData.put(letter, new ImageHolder(createImage(0,0,0), symbol));
    lastLetterDrawn = letter;
  }
  
  void submitDataDrawing(PImage drawing) {
    this.contrData.put(lastLetterDrawn, new ImageHolder(drawing, createImage(0,0,0)));
  }
  
  void incrCurIndex() {
    this.curIndex++;
  }
  
  // Getters
  HashMap<String, ImageHolder> getContrData() {
    return this.contrData;
  }
  
  ArrayList<String> getLetters() {
    return (ArrayList) this.contrData.keySet();
  }
  
  ArrayList<PImage> getDrawings() {
    if ((contrData == null) || (contrData.size() <= 0))
      return new ArrayList<PImage>();
    ArrayList<PImage> playerDrawings = new ArrayList<PImage>(contrData.size());
    for (int i = 0; i < this.contrData.size(); i++) {
     if (contrData.get(i) == null)
       playerDrawings.add(createImage(displayWidth/2 - 20, (displayHeight/2) - 200, RGB));
     else
       playerDrawings.add(this.contrData.get(i).getDrawing());
    }
    return playerDrawings;
  }
  
  ArrayList<PImage> getSymbols() {
    if ((contrData == null) || (contrData.size() <= 0)) {
      return new ArrayList<PImage>();
    }
    ArrayList<PImage> playerSymbols = new ArrayList<PImage>(contrData.size());
    for (int i = 0; i < this.contrData.size(); i++) {
      if (contrData.get(i) == null)
        playerSymbols.add(createImage(displayWidth/2 - 20, (displayHeight/2) - 200, RGB));
      else
        playerSymbols.add(this.contrData.get(i).getSymbol());
    }
    return playerSymbols;
  }
  
  int getCurIndex() {
    return this.curIndex;
  }
  
  String getLastLetterDrawn() {
    return lastLetterDrawn;
  }
  
  ImageHolder getLetterImages(String letter) throws IllegalArgumentException {
    if (validLetter(letter)) {
      return contrData.get(letter);
    } else {
      throw new IllegalArgumentException();
    }
  }
  
  @Override
  String toString() {
    return new String("Player info: CurIndex: " + getCurIndex());
  }
  
}
