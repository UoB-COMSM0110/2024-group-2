public class Weapon {
  
  //private int damage, type, count;
  private float x, y, speed;
  private int theta;
  private boolean fire = false;
  
  public Weapon(float xi, float yi, float b_speed, int t){
    this.x = xi;
    this.y = yi;
    this.speed = b_speed;
    this.theta = t;
  }
  
  public void update(){
      if(this.x <= 0 || this.x >= width || this.y <= 0 || this.y >= height){
        this.fire = false;
      }
      if(this.fire){
        this.x -= cos(radians(this.theta)) * this.speed;  
        this.y -= sin(radians(this.theta)) * this.speed;
      }
  }
  public void display(){
    fill(0,0,0);
    ellipse(this.x, this.y, 7, 7);
  }
  public void setX(float val){
    this.x = val;
  }
  public void setY(float val){
    this.y = val;
  }
  public void setFire(boolean val){
    this.fire = val;
  }
  public boolean getFire(){
    return this.fire;
  }
  public void setTheta(int t){
    this.theta = t;
  }
}
