import org.jaudiolibs.beads.*;
import beads.*;
import interfascia.*;


// Audio Controls for Game Music
SamplePlayer player = null;
Gain g;
BiquadFilter filter;

// GUI -- Download the interfascia library to use this
GUIController c;
IFButton startNew, selectSaved;
IFLookAndFeel buttonLAF;

// Color Palette
int[] palette = {#19002B, #DBE4FA};

// Pages
int page;
//--Index
// 0: Welcome Page
// 1: Start New Game
//---Buttons
IFButton freeMode, difficultyMode, returnToWelcome;
// 2: Start Previously Saved Game



void setup() {
  size(displayWidth, displayHeight);

  c = new GUIController(this);

  welcomePage();

  setupAudio("youcanalways.wav");
}

void setupAudio(String filename) {
  ac = new AudioContext();

  // Gain controls audio volume
  g = new Gain(ac, 1, 0.2);
  ac.out.addInput(g);

  try {
    // Load up a new SamplePlayer using an included audio file.
    player = getSamplePlayer(filename, false);
    player.setLoopType(SamplePlayer.LoopType.valueOf("LOOP_FORWARDS"));
  }
  catch(Exception e) {
    e.printStackTrace();
  }

  filter = new BiquadFilter(ac, BiquadFilter.AP, 1000.0, 0.5f);
  filter.addInput(player);
  g.addInput(filter);  

  // start processing audio
  ac.start();
}


void draw() {
  switch(page) {
  case 0 :
    welcomePage();
    break;
  case 1 :
    startNew();
    break;
  case 2 :
    selectSaved();
    break;
  }
  noLoop();
}

void actionPerformed (GUIEvent e) {
  if (e.getSource() == startNew) {
    page = 1;
    redraw();
  } else if (e.getSource() == selectSaved) {
    page = 2;
    redraw();
  } else if (e.getSource() == returnToWelcome) {
    page = 0;
    redraw();
  }
}
void welcomePage() {
  background(palette[0]);
  textSize(50);
  fill(palette[1]);
  text("Conlang Game", displayWidth/2 - 150, displayHeight/2 - 100);

  buttonLAF = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  buttonLAF.baseColor = palette[1];
  buttonLAF.textColor =  palette[0];

  startNew = new IFButton("Start New Game", displayWidth/2 - 75, displayHeight/2 - 40, 150, 20);
  startNew.addActionListener(this);
  startNew.setLookAndFeel(buttonLAF);

  selectSaved = new IFButton("Select Saved Game", displayWidth/2 - 75, displayHeight/2 - 15, 150, 20);
  selectSaved.addActionListener(this);
  selectSaved.setLookAndFeel(buttonLAF);

  c.add(startNew);
  c.add(selectSaved);
}
void startNew() {
  removeButtons();

  size(displayWidth, displayHeight);
  background(palette[0]);

  textSize(40);
  fill(palette[1]);
  text("Select Game Mode", displayWidth/2 - 150, displayHeight/2 - 100);

  setupButtonLAF();
  
  freeMode = new IFButton("Free Play Mode", displayWidth/2 - 75, displayHeight/2 - 40, 150, 20);
  freeMode.addActionListener(this);
  freeMode.setLookAndFeel(buttonLAF);

  difficultyMode = new IFButton("Difficulty Mode", displayWidth/2 - 75, displayHeight/2 - 15, 150, 20);
  difficultyMode.addActionListener(this);
  difficultyMode.setLookAndFeel(buttonLAF);

  c.add(freeMode);
  c.add(difficultyMode);

  returnToWelcome = new IFButton("Return", displayWidth - 120, displayHeight - 80, 80, 20);
  returnToWelcome.addActionListener(this);
  returnToWelcome.setLookAndFeel(buttonLAF);

  c.add(returnToWelcome);
}

void selectSaved() {
  removeButtons();
}

void removeButtons() {
  c.remove(startNew);
  c.remove(selectSaved);
}

void setupButtonLAF() {
  buttonLAF = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  buttonLAF.baseColor = palette[1];
  buttonLAF.textColor =  palette[0];
}
