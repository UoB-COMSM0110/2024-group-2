public class Timer {
  int startTime;
  int elapsedTime;
  int duration;
  int timeLeft;
  
  public Timer(int duration) {
    this.startTime = millis();
    this.duration = duration * 1000;
    this.timeLeft = duration;
  }
  
  public void calcElapsedTime() {
    this.elapsedTime = millis() - this.startTime;
    this.timeLeft = this.duration - this.elapsedTime;
  }
  
  public void resetTimer() {
    this.startTime = millis();
    this.calcElapsedTime();
  }
  
  public void renderTimer() {
    this.calcElapsedTime();
    textAlign(LEFT, CENTER);
    textSize(32);
    fill(255, 0, 0);
    text("Time to map change: " + this.timeLeft/1000, 50, 880);
  }
  
  public int getTimeLeft(){
    return this.timeLeft;
  }
}
