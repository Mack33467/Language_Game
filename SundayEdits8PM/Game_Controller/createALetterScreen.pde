class createALetterScreen extends gameState {
  PImage pageBg; // Background image for welcome, instructions, and credits pages
  int[] palette;
  IFLookAndFeel buttonLAF;
  IFLookAndFeel letterSelectionLAF;
  
  //---Radio Controller and Buttons (Player selects letter of alphabet)
  IFRadioController rc;
  
  IFRadioButton rA, rB, rC, rD, rE, rF, rG, rH, rI, rJ, rK, rL, rM, rN, rO, rP, 
    rQ, rR, rS, rT, rU, rV, rW, rX, rY, rZ;
  
  IFRadioButton[] letters = {
    rA, rB, rC, rD, rE, rF, rG, rH, rI, rJ, rK, rL, rM, rN, rO, rP, 
    rQ, rR, rS, rT, rU, rV, rW, rX, rY, rZ
  };
  
  createALetterScreen(paletteControls p){
    palette = p.palette;
    buttonLAF = p.buttonLAF;
    letterSelectionLAF = p.letterSelectionLAF;
    page = "CAL";
    buttons = true;
    buttonsOn = false;
  }
  
  String display(GUIController c){
      background(palette[0]);
      //pageBg = loadImage("gameBg.png");
      //image(pageBg, 0, 0, displayWidth, displayHeight);
      text("Create Symbol", displayWidth/2, 150);
      text("Select Letter", displayWidth/4, 350);
      text("Draw Symbol", displayWidth/4*3, 350);
      noFill();
      strokeWeight(4);
      stroke(255);
      rect(displayWidth/2+150, 400, 725, 500);
      return "CAL";
  }
  
  GUIController setUpButtons(GUIController c) {
    println("Setting up CAL's buttons");
    rc = new IFRadioController("");
    char curChar = 'A';
    int xLoc = 50;
    int yLoc = 400;
    for (IFRadioButton r : letters) {
      r = new IFRadioButton(curChar + "", xLoc, yLoc, rc);
      r.setLookAndFeel(letterSelectionLAF);
      r.addActionListener(this);
      c.add(r);
      curChar++;
      xLoc += 40;
    }
    return c;
  }
  
  GUIController clearScreen(GUIController c) {
    for (IFRadioButton r : letters) {
      rc.remove(r);
    }
    return c;
  }
  Boolean needsButtons(){ return true;}
}
