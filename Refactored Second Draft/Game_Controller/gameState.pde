abstract class gameState {
  Boolean drawn = false;
  String page;
  Boolean buttons;
  Boolean buttonsOn;
  //This is a special case code to tell the game what to do at points where
  //you may be displaying a screen overlaying another one
  int opCode;
  /**
  * @Param c A GUIController where the screen which displays its elements
  * @return A string telling wha the next gamestate should be
  */
  String display(GUIController c){return "";}
  GUIController setUpButtons(GUIController c){return c;}
  GUIController clearScreen(GUIController c){return c;}
  
  Boolean needsButtons(){ return false;}
  void setButtonsOn(){ buttonsOn = true;}
  void setButtonsOff(){ buttonsOn = false; }
  void setButtonsNeedOff() {buttons = false;}
  String getPage(){return page;}
}
