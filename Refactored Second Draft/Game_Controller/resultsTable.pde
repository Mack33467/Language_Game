class resultsTable extends gameState {
  PImage pageBg;
  int[] palette;
  HashMap<String, PImage[]> associations;  
  IFLookAndFeel buttonLAF;
  IFButton returnToMenu, saveAlphabet;

  resultsTable(paletteControls p) {
    palette = p.palette;
    page = "END";
    associations = new HashMap();
  }

  String display() {
    background(palette[0]);
    fill(palette[1]);
    String endMsg = "Congratulations! You have created a secret language!";
    text(endMsg, width/2-textWidth(endMsg)/2, height/6);
    return "END";
  }

  GUIController setUpButtons(GUIController c) {
    println("Setting up END's buttons");
    saveAlphabet = new IFButton("Save Secret Language", width/20, int(height/1.102));
    saveAlphabet.setLookAndFeel(buttonLAF);
    saveAlphabet.addActionListener(this);
    c.add(saveAlphabet);
    returnToMenu = new IFButton("Return to Main Menu", width/20*19 - int(textWidth("Return to MainMenu")), int(height/1.102));
    returnToMenu.setLookAndFeel(buttonLAF);
    returnToMenu.addActionListener(this);
    c.add(returnToMenu);
    return c;
  }

  GUIController clearScreen(GUIController c) {
    c.remove(returnToMenu);
    c.remove(saveAlphabet);
    return c;
  }

  Boolean needsButtons() { 
    return true;
  }
}
