float yoff = 0.0;
PShape terrain;
PImage tank;
float tankX = 0;

void setup() {
 size(1500, 800);
 
 tank = loadImage("tank.png");
 
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

float getTankY(float tankX){
  int index = int(tankX) + int(height - 1) * (int)width;
  loadPixels();
  while(pixels[index] != color(135, 206, 235)){
    index -= width;
  }
  return index/width - 50;
}

void draw() {
  
  background(135, 206, 235);
  shape(terrain);
  
  float tankY = getTankY(tankX);
  pushMatrix();
  image(tank, tankX, tankY, 50, 50);
  popMatrix();
  
  if(keyPressed && keyCode == RIGHT && tankX < (width - 50)){
    tankX += 1;
  }
  
  if(keyPressed && keyCode == LEFT && tankX > 0){
    tankX -= 1;
  }
 
}
