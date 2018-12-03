class createALetterScreen extends gameState {
  PImage pageBg; // Background image for welcome, instructions, and credits pages
  int[] palette;
  IFLookAndFeel buttonLAF;
  IFLookAndFeel letterSelectionLAF;
  
  IFButton backToGame;

  IFButton _a, _b, _c, _d, _e, _f, _g, _h, _i, _j, _k, _l, _m, 
    _n, _o, _p, _q, _r, _s, _t, _u, _v, _w, _x, _y, _z;

  IFButton[] letters = {_a, _b, _c, _d, _e, _f, _g, _h, _i, _j, _k, _l, _m, 
    _n, _o, _p, _q, _r, _s, _t, _u, _v, _w, _x, _y, _z};

  createALetterScreen(paletteControls p) {
    palette = p.palette;
    buttonLAF = p.buttonLAF;
    letterSelectionLAF = p.letterSelectionLAF;
    page = "CAL";
    buttons = true;
    buttonsOn = false;
  }

  String display(GUIController c) {
    background(palette[0]);
    //pageBg = loadImage("gameBg.png");
    //image(pageBg, 0, 0, width, height);
    fill(#B31FFF);
    text("Create Symbol", width/2 - textWidth("Create Symbol")/2, height/6);
    fill(#8FB1FE);
    text("Select Letter", width/4 - textWidth("Select Letter")/2, height/6*2);
    text("Draw Symbol", width/4*3 - textWidth("Draw Symbol")/2, height/6*2);
    noFill();
    strokeWeight(4);
    stroke(255);
    rect(width/1.78, height/2.7, width/2.648, height/2.16);
    return "CAL";
  }

  GUIController setUpButtons(GUIController c) {
    println("Setting up CAL's buttons");
    backToGame = new IFButton("Back to Game", int(width/1.1255), int(height/1.102));
    backToGame.setLookAndFeel(buttonLAF);
    backToGame.addActionListener(this);
    c.add(backToGame);
    char curChar = 'A';
    int initX = width/10;
    int initY = height/7*3;
    int xLoc = initX;
    int yLoc = initY;
    for (IFButton b : letters) {
      b = new IFButton(curChar + "", xLoc, yLoc);
      b.setLookAndFeel(letterSelectionLAF);
      b.addActionListener(this);
      c.add(b);
      xLoc += width/7.68;
      if (curChar%3 == 0) {
        xLoc = initX;
        yLoc += height/27;
      }
      curChar++;
    }
    return c;
  }

  GUIController clearScreen(GUIController c) {
    c.remove(backToGame);
    for (IFButton b : letters) {
      c.remove(b);
    }
    return c;
  }
  Boolean needsButtons() { 
    return true;
  }
}
