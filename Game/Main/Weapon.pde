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
  
  public float update(){
      if(dontUpdate(this.x, this.y)){
        this.fire = false;
        this.speedY = this.speedX;
        fill(255, 255, 0);
        noStroke();
        frameRate(10);
        ellipse(this.x, this.y, 100, 100);
        this.craters.add(new Crater(this.x, this.y, 100));
        return this.x;
      }
      if(this.fire){
        this.x -= cos(radians(this.theta)) * this.speedX;  
        this.y -= sin(radians(this.theta)) * this.speedY - 0.05;
        this.speedY -= 0.02;
      }
      return 0;
  }
  private boolean dontUpdate(float x, float y){
    int index = int(x) + int(y - 8) * (int)width;
    loadPixels();
    boolean stop = (pixels[index] != color(135, 206, 235));
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
      fill(135, 206, 235);
      noStroke();
      ellipse(c.getX(), c.getY(), c.getSize(), c.getSize());
    }
  }
}
