public class Weapon {
  
  //private int damage, type, count;
  private float x, y, speedX, speedY;
  private int theta;
  private boolean fire = false;
  private ArrayList<Crater> craters = new ArrayList<Crater>();
  
  public Weapon(float xi, float yi, float iSpeed, int t){
    this.x = xi;
    this.y = yi;
    this.speedX = iSpeed;
    this.speedY = iSpeed;
    this.theta = t;
  }
  
  public void update(){
      if(dontUpdate(this.x, this.y)){
        this.fire = false;
        this.speedY = this.speedX;
        fill(135, 206, 235);
        this.craters.add(new Crater(this.x, this.y, 100));
      }
      if(this.fire){
        this.x -= cos(radians(this.theta)) * this.speedX;  
        this.y -= sin(radians(this.theta)) * this.speedY;
        this.speedY -= 0.02;
      }
  }
  private boolean dontUpdate(float x, float y){
    int index = int(x) + int(y - 1) * (int)width;
    loadPixels();
    boolean stop = (pixels[index] == color(0, 154, 23));
    if(x <= 0 || x >= width || y <= 0 || y >= height || stop){
      return true;
    }
    return false;
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
    public int getTheta(){
    return this.theta;
  }
  public void displayCraters(){
    for(Crater c : craters){
      
  }
}
