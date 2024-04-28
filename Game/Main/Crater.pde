// Class which is responsible for storing map damage

public class Crater{
  
  //coordinates
  private float x, y;
  //crater radius
  private int size;
  
  public Crater(float x, float y, int size){
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  public float getX(){
    return this.x;
  }
  
  public float getY(){
    return this.y;
  }
  
  public int getSize(){
    return this.size;
  }
}
