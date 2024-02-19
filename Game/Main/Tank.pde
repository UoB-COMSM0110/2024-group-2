public class Tank{
  
  private PImage image;
  private float tankX;
  private float tankY;
  
  public Tank(){
    this.image = loadImage("tank.png");
    this.tankX = random(width - 50);
    setTankY();
  }
  
  public void setTankY(){
    int index = int(this.tankX) + int(height - 1) * (int)width;
    loadPixels();
    while(pixels[index] != color(135, 206, 235)){
      index -= width;
    }
    this.tankY = index/width - 50;
  }
  
  public void renderTank(){
    pushMatrix();
    image(this.image, this.tankX, this.tankY, 50, 50);
    popMatrix();
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
}
