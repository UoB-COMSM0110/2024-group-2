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
    this.tankX = random(width - 50);
    this.turretAngle = 180;
    this.turretAdjustX = 30;
    this.turretAdjustY = 5;
    setTankY();
  }
  
  public void setTankY(){
    int index1 = int(this.tankX) + int(height - 1) * (int)width;
    int index2 = int(this.tankX) + 70 + int(height - 1) * (int)width;
    loadPixels();
    while(pixels[index1] != color(135, 206, 235) || pixels[index2] != color(135, 206, 235)){
      index1 -= width;
      index2 -= width;
    }
    if(pixels[index1] == color(135, 206, 235)){
      this.tankY = index1/width - 25;
    }else{
      this.tankY = index2/width - 25;
    }
  }
    
  
  public void renderTank(){
    shape(this.tankTurret, this.tankX + this.turretAdjustX, this.tankY + this.turretAdjustY, 40, 10);
    shape(this.tankBody, this.tankX, this.tankY, 70, 40);
  }
  
  public void moveTank(float moveDist){
    
    if(moveDist > 0 && this.tankX < (width - 70)){
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
  public float getTankY(){
    return this.tankY;
  }
  public float getTurretX(){
    return this.tankX + this.turretAdjustX;
  }
  
  public float getTurretY(){
    return this.tankY + this.turretAdjustY;
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
  public int getTurretAngle(){
    return this.turretAngle;
  }
  public PShape getTankTurret(){
    return this.tankTurret;
  }
}
