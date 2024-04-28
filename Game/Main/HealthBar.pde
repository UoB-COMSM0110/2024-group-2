// health bar of each tank
public class HealthBar {
  float x, y;
  int maxValue, value, height, width;
  
  public HealthBar(){
    this.value = 100;
    this.maxValue = 100;
    this.width = 50;
    this.height = 10;
  }
  
  public void update(float tankX, float tankY){
    this.x = tankX + 10;
    this.y = tankY + 45;
  }
  public void display(){
    stroke(0);
    strokeWeight(1);
    fill(255, 0, 0);
    rect(this.x, this.y, 50, 10);
    float activeWidth = map(this.value, 0, this.maxValue, 0, this.width);
    fill(0,255,0);
    rect(this.x, this.y, activeWidth, this.height);
  }
  
  public void decreaseHealth(int amount){
    this.value -= amount;
  }
  public int getValue(){
    return this.value;
  }
  
  public void restore(){
    this.value = this.maxValue;
  }
}
