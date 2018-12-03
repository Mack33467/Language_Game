class turnScreen extends gameState {
  PImage pageBg; // Background image for welcome, instructions, and credits pages
  PImage prevImage; // The previous turn box
  PImage canvas; //The current turn box
  int[] palette;

  turnScreen(paletteControls p) {
    palette = p.palette;
    prevImage = createImage(displayWidth/2 - 20, displayHeight - 200, RGB);
    prevImage.loadPixels();
    for (int i = 0; i < prevImage.pixels.length; i++) {
      prevImage.pixels[i] = palette[2];
    }
    prevImage.updatePixels();

    canvas = createImage(displayWidth/2 - 20, displayHeight - 200, RGB);
    canvas.loadPixels();
    for (int i = 0; i < canvas.pixels.length; i++) {
      canvas.pixels[i] = palette[3];
    }
    canvas.updatePixels();
    page = "TURN";
    buttons = true;
    buttonsOn = false;
  }


  String display(GUIController c) {
    if (drawn) {
      if ((mouseX >= displayWidth/2) && (mouseX <= displayWidth - 10) 
        && (mouseY >= 100) && (mouseY <= displayHeight - 100)) {
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
              int pixel = (((y - 100) * (displayWidth/2 - 20) + (x - displayWidth/2))) % (canvas.pixels.length);
              if (pixel < 0)
                pixel *= -1;
              canvas.pixels[pixel] = palette[1];
            }
          }
          canvas.updatePixels();
        }
      } else {
        cursor(ARROW);
      }
    }
    drawn = true;
    image(prevImage, 10, 100);
    image(canvas, displayWidth/2, 100);
    return "TURN";
  }

  Boolean needsButtons() { 
    return true;
  }
  
  
}
