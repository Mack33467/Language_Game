/**
* =============================================================================
*                           IMPORTANT STUFF UP HERE
* =============================================================================
*  This is direct translation from Kate's second draft. No game features have
*  been added in this iteration. Instead the code has been refactored in such
*  a way that the code can be organized by gameStates. Every display screen
*  is a subclass of gameState, so I recommend you start by checking that out.
*  I haven't fiddled with any of the UI or anything, if you want to edit that
*  go into the necessary screen and change the display function
*
*  Note that the display function is split into drawn and not drawn
*  not drawn is reserved for initially drawing a class or reupdating in the case
*  of turn switching
*
*  I'm currently working on other game elements like inageHolder and timer and players
*  if you have any suggestions or done any work on those classes please lmk ASAP
*/

import org.jaudiolibs.beads.*;
import beads.*;
import interfascia.*;

/**
* A wrapper class for palette controls. Was it's own file but Processing
* didn't want to register it as a class so here it is.
*/
class paletteControls {
  IFLookAndFeel buttonLAF;
  IFLookAndFeel letterSelectionLAF;
  
  int[] palette = {
    #19002B, // Main & Game Bg
    #B31FFF, // Main Title
    #8FB1FE, // Main Options, Credit Txt, Previous Turn Bg
    #C6D7FF, // Your Turn Bg
    #3E1973, // Darkest Colored AlphaSquare, Highlighted Options
    #5F0073, // Second-Darkest Colored AlphaSquare
    #B31FFF  // Lightest Colored AlphaSquare
  };
  
  int backGround = #19002B;

  
  void setupButtonLAF(Object o) {
      buttonLAF = new IFLookAndFeel((PApplet) o, IFLookAndFeel.DEFAULT);
      buttonLAF.baseColor = palette[1];
      buttonLAF.textColor =  palette[0];
  }
  
  void setupLetterSelectionLAF(Object o) {
  letterSelectionLAF = new IFLookAndFeel((PApplet) o, IFLookAndFeel.DEFAULT);
  letterSelectionLAF.baseColor = palette[0];
  letterSelectionLAF.textColor = palette[2];
  }
}

// Audio Controls for Game Music
SamplePlayer player = null;
Gain g;
Glide gGlide;
BiquadFilter filter;

// GUI -- Download the interfascia library to use this
GUIController c;
//---Buttons
IFButton returnToWelcome;
IFButton createSymbol;
IFButton viewSymbols;

//The control scheme controller
paletteControls palette;

//Different screens of the game
HashMap<String, gameState> screens;
createALetterScreen letterCreation;
welcomeScreen welcome;
turnScreen turnDisplay;
instructionsScreen instr;
creditScreen credits;

//Our current screen we are displaying
gameState currentScreen;
String nextGameState;
Boolean waitForExterior;
void setup(){
  //Setting up size and GUI
  size(displayWidth, displayHeight);
  c = new GUIController(this);
  
  //Setting up base color palette
  palette = new paletteControls();
  palette.setupButtonLAF(this);
  palette.setupLetterSelectionLAF(this);
  
  //Putting all the screens in a hashmap
  screens = new HashMap();
  setScreens(palette, screens);
  
  //Setting flag for draw
  waitForExterior = false;
  
  // TODO: Load in more mysterious, eerie music? -- Match with the aesthetic of the arcane artwork
  // or more quirky, upbeat music (maybe play this during just the game?)

  // Can only use .wav files
  // Export your audio file to a .wav file using software like OcenAudio or Audacity
  setupAudio("youcanalways.wav");
}

/**
* This draw uses state machine transitions to move between screens. This prevents
* drawing on two screens at once. The waitForExterior reference pauses the display
* while we do stuff elsewhere
*/
void draw() {
  if (!waitForExterior){
    nextGameState = currentScreen.display(c);
    if (currentScreen.needsButtons() && !currentScreen.buttonsOn){
      setUpButtons(currentScreen.getPage());
      currentScreen.setButtonsOn();
    }
    currentScreen = screens.get(nextGameState);
  }
}

/**
* A screen to sets the next screen before unpausing draw
*/
void setNextScreen(String s){
  println("inside set next Screen");
  nextGameState = s;
  currentScreen = screens.get(nextGameState);
  waitForExterior = false;
  println("Next screen: " + nextGameState);
}

/**
* Contains specific instructions for removing buttons for each screen. Could be a switch
* statement, but I haven't retyped that out yet
*/
void removeButtons(GUIController c, gameState g) {
  println("Inside removeButtons");
  g.drawn = false;
  if (returnToWelcome != null) {
    c.remove(returnToWelcome);
  }
  if (g.page == "TURN") {
    if (createSymbol != null) {
      c.remove(createSymbol);
    }
    if (viewSymbols != null) {
      c.remove(viewSymbols);
    }
  }
  
  if (g.page == "CAL" || g.page == "VS") {
    if (createSymbol != null) {
      c.remove(createSymbol);
    }
    if (viewSymbols != null) {
      c.remove(viewSymbols);
    }
  }
  g.buttonsOn = false;
  g.buttons = true;
}

/**
* Processing doesn't do to well with passing GUIControllers in and adding listeners
* and buttons so instead we have to do it in this global class. This sucks a ton so
* we do it here globally. I know of a way to try and fix it, but for this implementation
* we will simply go with this.
*/
void setUpButtons(String p) {
  println("Inside setUpButtons");
  println(p);
  switch(p) {
    case "INSTR" :
      waitForExterior = true;
      returnToWelcome = new IFButton("Return", displayWidth - 125, displayHeight - 100);
      returnToWelcome.setLookAndFeel(palette.buttonLAF);
      returnToWelcome.addActionListener(this);
      c.add(returnToWelcome);
      break;
    case "CREDITS":
      returnToWelcome = new IFButton("Return", displayWidth - 125, displayHeight - 100);
      returnToWelcome.setLookAndFeel(palette.buttonLAF);
      returnToWelcome.addActionListener(this);
      c.add(returnToWelcome);
      currentScreen.setButtonsNeedOff();
      break;
    case "TURN":
      createSymbol = new IFButton("Add Symbol", displayWidth/2 + 25, 125);
      createSymbol.setLookAndFeel(palette.buttonLAF);
      createSymbol.addActionListener(this);
      c.add(createSymbol);
        
      viewSymbols = new IFButton("View Symbols", displayWidth-150, 125);
      viewSymbols.setLookAndFeel(palette.buttonLAF);
      viewSymbols.addActionListener(this);
      c.add(viewSymbols);
      break;
    case "CAL":
      c = currentScreen.setUpButtons(c);
      removeButtons(c, currentScreen);
    }
     currentScreen.setButtonsNeedOff();
}

/**
* Interfascia's way of dealing with button clicks. Inside we handle the case for each
* sort of button click. In most cases we use buttons to traverse screens so we pause the
* draw function and remove buttons that aren't going to be relevant to the next screen
* before we set up that next screen. Could be a bit more optimized, but it's ok for now
*/
void actionPerformed (GUIEvent e) {
  println("Inside actionPerformed");
  // If the return button is pressed on the Instructions and Credits page, the user0 will return to the Welcome Page, currently included on the Play page for debugging
  println(e.getSource());
  if (e.getSource() == returnToWelcome) {
      removeButtons(c, currentScreen);
      setNextScreen("welcome");
  }

  // If add symbol button is pressed
  if (e.getSource() == createSymbol) {
    println("Inside createSymbol");
    println(letterCreation.page);
    waitForExterior = true;
    setNextScreen("CAL");
  }

  // If view symbols button is pressed
  if (e.getSource() == viewSymbols) {
    waitForExterior = true;
    setNextScreen("VS");
  }
}

/**
* This method puts all the screens into a hashmap for the draw function,
* by changing the paletteControls that you place in you can change the color
* palette for the entire game.
*/
void setScreens(paletteControls palette, HashMap screens){
  turnDisplay = new turnScreen(palette);
  screens.put(turnDisplay.page, turnDisplay);
  welcome = new welcomeScreen(palette);
  screens.put(welcome.page, welcome);
  letterCreation = new createALetterScreen(palette);
  screens.put(letterCreation.page, letterCreation);
  currentScreen = welcome;
  instr = new instructionsScreen(palette);
  screens.put(instr.page, instr);
  credits = new creditScreen(palette);
  screens.put(credits.page, credits);
}



//Audio code that I didn't refactor into it's own class

AudioContext ac; //needed here because getSamplePlayer() uses it below

Sample getSample(String fileName) {
 return SampleManager.sample(dataPath(fileName)); 
}



void setupAudio(String filename) {
  ac = new AudioContext();

  // Gain controls audio volume
  g = new Gain(ac, 1, 0.2);
  ac.out.addInput(g);

  // Can instantiate a glide here that lets the user change the volume of the audio
  //gGlide = new Glide(ac, 1, 0.2);
  //g.addInput(gGlide);

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

SamplePlayer getSamplePlayer(String fileName, Boolean killOnEnd) {
  SamplePlayer player = null;
  try {
    player = new SamplePlayer(ac, getSample(fileName));
    player.setKillOnEnd(killOnEnd);
    player.setName(fileName);
  }
  catch(Exception e) {
    println("Exception while attempting to load sample: " + fileName);
    e.printStackTrace();
    exit();
  }
  
  return player;
}

SamplePlayer getSamplePlayer(String fileName) {
  return getSamplePlayer(fileName, false);
}
