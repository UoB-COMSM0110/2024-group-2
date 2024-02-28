public class Weapon {
  
  //private int damage, type, count;
  private float x, y, speed;
  private boolean fire = false;
  
  public Weapon(float xi, float yi, float b_speed){
    this.x = xi;
    this.y = yi;
    this.speed = b_speed;
  }
  
  public void update(){
      if(this.x <= 0 || this.x >= width){
        this.fire = false;
      }
      if(this.fire){
        this.x += this.speed;  
      }
  }
  public void display(){
    fill(0,0,0);
    ellipse(this.x, this.y, 10, 10);
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
}
