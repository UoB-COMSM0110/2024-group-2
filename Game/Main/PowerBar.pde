public class PowerBar {
  float x, y;
  int height, width;
  float maxValue, minValue, value;
  
  public PowerBar(){
    this.value = 4;
    this.maxValue = 5;
    this.minValue = 3;
    this.width = 200;
    this.height = 50;
    this.x = 850;
    this.y = 850;
  }
  
  public void display(){
    fill(0, 0, 0);
    rect(this.x, this.y, this.width, this.height);
    float activeWidth = map(this.value, this.minValue, this.maxValue, 0, this.width);
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
