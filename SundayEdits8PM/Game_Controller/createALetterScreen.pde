class createALetterScreen extends gameState {
  PImage pageBg; // Background image for welcome, instructions, and credits pages
  int[] palette;
  IFLookAndFeel buttonLAF;
  IFLookAndFeel letterSelectionLAF;
  PImage canvas; //The current letter
  String letter;
  Player pl;
  
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
    canvas = createImage(floor(width/2.648),  floor(height/2.16), RGB);
    canvas.loadPixels();
    for (int i = 0; i < canvas.pixels.length; i++) {
      canvas.pixels[i] = palette[3];
    }
    canvas.updatePixels();
    drawn = false;
  }

  String display(GUIController c) {
    if (drawn){
      if ((mouseX > width/1.78) && (mouseX <= width/1.78 + width/2.648) 
        && (mouseY > height/2.7) && (mouseY <= height/2.7 + height/2.16)) {
        cursor(CROSS);
        if (mousePressed) {

          canvas.loadPixels();
          int maxX = 0;
          int minX = 0;
          int maxY = 0;
          int minY = 0;
          if (mouseX < pmouseX) {
            maxX = pmouseX;
            minX = mouseX;
          }
          if (mouseX >= pmouseX) {
            maxX = mouseX;
            minX = pmouseX;
          }
          if (mouseY < pmouseY) {
            maxY = pmouseY;
            minY = mouseY;
          }
          if (mouseY >= pmouseY) {
            maxY = mouseY;
            minY = pmouseY;
          }

          for (int x = minX; x <= maxX; x++) {
            for (int y = minY; y <= maxY; y++) {
              // Pixel offset to determine which index of the image's pixel array the cursor is pointing to --> y * width + x
              int pixel = (((y - floor(height/2.7)) * floor(width/2.648) - 10 + (x - floor(width/1.78)))) % (canvas.pixels.length);
              if (pixel < 0)
                pixel *= -1;
              canvas.pixels[pixel] = palette[1];
            }
          }
          canvas.updatePixels();
        }
      } else { cursor(ARROW);}
    } else {
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
    drawn = true;
    }
    image(canvas, width/1.78, height/2.7);
    rect(width/1.78, height/2.7, width/2.648, height/2.16);
    return "CAL";
  }

  GUIController setUpButtons(GUIController c, PApplet p) {
    println("Setting up CAL's buttons");
    backToGame = new IFButton("Back to Game", int(width/1.1255)- 10,35);//int(width/1.1255), int(height/1.102));
    backToGame.setLookAndFeel(buttonLAF);
    backToGame.addActionListener(p);
    c.add(backToGame);
    char curChar = 'A';
    int initX = width/10;
    int initY = height/7*3;
    int xLoc = initX;
    int yLoc = initY;
    for (IFButton b : letters) {
      b = new IFButton(curChar + "", xLoc, yLoc);
      b.setLookAndFeel(letterSelectionLAF);
      b.addActionListener(p);
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
  
  void setCurrentPlayer(Player p){this.pl = p;}
}
