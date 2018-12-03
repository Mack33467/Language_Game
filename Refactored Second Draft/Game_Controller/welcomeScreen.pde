class welcomeScreen extends gameState {
  PImage pageBg; // Background image for welcome, instructions, and credits pages
  String page = "welcome";
  int[] palette;
  
  final int INSTR_TXT_X = displayWidth/2 - 200;
  final int PLAY_TXT_X = displayWidth/2;
  final int CREDITS_TXT_X = displayWidth/2 + 100;
  final int ALLOPT_TXT_Y = 375;
  
  welcomeScreen(paletteControls p){
    palette = p.palette;
  }
  String display(GUIController c){
  if(drawn) {
    if ((mouseX >= INSTR_TXT_X) && (mouseX <= INSTR_TXT_X + 175 /*width of instr txt*/)
        && (mouseY >= ALLOPT_TXT_Y - 10) && (mouseY <= ALLOPT_TXT_Y + 30)) {
        fill(palette[3]);
        text("Instructions", INSTR_TXT_X, ALLOPT_TXT_Y);
        if (mousePressed) {
          drawn = false;
          return "INSTR";
        }
      } else if ((mouseX >= PLAY_TXT_X) && (mouseX <= PLAY_TXT_X + 65)
        && (mouseY >= ALLOPT_TXT_Y - 10) && (mouseY <= ALLOPT_TXT_Y + 30)) {
        fill(palette[3]);
        text("Play", PLAY_TXT_X, ALLOPT_TXT_Y); 
        if (mousePressed) {
          drawn = false;
          return "TURN";
        }
      } else if ((mouseX >= CREDITS_TXT_X) && (mouseX <= CREDITS_TXT_X + 125)
        && (mouseY >= ALLOPT_TXT_Y - 10) && (mouseY <= ALLOPT_TXT_Y + 30)) {
        fill(palette[3]);
        text("Credits", CREDITS_TXT_X, ALLOPT_TXT_Y);
        if (mousePressed) {
          drawn = false;
          return "CREDITS";
        }
      } else if ((mouseX <= INSTR_TXT_X) && (mouseX >= INSTR_TXT_X + 175)) {
        return page;
      } else if ((mouseX <= PLAY_TXT_X) && (mouseX >= PLAY_TXT_X + 65)) {
        return page;
      } else if ((mouseX <= CREDITS_TXT_X) && (mouseX >= CREDITS_TXT_X + 120)) {
        return page;
      } else {
        return page;
      }
      return page;
    } else {    
      background(palette[0]);
      pageBg = loadImage("gameBg.png");
      image(pageBg, 0, 0, displayWidth, displayHeight);
      textSize(60);
      fill(palette[2]);
      text("Secret Language", displayWidth/2 - 170, displayHeight/2 - 100);
      fill(palette[1]);
      // TODO: load in font?
      text("Secret Language", displayWidth/2 - 170, displayHeight/2 - 100);
      textSize(30);
      fill(palette[2]);
      text("Instructions", INSTR_TXT_X, ALLOPT_TXT_Y); 
      text("Play", PLAY_TXT_X, ALLOPT_TXT_Y);
      text("Credits", CREDITS_TXT_X, ALLOPT_TXT_Y);
      drawn = true;
      return page;
    }
  }
  
}
