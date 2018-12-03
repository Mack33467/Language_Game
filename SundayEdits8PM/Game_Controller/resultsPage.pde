class resultsPage extends gameState {
  PImage pageBg; // Background image for welcome, instructions, and credits pages
  int[] palette;
  IFLookAndFeel buttonLAF;
  IFButton prev, next;
  
  //Results Page Specifics
  int pageNumber;
  HashMap<String, ArrayList<ImageHolder>> images;
  ArrayList<Player> players;
  Boolean isLastPage;
  
  resultsPage(paletteControls p) {
    this(p, 1);
  }
  resultsPage(paletteControls p, int pNum){
    palette = p.palette;
    buttonLAF = p.buttonLAF;
    page = "res";
    buttons = true;
    buttonsOn = false;
    pageNumber = pNum;
    images = new HashMap();
    isLastPage = false;
  }
  
  String display(GUIController c){
      return "RES";
  }
  
  GUIController setUpButtons(GUIController c) {
    switch (opCode) {
      case 1:
        //We display a previous button and next button
        prev = new IFButton("Previous Page", width/20, int(height/1.102));
        next = new IFButton("Next Page", width/20*19 - int(textWidth("Next Page")), int(height/1.102));
        prev.setLookAndFeel(buttonLAF);
        next.setLookAndFeel(buttonLAF);
        prev.addActionListener(this);
        next.addActionListener(this);
        c.add(prev);
        c.add(next);
        //The previous button leads to the last currPage
        // Show first ten letters
        showByLetter('A', 'J', 1);
        break;
      case 2:
        //We display a previous and next button
        prev = new IFButton("Previous Page", width/20, int(height/1.102));
        next = new IFButton("Next Page", width/20*19 - int(textWidth("Next Page")), int(height/1.102));
        prev.setLookAndFeel(buttonLAF);
        next.setLookAndFeel(buttonLAF);
        prev.addActionListener(this);
        next.addActionListener(this);
        c.add(prev);
        c.add(next);
        // Show second ten letters
        showByLetter('K', 'T', 1);
        break;
      case 3:
        //Same as case 2
        prev = new IFButton("Previous Page", width/20, int(height/1.102));
        next = new IFButton("Next Page", width/20*19 - int(textWidth("Next Page")), int(height/1.102));
        prev.setLookAndFeel(buttonLAF);
        next.setLookAndFeel(buttonLAF);
        prev.addActionListener(this);
        next.addActionListener(this);
        c.add(prev);
        c.add(next);
        // Show last six letters
        showByLetter('U', 'Z', 3);
        break;
      case 4: 
        //We display a previous and next button
        prev = new IFButton("Previous Page", width/20, int(height/1.102));
        next = new IFButton("Next Page", width/20*19 - int(textWidth("Next Page")), int(height/1.102));
        prev.setLookAndFeel(buttonLAF);
        next.setLookAndFeel(buttonLAF);
        prev.addActionListener(this);
        next.addActionListener(this);
        c.add(prev);
        c.add(next);
        //Next button leads to the first image
        // Show letters by player
        showByPlayer();
        break;
    }
    return c;
  }
  
  /*
   * Displays results pages by letter
   * FirstTen: A-J, starts images at 1/11 x-alignment (pos 1)
   * SecondTen: K-T, starts images at 1/11 x-alignment (pos 1)
   * LastSix: U-Z, starts images at 3/11 x-alignment (pos 3)
   */
  void showByLetter(char first, char last, int initPosX) {
    char c = first;
    int posX = initPosX;
    while (c <= last) {
      text(c, width/11*posX, height/6);
      c++;
      posX++;
    }
    float imgSize = width/11.2;    // height and width of square symbol images
    c = first;
    posX = initPosX;
    int posY = height/6*2;
    while (c <= last) {
      for (ImageHolder img : images.get(c)) {
        image(img.getSymbol(), (width/11*posX)-(imgSize/2), posY);
        posY += imgSize;
      }
      posX++;
      posY = height/6*2;
      c++;
    }
  }
  
  /* 
   * Displays results pages by player
   */
  void showByPlayer() {
    int xInterval = width/(players.size()+1);
    int xPos = 1;
    int yPos = height/6;
    float imgSize = width/(players.size()+1.2);
    for (Player p : players) {
      text("Player " + xPos, (width/xInterval*xPos) - (textWidth("Player " + xPos)/2), yPos);
      yPos = height/6*2;
      for (PImage img : p.getSymbols()) {
        image(img, xPos-(imgSize/2), yPos);
        yPos += imgSize;
      }
      xPos++;
      yPos = height/6*2;
    }
  }
  
  GUIController clearScreen(GUIController c) {
    return c;
  }
  
  Boolean needsButtons(){ return true;}
  
  void setOPCode(int opCode){this.opCode = opCode;}
  void setImages(ArrayList<ImageHolder> array, String letter){images.put(letter, array);}
}
