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
      rect(width/15, height/9*2, width/9*7.8, height/7*4);
      
      textSize(32);
      fill(palette[2]);
      int xPos = width/10;
      int yPos = height/6*2;
      text("This pictionary-style game will help you create a secret language.", xPos, yPos);
      text("When it is your turn, use the \"add symbol\" button to draw a symbol representing the letter of your choice.", xPos, yPos+=90);
      text("Use the \"view symbols\" button to select a previously created symbol.", xPos, yPos+=50);
      text("Your goal is to make a word out of these symbols and draw a hint for the next player.", xPos, yPos+=50);
      text("The game ends when all 26 letters of the alphabet have been represented by your own symbols.", xPos, yPos+=90);
      text("Hint: when thinking of a word, try incorporating a few previous symbols!", xPos, yPos+=90);
      drawn = true;
      return page;
    }
  }
  
  Boolean needsButtons(){ return true;}
}
