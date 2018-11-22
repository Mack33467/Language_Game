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
  WELCOME_PAGE, INSTRUCTIONS, CREDITS, PLAY
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

//---3: Play (The Game)
PImage prevImage;  // Previous Player's Image
PImage curImage;   // Current Player's Image
ImageHolder imgHolderAll; // Holds all game data


PImage pageBg; // Background image for welcome, instructions, and credits pages


void setup() {
  // Setup display and GUI
  size(displayWidth, displayHeight);
  c = new GUIController(this);
  setupButtonLAF();
  
  prevImage = createImage(displayWidth/2 - 20, displayHeight - 200, RGB);
  prevImage.loadPixels();
  for (int i = 0; i < prevImage.pixels.length; i++) {
    prevImage.pixels[i] = palette[2];
  }
  prevImage.updatePixels();
  
  curImage = createImage(displayWidth/2 - 20, displayHeight - 200, RGB);
  curImage.loadPixels();
  for (int i = 0; i < curImage.pixels.length; i++) {
    curImage.pixels[i] = palette[3];
  }
  curImage.updatePixels();
  //curImage = createGraphics(displayWidth/2 - 20, displayHeight - 200);
  //curImage.beginDraw();
  //curImage.background(palette[3]);
  
  // Display the Welcome Page
  welcomePage();
  
  
  
  

  // TODO: Load in more mysterious, eerie music? -- Match with the aesthetic of the arcane artwork
  // or more quirky, upbeat music (maybe play this during just the game?)

  // Can only use .wav files
  // Export your audio file to a .wav file using software like OcenAudio or Audacity
  setupAudio("youcanalways.wav");
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
        play();
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
  case PLAY:
    if ((mouseX >= displayWidth/2) && (mouseX <= displayWidth - 10) 
      && (mouseY >= 100) && (mouseY <= displayHeight - 100)) {
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
    } else {
      cursor(ARROW);
    }
    break;
  }
}

void welcomePage() {
  removeButtons();
  
  background(palette[0]);
  
  curPage = Pages.WELCOME_PAGE;
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

void play() {
  curPage = Pages.PLAY;
  background(palette[0]);
  image(prevImage, 10, 100);
  image(curImage, displayWidth/2, 100);
  
  returnToWelcome = new IFButton("Return", displayWidth - 125, displayHeight - 80);
  returnToWelcome.setLookAndFeel(buttonLAF);
  returnToWelcome.addActionListener(this);
  
  c.add(returnToWelcome);
}

void startNew() {
  //removeButtons();

  //size(displayWidth, displayHeight);
  //background(palette[0]);

  //textSize(40);
  //fill(palette[1]);
  //text("Select Game Mode", displayWidth/2 - 150, displayHeight/2 - 100);

  //setupButtonLAF();

  //freeMode = new IFButton("Free Play Mode", displayWidth/2 - 75, displayHeight/2 - 40, 150, 20);
  //freeMode.addActionListener(this);
  //freeMode.setLookAndFeel(buttonLAF);

  //difficultyMode = new IFButton("Difficulty Mode", displayWidth/2 - 75, displayHeight/2 - 15, 150, 20);
  //difficultyMode.addActionListener(this);
  //difficultyMode.setLookAndFeel(buttonLAF);

  //c.add(freeMode);
  //c.add(difficultyMode);

  //returnToWelcome = new IFButton("Return", displayWidth - 120, displayHeight - 80, 80, 20);
  //returnToWelcome.addActionListener(this);
  //returnToWelcome.setLookAndFeel(buttonLAF);

  //c.add(returnToWelcome);
}

void selectSaved() {
  //removeButtons();
}

void removeButtons() {
  if (returnToWelcome != null)
  c.remove(returnToWelcome);
}

void setupButtonLAF() {
  buttonLAF = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  buttonLAF.baseColor = palette[1];
  buttonLAF.textColor =  palette[0];
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
  }
}
