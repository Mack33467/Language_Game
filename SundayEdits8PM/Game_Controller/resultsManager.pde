class resultsManager extends gameState {
  //Data held by the results Manager
  resultsPage firstTenLetters;
  resultsPage secondTenLetters;
  resultsPage lastSixLetters;
  HashMap<Player, resultsPage> playerSpecifics;
  ArrayList<resultsPage> gallery;
  resultsPage currPage;
  resultsPage lastPage;
  int numPages;
  
  //Typical gameState stuff
  PImage pageBg; // Background image for welcome, instructions, and credits pages
  paletteControls palette;
  IFLookAndFeel buttonLAF;
  
  resultsManager(paletteControls p){
    palette = p;
    buttonLAF = p.buttonLAF;
    page = "RES";
    buttons = true;
    buttonsOn = false;
    playerSpecifics = new HashMap();
    gallery = new ArrayList();
    firstTenLetters = new resultsPage(p, 1);
    println("Setting firstTen's OPCODE");
    firstTenLetters.setOPCode(1);
    println(firstTenLetters.opCode);
    secondTenLetters = new resultsPage(p, 2);
    secondTenLetters.setOPCode(2);
    lastSixLetters = new resultsPage(p, 3);
    lastSixLetters.setOPCode(3);
    numPages = 3;
    currPage = firstTenLetters;
    lastPage = lastSixLetters;
  }
  
  String display(GUIController c){
      return currPage.display(c);
  }
  
  void setUpPlayerPages(ArrayList<Player> p) {
    for (Player person: p) {
      resultsPage temp = new resultsPage(palette, numPages);
      temp.setOPCode(4);
      playerSpecifics.put(person, temp );
      numPages += 1;
      lastPage.isLastPage = false;
      temp.isLastPage = true;
      lastPage = temp;
    }
  }
  
  void setUpLetterPages(HashMap<String, ArrayList<ImageHolder>> associations){
   for (int i = 0; i < 25; i++){
      int A = 65;
      char letter =(char)(A + i);
      String place = "" + letter;
      ArrayList<ImageHolder> temp = associations.get(place);
      if (i < 10) {
        firstTenLetters.setImages(temp, place);
      } else if( i < 19) {
        secondTenLetters.setImages(temp, place);
      } else {
        lastSixLetters.setImages(temp, place);
      }
    }
  }
  
  GUIController setUpButtons(GUIController c, PApplet p){
    return currPage.setUpButtons(c, p);
  }
  Boolean needsButtons(){ return true;}
  
}
