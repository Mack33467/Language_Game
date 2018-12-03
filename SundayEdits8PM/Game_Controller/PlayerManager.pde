class PlayerManager {
  int numPlayers;
  HashMap<String, Player> players; //The string is a numeric representatio of the player
  HashMap<String, ArrayList<ImageHolder>> allSymbols; // This is going to contain all the pictures associated with the letters of the alphabet
  String currentPlayer;
  PImage lastImage;
  
  
  PlayerManager(){
    this(1);
  }
  
  PlayerManager(int numPlayers) {
    this.numPlayers = numPlayers;
    allSymbols = new HashMap();
    //Intializing the letters-image associations
    for (int i = 0; i < 26; i++){
      int A = 65;
      char letter =(char)(A + i);
      String place = "" + letter;
      ArrayList<ImageHolder> array = new ArrayList();
      allSymbols.put(place, array);
    }
    players = new HashMap();
    //Initializing the number-player associations
    for (int i = 0; i < numPlayers; i++){
      int one = 49;
      char playerNum = (char) (one + i);
      String place = "" + playerNum;
      Player thisPlayer = new Player();
      players.put(place, thisPlayer);
    }
    currentPlayer = "1";
  }
  
  /**
  * This method adds the current players last drawn letter to the global symbol data
  * Increments current player at the end, essentially switching turns
  */
  void addPlayerLetter(){
    Player currPlayer = players.get(currentPlayer);
    String letter = currPlayer.getLastLetterDrawn();
    
    //Adding the last drawing to the global Image list
    if (letter != "") {
      try{
        allSymbols.get(letter).add(currPlayer.getLetterImages(letter));
      } catch(IllegalArgumentException e) {
        ImageHolder playerHolder = new ImageHolder(
            createImage(displayWidth/2 - 20, (displayHeight/2), RGB), createImage(displayWidth/2 - 20, (displayHeight/2) - 200, RGB));
        allSymbols.get(letter).add(playerHolder);
      }
    }
    
    ////Incrementing the current player by one
    //if (Integer.parseInt(currentPlayer) == numPlayers){
    //  currentPlayer = "1";
    //} else {
    //  currentPlayer ="" + (char) (Integer.parseInt(currentPlayer) + 49);
    //}
  }

  
  ArrayList<Player> exportPlayers(){
  return new ArrayList<Player>(players.values());
  }
  
  Player getCurrentPlayer(){
    return players.get(currentPlayer);
  }
  
}
