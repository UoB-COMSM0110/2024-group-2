public class Weapon {
  
  //private int damage, type, count;
  private float x, y, speedX, speedY, iSpeed, theta;
  private boolean fire = false;
  private ArrayList<Crater> craters = new ArrayList<Crater>();
  private String type;
  
  public Weapon(String type){
    this.type = type;
    this.iSpeed = 4;
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
        this.x -= this.speedX;  
        this.y -= this.speedY;
        this.speedY -= 0.02;
      }
      return 0;
  }
  private boolean dontUpdate(float x, float y){
    int index = int(x) + int(y - 15) * (int)width;
    // to allow projectile to go off the top of the screen and come back
    if(index < 0 ) {
      return false;
    }
    loadPixels();
    boolean stop = (pixels[index] != color(135, 206, 235)) && (pixels[index] != color(0, 0, 0));
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
    this.theta = radians(t);
    this.speedX = this.iSpeed * cos(this.theta) ;
    this.speedY = this.iSpeed * sin(this.theta);
  }
  public float getTheta(){
    return this.theta;
  }
  public void displayCraters(){
    for(Crater c : craters){
      fill(135, 206, 235);
      noStroke();
      ellipse(c.getX(), c.getY(), c.getSize(), c.getSize());
    }
  }
  public void setISpeed(float value){
    this.iSpeed = value;
  }
}
