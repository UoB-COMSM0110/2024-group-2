class TimeBar{
  private float actualWidth;
  private float gapWidth;
  private float duration;
  private float rectX;
  TimeBar(float xPos){
    actualWidth = 200;
    gapWidth = 8;
    duration = 80;
    this.rectX = xPos;
  }
  void setTime(int width){
    actualWidth = width;
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
    
    float rectWidth = 200;
    float rectHeight = 15;
    
    //float rectX = (width - rectWidth) - 10;
    float rectY = 900;
    
    rect(rectX, rectY, this.actualWidth, rectHeight);
    
    textAlign(CENTER, CENTER);
    textSize(20);
    fill(0, 0, 0);
    text("Shot clock", rectX + rectWidth/2, rectY-12);
    
    fill(0);
    
    rect(rectX, rectY, rectWidth, 2);
    rect(rectX, rectY + rectHeight - 2, rectWidth, 2);
    rect(rectX, rectY, 2, rectHeight);
    rect(rectX + rectWidth - 2, rectY, 2, rectHeight);
    }
}
