import org.jaudiolibs.beads.*;
import beads.*;
import interfascia.*;


// Audio Controls for Game Music
SamplePlayer player = null;
Gain g;
Glide gGlide;
BiquadFilter filter;

// GUI -- Download the interfascia library to use this
GUIController c;
//---Buttons
IFButton returnToWelcome;
//---Button Look and Feel (Button Color Scheme)
IFLookAndFeel buttonLAF;


// Color Palette
int[] palette = {
  #19002B, // Main & Game Bg
  #B31FFF, // Main Title
  #8FB1FE, // Main Options, Credit Txt, Previous Turn Bg
  #C6D7FF, // Your Turn Bg
  #3E1973, // Darkest Colored AlphaSquare, Highlighted Options
  #5F0073, // Second-Darkest Colored AlphaSquare
  #B31FFF  // Lightest Colored AlphaSquare
};

// Pages
enum Pages {
  WELCOME_PAGE, INSTRUCTIONS, CREDITS, PLAYER_NUM, SETUP, WORD, PLAY, PAUSE, FINAL
}
Pages curPage;
;

//--Index
//---0: Welcome Page
//----Text Positions
final int INSTR_TXT_X = displayWidth/2 + 500;
final int PLAY_TXT_X = displayWidth/2 + 700;
final int CREDITS_TXT_X = displayWidth/2 + 840;
final int ALLOPT_TXT_Y = 375;

//---1: Instructions

//---2: Credits

//---3: Setup Game Page
IFButton[] alphaButtons = new IFButton[26];
IFButton next; // Proceeds to game
String curLtr;
ImageHolder curImgHolder;
IFButton proceedBtn;

//---4: Choose Num of Players
IFTextField playerTxtField;

//---5: Choose Word
IFTextField wordTxtField;
IFButton startGameBtn;

//---6: Play (The Game)
PImage prevImage;  // Previous Player's Symbol
PImage prevDrawing; // Previous Player's Drawing
PImage curImage;   // Current Player's Symbol
PImage curDrawing; // Current Player's Drawing
HashMap<String, ImageHolder> imgHolderAll; // Holds all game data
Timer timer;
IFButton nextTurnBtn;

PImage pageBg; // Background image for welcome, instructions, and credits pages

Pair<Boolean, String> alphaInfo = new Pair<Boolean, String>(false, "");

Player[] players = new Player[26];
HashMap<String, ImageHolder> gameData = new HashMap<String, ImageHolder>();

int playerNum;
int curPlayer;

void setup() {
  // Setup display and GUI
  size(displayWidth, displayHeight);
  c = new GUIController(this);
  setupButtonLAF();
  
  pageBg = loadImage("gameBg.png");
  
  prevImage = createImage(displayWidth/2 - 20, (displayHeight/2) - 200, RGB);
  prevImage.loadPixels();
  for (int i = 0; i < prevImage.pixels.length; i++) {
    prevImage.pixels[i] = palette[2];
  }
  prevImage.updatePixels();
  
  prevDrawing = createImage(displayWidth/2 - 20, (displayHeight/2), RGB);
  prevDrawing.loadPixels();
  for (int i = 0; i < prevDrawing.pixels.length; i++) {
    prevDrawing.pixels[i] = palette[2];
  }
  prevDrawing.updatePixels();
  
  setupCanvas();

  timer = new Timer(60.f);
  welcomePage();
  
  // TODO: Load in more mysterious, eerie music? -- Match with the aesthetic of the arcane artwork
  // or more quirky, upbeat music (maybe play this during just the game?)

  // Can only use .wav files
  // Export your audio file to a .wav file using software like OcenAudio or Audacity
  setupAudio("youcanalways.wav");
}

void setupCanvas() {
  curImage = createImage(displayWidth/2 - 20, (displayHeight/2) - 200, RGB);
  curImage.loadPixels();
  for (int i = 0; i < curImage.pixels.length; i++) {
    curImage.pixels[i] = palette[3];
  }
  curImage.updatePixels();
  
  curDrawing = createImage(displayWidth/2 - 20, (displayHeight/2), RGB);
  curDrawing.loadPixels();
  for (int i = 0; i < curDrawing.pixels.length; i++) {
    curDrawing.pixels[i] = palette[3];
  }
  curDrawing.updatePixels();
}

void initAlphaButtons() {
  for (int i = 0; i < 13; i++) {
    char ltr1 = 'A';
    ltr1 += i;
    char ltr2 = 'N';
    ltr2 += i;
     
    alphaButtons[i] = new IFButton(Character.toString(ltr1), (displayWidth/2) - 190 + (30 * i), displayHeight - 500, 20, 20);
    alphaButtons[13 + i] = new IFButton(Character.toString(ltr2), (displayWidth/2) - 190 + (30 * i), displayHeight - 450, 20, 20);
    alphaButtons[i].setLookAndFeel(buttonLAF);
    alphaButtons[i].addActionListener(this);
    alphaButtons[13 + i].setLookAndFeel(buttonLAF);
    alphaButtons[13 + i].addActionListener(this);
  
    c.add(alphaButtons[i]);
    c.add(alphaButtons[13 + i]);
  }
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


void draw() {
  switch(curPage) {
  case WELCOME_PAGE :
    if ((mouseX >= INSTR_TXT_X) && (mouseX <= INSTR_TXT_X + 175 /*width of instr txt*/)
      && (mouseY >= ALLOPT_TXT_Y - 10) && (mouseY <= ALLOPT_TXT_Y + 30)) {
      fill(palette[3]);
      text("Instructions", INSTR_TXT_X, ALLOPT_TXT_Y);
      if (mousePressed) {
        instructions(); 
      }
    } else if ((mouseX >= PLAY_TXT_X) && (mouseX <= PLAY_TXT_X + 65)
      && (mouseY >= ALLOPT_TXT_Y - 10) && (mouseY <= ALLOPT_TXT_Y + 30)) {
      fill(palette[3]);
      text("Play", PLAY_TXT_X, ALLOPT_TXT_Y); 
      if (mousePressed) {
        initPlayers();
        //play();
      }
    } else if ((mouseX >= CREDITS_TXT_X) && (mouseX <= CREDITS_TXT_X + 125)
      && (mouseY >= ALLOPT_TXT_Y - 10) && (mouseY <= ALLOPT_TXT_Y + 30)) {
      fill(palette[3]);
      text("Credits", CREDITS_TXT_X, ALLOPT_TXT_Y);
      if (mousePressed) {
        credits();
      }
    } else if ((mouseX <= INSTR_TXT_X) && (mouseX >= INSTR_TXT_X + 175)) {
      welcomePage();
    } else if ((mouseX <= PLAY_TXT_X) && (mouseX >= PLAY_TXT_X + 65)) {
      welcomePage();
    } else if ((mouseX <= CREDITS_TXT_X) && (mouseX >= CREDITS_TXT_X + 120)) {
      welcomePage();
    } else {
      welcomePage();
    }
    break;
  case INSTRUCTIONS : 
    break;
  case CREDITS :
    break;
  case SETUP :
    break;
  case PLAYER_NUM :
    break;
  case WORD :
    break;
  case PLAY:
    noStroke();
    fill(palette[0]);
    rect(displayWidth - 100, 0, displayWidth, 60);
    if (timer.getTime() >= 0.f) {
      fill(palette[3]);
      text(timer.getTime(), displayWidth - 100, 30);
      timer.countDown();
      if ((mouseX >= displayWidth/2) && (mouseX <= displayWidth - 10) 
        && (mouseY >= 100) && (mouseY <= (displayHeight/2) - 100)) {
        cursor(CROSS);
        if (mousePressed) {

          curImage.loadPixels();
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
            for(int y = minY; y <= maxY; y++) {
              // Pixel offset to determine which index of the image's pixel array the cursor is pointing to --> y * width + x
              int pixel = (((y - 100) * (displayWidth/2 - 20) + (x - displayWidth/2))) % (curImage.pixels.length);
              if (pixel < 0)
                pixel *= -1;
              curImage.pixels[pixel] = palette[1];
            }
          }
          curImage.updatePixels();
          image(curImage, displayWidth/2, 100);
        }
      } else if ((mouseX >= displayWidth/2) && (mouseX <= displayWidth - 10) 
        && (mouseY >= 290) && (mouseY <= 290 + (displayHeight/2))) {
          cursor(CROSS);
        if (mousePressed) {

          curDrawing.loadPixels();
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
            for(int y = minY; y <= maxY; y++) {
              // Pixel offset to determine which index of the image's pixel array the cursor is pointing to --> y * width + x
              int pixel = (((y - 290) * (displayWidth/2 - 20) + (x - displayWidth/2))) % (curDrawing.pixels.length);
              if (pixel < 0)
                pixel *= -1;
              curDrawing.pixels[pixel] = palette[1];
            }
          }
          curDrawing.updatePixels();
          image(curDrawing, displayWidth/2, 290);
        }
      } else {
        cursor(ARROW);
      }
    } else if (timer.getTime() == -10) {
      cursor(ARROW);
    } else {
      timer.setTime(0.00);
      
      fill(palette[0]);
      rect(displayWidth - 100, 0, displayWidth, 60);
      fill(palette[3]);
      text("0.00", displayWidth - 100, 30);
     
      fill(palette[0]);
      textSize(50);
      text("TIME'S UP!", displayWidth/2 + 250, 400);
      
      //curImgHolder.drawings.put(wordTxtField.getValue(), curDrawing);
      //imgHolderAll.put(alphaInfo.getValue(), curImgHolder);
      
      timer.setTime(-10);
      
      if (gameData != null) {
        if (gameData.size() >= 26) {
          saveData();
        // Go to end game state
        }
      }
      
      if (players[curPlayer] == null)
        players[curPlayer] = new Player();
      prevDrawing = players[curPlayer].getDrawings().get(players[curPlayer].getCurIndex());
      prevImage = players[curPlayer].getSymbols().get(players[curPlayer].getCurIndex());
      
      prevImage = createImage(displayWidth/2 - 20, (displayHeight/2) - 200, RGB);
      prevImage.loadPixels();
      for (int i = 0; i < prevImage.pixels.length; i++) {
        if (prevImage.pixels[i] == palette[3]) {
          prevImage.pixels[i] = palette[2];
        } else if (prevImage.pixels[i] == palette[0]) {
          prevImage.pixels[i] = palette[1];
        }
      }
      prevImage.updatePixels();
  
      prevDrawing = createImage(displayWidth/2 - 20, (displayHeight/2), RGB);
      prevDrawing.loadPixels();
      for (int i = 0; i < prevDrawing.pixels.length; i++) {
        prevDrawing.pixels[i] = palette[2];
      }
      prevDrawing.updatePixels();
      
      setupCanvas();
      
      players[curPlayer].incrCurIndex();
      
      curPlayer += 1;
      curPlayer %= playerNum;
      
    }
    break;
  }
}

void welcomePage() {
  curPage = Pages.WELCOME_PAGE;
  
  removeButtons();
  removeAlphaButtons();
  
  background(palette[0]);
  
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
}

void instructions() {
  curPage = Pages.INSTRUCTIONS;
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
  
  returnToWelcome = new IFButton("Return", displayWidth - 125, displayHeight - 100);
  returnToWelcome.setLookAndFeel(buttonLAF);
  returnToWelcome.addActionListener(this);
  
  c.add(returnToWelcome);
}

void credits() {
  curPage = Pages.CREDITS;
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
  
  returnToWelcome = new IFButton("Return", displayWidth - 125, displayHeight - 100);
  returnToWelcome.setLookAndFeel(buttonLAF);
  returnToWelcome.addActionListener(this);
  
  c.add(returnToWelcome);
}

void initPlayers() {
  curPage = Pages.PLAYER_NUM;
  removeButtons();
  image(pageBg, 0, 0, displayWidth, displayHeight);
  
  stroke(palette[2]);
  fill(palette[0]);
  rect((displayWidth/2) - 225, 150, (displayWidth/2) - 225, (displayHeight/2) - 100);
  
  textSize(28);
  fill(palette[2]);
  text("Select Your Number of Players", (displayWidth/2) - 180, 225);
  
  playerTxtField = new IFTextField("playerInit", (displayWidth/2) - 35, 300, 40);
  textSize(18);
  text("player(s)", (displayWidth/2) + 15, 320); 
  
  returnToWelcome = new IFButton("Return", (displayWidth/2) - 50, (displayHeight/2));
  returnToWelcome.setLookAndFeel(buttonLAF);
  returnToWelcome.addActionListener(this);
  
  proceedBtn = new IFButton("Proceed", (displayWidth/2) + 70, (displayHeight/2)); 
  proceedBtn.setLookAndFeel(buttonLAF);
  proceedBtn.addActionListener(this);
  
  c.add(playerTxtField);
  c.add(returnToWelcome);
  c.add(proceedBtn);
  
}

void initGame() {
  //play();
  curPage = Pages.SETUP;
  removeButtons();
  c.remove(playerTxtField);
  image(pageBg, 0, 0, displayWidth, displayHeight);
  
  
  stroke(palette[2]);
  fill(palette[0]);
  rect((displayWidth/2) - 225, 150, (displayWidth/2) - 225, (displayHeight/2) - 100);
  textSize(28);
  fill(palette[2]);
  text("Select Letter", (displayWidth/2) - 70, 225);
  
  initAlphaButtons();
  
  returnToWelcome = new IFButton("Return", (displayWidth/2 - 50), (displayHeight/2));
  returnToWelcome.setLookAndFeel(buttonLAF);
  returnToWelcome.addActionListener(this);
  
  //proceedBtn = new IFButton("Proceed", (displayWidth/2) + 70, (displayHeight/2)); 
  //proceedBtn.setLookAndFeel(buttonLAF);
  //proceedBtn.addActionListener(this);
  
  startGameBtn = new IFButton("Start Game", (displayWidth/2) + 70, displayHeight/2);
  startGameBtn.setLookAndFeel(buttonLAF);
  startGameBtn.addActionListener(this);
  
  c.add(returnToWelcome);
  c.add(startGameBtn);
}

void word() {
  curPage = Pages.WORD;
  removeButtons();
  removeAlphaButtons();
  image(pageBg, 0, 0, displayWidth, displayHeight);
  
  stroke(palette[2]);
  fill(palette[0]);
  rect((displayWidth/2) - 225, 150, (displayWidth/2) - 225, (displayHeight/2) - 100);
  fill(palette[2]);
  text("Write Your Word", (displayWidth/2) - 105, 225);
  
  wordTxtField = new IFTextField("initWord", (displayWidth/2 - 100), 300, 200);
  wordTxtField.setValue(alphaInfo.getValue());
  
  startGameBtn = new IFButton("Start Game", (displayWidth/2) + 70, displayHeight/2);
  startGameBtn.setLookAndFeel(buttonLAF);
  startGameBtn.addActionListener(this);
  
  c.add(wordTxtField);
  c.add(startGameBtn);
}

void play() {
  curPage = Pages.PLAY;
  removeAlphaButtons();
  removeButtons();
  c.remove(wordTxtField);
  //alphaButtons[25] = null;
  //wordTxtField = null;
 
  background(palette[0]);
  image(prevImage, 10, 100);
  image(prevDrawing, 10, 290);
  
  image(curImage, displayWidth/2, 100);
  image(curDrawing, displayWidth/2, 290);
  
  returnToWelcome = new IFButton("Return", displayWidth - 275, displayHeight - 80);
  returnToWelcome.setLookAndFeel(buttonLAF);
  returnToWelcome.addActionListener(this);
  
  nextTurnBtn = new IFButton("Next Turn", displayWidth - 125, displayHeight - 80);
  nextTurnBtn.setLookAndFeel(buttonLAF);
  nextTurnBtn.addActionListener(this);
  
  c.add(returnToWelcome);
  c.add(nextTurnBtn);
}

void startNew() {
  
}

void selectSaved() {
  //removeButtons();
}

void saveData() {
  if (players[curPlayer % playerNum] == null) {
    System.out.println("The player has not been initialized.");
    players[curPlayer % playerNum] = new Player();
    System.out.println(players[curPlayer % playerNum]);
  }
  players[curPlayer % playerNum].submitData(alphaInfo.getValue(), curDrawing, curImage);
  gameData.put(alphaInfo.getValue(), new ImageHolder(curDrawing, curImage));
}


void removeButtons() {
  if (proceedBtn != null)
    c.remove(proceedBtn);
  if (returnToWelcome != null)
    c.remove(returnToWelcome);
  if (proceedBtn != null)
    c.remove(proceedBtn);
  if (nextTurnBtn != null)
    c.remove(nextTurnBtn);
  //if (startGameBtn != null)
  //  c.remove(startGameBtn);
}

void removeAlphaButtons() {
  for (int i = 0; i < 26; i++) {
    if (alphaButtons[i] != null)
      c.remove(alphaButtons[i]);
      alphaButtons[i] = null;
  }
}

void setupButtonLAF() {
  buttonLAF = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  buttonLAF.baseColor = palette[1];
  buttonLAF.textColor =  palette[0];
}

boolean alphaBtnPressed (GUIEvent e) {
  boolean alphaPressed = false;
  char ltr = 'a';
  for (int i = 0; i < 26; i++) {
    if (e.getSource() == alphaButtons[i]) {
      ltr += i;
      alphaPressed = true;
      alphaInfo = new Pair(alphaPressed, Character.toString(ltr));
      return alphaPressed;
    } 
  }
  alphaInfo = null;
  return alphaPressed;
}

void actionPerformed (GUIEvent e) {
  // If the return button is pressed on the Instructions and Credits page, the user will return to the Welcome Page, currently included on the Play page for debugging
  if (e.getSource() == returnToWelcome) {
    if (curPage == Pages.PLAY) {
      PImage newImage = createImage(100, 100, RGB);
      newImage = curImage.get();
      newImage.save("outputImage.jpg");
    }
    welcomePage();
  } else if (e.getSource() == proceedBtn) {
    if (curPage == Pages.PLAYER_NUM) {
      if ((playerTxtField.getValue() != "") 
      && ((Integer.parseInt(playerTxtField.getValue()) > 0)) && Integer.parseInt(playerTxtField.getValue()) <= 26) {
        playerNum = Integer.parseInt(playerTxtField.getValue());
        System.out.println("Player number: " + playerNum);
        players = new Player[playerNum];
        //for (int i = 0; i < playerNum; i++) {
        //  players[i]
        //}
        initGame();
      } else {
        initPlayers();
        
        textSize(12);
        fill(palette[1]);
        text("Please select a player number greater than 0 and less than 27.", (displayWidth/2) - 75, 250);
      }
    } else if (curPage == Pages.SETUP) {
      if (alphaInfo.getKey() && players[curPlayer % playerNum].validLetter(alphaInfo.getValue())) {
        gameData.put(alphaInfo.getValue(), new ImageHolder(curDrawing, curImage));
        players[curPlayer%playerNum].submitData(alphaInfo.getValue(), curDrawing, curImage);
        play();
      } else {
        initGame(); 
      
        textSize(12);
        fill(palette[1]);
        text("Please select a letter.", (displayWidth/2), 250);
      }
    }
  } else if (e.getSource() == startGameBtn) {
    //curImgHolder.drawings.put(wordTxtField.getValue(), curDrawing);
    play();
    setupCanvas();
    //System.out.println("Start Game button pressed");
    //System.out.println("Word text field: " + wordTxtField.getValue().charAt(0));
    //System.out.println("Letter Selected: " + alphaInfo.getValue().charAt(0));
    //if ((wordTxtField.getValue().charAt(0) == alphaInfo.getValue().charAt(0))) { 
    //  curImgHolder.drawings.put(wordTxtField.getValue(), curDrawing);
    //  play();
    //} else {
    //  textSize(15);
    //  fill(palette[0]);
    //  text("Please write a word.", (displayWidth/2) - 65, 250);
      
    //  textSize(15);
    //  fill(palette[1]);
    //  text("Please write a word.", (displayWidth/2) - 65, 250);
    //}
  } else if (e.getSource() == nextTurnBtn) {
    saveData();
    initGame();
  } else if (alphaBtnPressed(e)) {
    // Wait for next button press
  } 
}
