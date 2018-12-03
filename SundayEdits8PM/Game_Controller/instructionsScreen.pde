class instructionsScreen extends gameState {
  PImage pageBg; // Background image for welcome, instructions, and credits pages
  int[] palette;
  IFLookAndFeel buttonLAF;
  
  instructionsScreen(paletteControls p){
    palette = p.palette;
    buttonLAF = p.buttonLAF;
    page = "INSTR";
    buttons = true;
    buttonsOn = false;
  }
  String display(GUIController c){
    if(drawn) {
      return page;
    } else {  
      background(palette[0]);
      pageBg = loadImage("gameBg.png");
      image(pageBg, 0, 0, displayWidth, displayHeight);
      
      textSize(50);
      fill(palette[2]);
      text("Instructions", displayWidth/2 - 100, 100);
      textSize(50);
      fill(palette[1]);
      text("Instructions", displayWidth/2 - 100, 100);
      
      fill(palette[0]);
      noStroke();
      rect(75, 150, displayWidth - 75, displayHeight - 300);
      drawn = true;
      return page;
    }
  }
  
  Boolean needsButtons(){ return true;}
}
