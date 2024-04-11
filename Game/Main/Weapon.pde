public class Weapon {
  
  private int damage, count, blastRadius;
  private float x, y, speedX, speedY, iSpeed, theta;
  private boolean fire = false;
  private ArrayList<Crater> craters = new ArrayList<Crater>();
  private String type;
  
  public Weapon(String type, int count){
    this.type = type;
    this.iSpeed = 3.5;
    this.count = count;
    switch(this.type) {
      case "Small missile":
        this.damage = 15;
        this.blastRadius = 100;
        break;
      case "Medium missile":
        this.damage = 25;
        this.blastRadius = 150;
        break;
      case "Large missile":
        this.damage = 35;
        this.blastRadius = 250;
        break;
      case "Ballistic missile":
        this.damage = 100;
        this.blastRadius = 500;
        break;
      default:
        break;      
    }
    
  }
  
  public float update(){
      if(dontUpdate(this.x, this.y)){
        this.fire = false;
        this.speedY = this.speedX;
        fill(255, 255, 0);
        noStroke();
        frameRate(10);
        ellipse(this.x, this.y, this.blastRadius, this.blastRadius);
        this.craters.add(new Crater(this.x, this.y, this.blastRadius));

        return this.x;
      }
      if(this.fire){
        this.x -= this.speedX;  
        this.y -= this.speedY;
        this.speedY -= 0.02;
      }
      return -500;
  }
  private boolean dontUpdate(float x, float y){
    int index = int(x) + int(y) * (int)width;
    // to allow projectile to go off the top of the screen and come back
    if(index < 0 ) {
      return false;
    }
    loadPixels();
    boolean stop = (pixels[index] != color(135, 206, 235)) && (pixels[index] != color(0, 0, 0));
    if(x <= 0 || x >= width || y >= height || stop){
      return true;
    }
    return false;
  }
  public void display(){
    fill(0,0,0);
    strokeWeight(2);
    stroke(0);
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
  public void setTheta(int t, boolean isHumanControlled){
    this.theta = radians(t);
    
    this.speedX = this.iSpeed * cos(this.theta);
    
    if(isHumanControlled) {
      this.speedX += windSpeed;
    }
    
    

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
  
  public ArrayList<Crater> getCraters() {
    return this.craters;
  }
  
  public void setISpeed(float value){
    this.iSpeed = value;
  }
  
  public float getY() {
    return this.y;
  }
  
  public void removeCraters(){
    this.craters.clear();
  }
  
  public int getCount() {
    return this.count;
  }
  
  public void buy() {
    this.count++;
  }
  
  public int getDamage() {
    return this.damage;
  }
  
  public int getBlastRadius() {
    return this.blastRadius/2;
  }
  
  public void decreaseCount() {
    this.count--;
  }
  
  public String getType() {
    return this.type;
  }

}
