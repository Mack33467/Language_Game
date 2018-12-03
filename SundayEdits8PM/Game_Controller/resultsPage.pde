class resultsPage extends gameState {
  PImage pageBg; // Background image for welcome, instructions, and credits pages
  int[] palette;
  IFLookAndFeel buttonLAF;
  IFButton prev, next;
  
  //Results Page Specifics
  int pageNumber;
  HashMap<String, ArrayList<ImageHolder>> images;
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
        break;
      case 3:
        //Same as case 2
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
        break;
    }
    return c;
  }
  
  GUIController clearScreen(GUIController c) {
    return c;
  }
  
  Boolean needsButtons(){ return true;}
  
  void setOPCode(int opCode){this.opCode = opCode;}
  void setImages(ArrayList<ImageHolder> array, String letter){images.put(letter, array);}
}
