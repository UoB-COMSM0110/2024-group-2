public class Tank{
  
  private PShape tankBody;
  private float tankX;
  private float tankY;
  private PShape tankTurret;
  private int turretAngle;
  private float turretAdjustX;
  private float turretAdjustY;
  
  public Tank(){
    this.tankBody = loadShape("tankBody.svg");
    this.tankTurret = loadShape("tankTurret.svg");
    this.tankBody.setFill(color(255, 255, 0));
    this.tankX = random(width - 50);
    this.turretAngle = 180;
    this.turretAdjustX = 30;
    this.turretAdjustY = 5;
    setTankY();
  }
  
  public void setTankY(){
    int index = int(this.tankX) + int(height - 1) * (int)width;
    loadPixels();
    while(pixels[index] != color(135, 206, 235)){
      index -= width;
    }
    this.tankY = index/width - 40;
  }
  
  public void renderTank(){
    shape(this.tankTurret, this.tankX + this.turretAdjustX, this.tankY + this.turretAdjustY, 40, 10);
    shape(this.tankBody, this.tankX, this.tankY, 70, 40);
  }
  
  public void moveTank(float moveDist){
    
    if(moveDist > 0 && this.tankX < (width - 50)){
      this.tankX += moveDist;
      setTankY();
      
    }
    if(moveDist < 0 && this.tankX > 0){
      this.tankX += moveDist;
      setTankY();
    }
  }
  public float getTankX(){
    return this.tankX;
  }
  public void rotateTurret(boolean clockwise){
    if(clockwise && this.turretAngle < 180){
      this.tankTurret.rotate(radians(1));
      this.turretAngle +=1;
      this.turretAdjustY -= 0.053;
      this.turretAdjustX -= 0.03;
    }
    if(!clockwise && this.turretAngle > 0){
      this.tankTurret.rotate(radians(-1));
      this.turretAngle -= 1;
      this.turretAdjustY += 0.053;
      this.turretAdjustX += 0.03;
    }
  }
}
