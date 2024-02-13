float yoff = 0.0; 

void setup() {
 size(1500, 800);
 
}

void draw() {
  background(135, 206, 235);

  fill(0, 154, 23);
  stroke(0, 154, 23);
  beginShape(); 

  float xoff = yoff;  
  // Iterate over horizontal pixels
  for (float x = 0; x <= width; x += 10) {
    // Calculate a y value according to noise, map to 
    float y = map(noise(xoff), 0, 1, 700, 200);
    
    // Set the vertex
    vertex(x, y); 
    // Increment x dimension for noise
    xoff += 0.05;
  }
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}
