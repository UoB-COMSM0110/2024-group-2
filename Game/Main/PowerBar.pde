public class PowerBar {
  float x, y;
  int height, width;
  float maxValue, minValue, value;
  
  public PowerBar(){
    this.value = 3;
    this.maxValue = 5;
    this.minValue = 1;
    this.width = 400;
    this.height = 20;
    this.x = 850;
    this.y = 900;
  }
  
  public void display(){
    fill(0, 0, 0);
    rect(this.x, this.y, this.width, this.height);
    textAlign(CENTER, CENTER);
    textSize(20);
    fill(0, 0, 0);
    text("Shot power", this.x + this.width/2, this.y-12);
    float activeWidth = map(this.value, this.minValue, this.maxValue, 0, this.width);
    stroke(0);
    fill(0,255,0);
    rect(this.x, this.y, activeWidth, this.height);
  }
  
  public void decrease(){
    if(this.value > this.minValue + 0.02){
      this.value -= 0.02;
    }else{
      this.value = this.minValue;
    }
  }
  
  public void increase(){
    if(this.value < this.maxValue - 0.02){
      this.value += 0.02;
    }else{
      this.value = this.maxValue;
    }
  }
  
  public float getValue(){
    return this.value;
  }
}
