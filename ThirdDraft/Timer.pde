// This class was created with the help of the YouTube video "02-Processing-Creating a Timer Class," published by Christopher Ockerby on 10/22/17.

public class Timer {
  float Time;
  
  Timer(float time) {
    this.Time = time;
  }
  
  // Getters and Setters
  float getTime() {
    return this.Time;
  }
  void setTime(float time) {
    this.Time = time;
  }
  
  void countDown() {
    this.Time -= 1/frameRate;
  }
}
