class creditScreen extends gameState {
  PImage pageBg; // Background image for welcome, instructions, and credits pages
  int[] palette;
  IFLookAndFeel buttonLAF;
  
  creditScreen(paletteControls p){
    palette = p.palette;
    buttonLAF = p.buttonLAF;
    page = "CREDITS";
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
      
      //textSize(50);
      //fill(palette[2]);
      //text("Credits", displayWidth/2 - 100, 100);
      //textSize(50);
      //fill(palette[1]);
      //text("Credits", displayWidth/2 - 100, 100);
      
      fill(palette[0]);
      noStroke();
      rect(75, 150, displayWidth - 150, displayHeight - 300);
      textSize(50);
      fill(palette[1]);
      text("Creators", 200, 220);
      text("Artwork", 200, 345);
      text("Music", 200, 470);
      textSize(25);
      fill(palette[2]);
      text("Kate Garner, Mack Wilson, Sabrina Wilson, Richa Virmani", 500, 210);
      text("Arcane Runes by Obsidian Dawn", 500, 325);
      text("www.obsidiandawn.com", 500, 355);
      text("You Can Always Come Home by Toby Fox", 500, 450);
      text("Deltarune Original Soundtrack", 500, 480);
      drawn = true;
      return page;
    }
  }
  
  Boolean needsButtons(){ return true;}
}
