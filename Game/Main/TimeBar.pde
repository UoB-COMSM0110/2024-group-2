class TimeBar{
  private float actualWidth;
  private float gapWidth;
  private float duration;
  private float rectX;
  private float rectWidth;
  private String label;
  TimeBar(float xPos, float actualWidth, String label){
    this.actualWidth = actualWidth;
    gapWidth = 8;
    duration = 80;
    this.rectX = xPos;
    this.rectWidth = actualWidth;
    this.label = label;
  }
  void resetTime(){
    actualWidth = rectWidth;
  }
  float getTime(){
    return this.actualWidth;
  }
  
  void display(){
    float decreasePerFrame = this.gapWidth / this.duration;
    
    if(this.actualWidth > 0){
      this.actualWidth -= decreasePerFrame;
    }
    
    fill(255, 0, 0);
    noStroke();
    
    float rectHeight = 15;
    
    //float rectX = (width - rectWidth) - 10;
    float rectY = 900;
    
    rect(rectX, rectY, this.actualWidth, rectHeight);
    
    textAlign(CENTER, CENTER);
    textSize(20);
    fill(0, 0, 0);
    text(this.label, rectX + rectWidth/2, rectY-12);
    
    fill(0);
    
    rect(rectX, rectY, rectWidth, 2);
    rect(rectX, rectY + rectHeight - 2, rectWidth, 2);
    rect(rectX, rectY, 2, rectHeight);
    rect(rectX + rectWidth - 2, rectY, 2, rectHeight);
    }
}
