float yoff = 0.0;
PShape terrain;

void setup() {
 size(1500, 800);
 
 terrain = createShape();
 terrain.beginShape();
 terrain.fill(0, 154, 23);
 terrain.stroke(0, 154, 23);
 float xoff = yoff;  
  // Iterate over horizontal pixels
  for (float x = 0; x <= width; x += 10) {
    // Calculate a y value according to noise, map to 
    float y = map(noise(xoff), 0, 1, 700, 200);
    
    // Set the vertex
    terrain.vertex(x, y); 
    // Increment x dimension for noise
    xoff += 0.05;
  }
  terrain.vertex(width, height);
  terrain.vertex(0, height);
  terrain.endShape(CLOSE);
 
}

void draw() {
  background(135, 206, 235);
  shape(terrain);
 
}
