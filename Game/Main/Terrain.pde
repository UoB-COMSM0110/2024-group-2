public class Terrain {
  private PShape terrainShape;  
  
  public Terrain(float yoff){
      this.setTerrainShape(yoff);
  }
  public PShape getTerrainShape(){
    return this.terrainShape;
  }
  
  public void setTerrainShape(float yoff) {
    this.terrainShape = createShape();
    this.terrainShape.beginShape();
    this.terrainShape.fill(0, 154, 23);
    this.terrainShape.stroke(0, 154, 23);
    float xoff = yoff;  
  // Iterate over horizontal pixels
    for (float x = 0; x <= width; x += 10) {
      // Calculate a y value according to noise, map to 
      float y = map(noise(xoff), 0, 1, 700, 200);  
      // Set the vertex
      this.terrainShape.vertex(x, y); 
      // Increment x dimension for noise
      xoff += 0.05;
    }
    this.terrainShape.vertex(width, height);
    this.terrainShape.vertex(0, height);
    this.terrainShape.endShape(CLOSE);
  }
    
}
