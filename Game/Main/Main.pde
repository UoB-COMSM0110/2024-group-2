Terrain terrain;
Tank tank;

void setup() {
 size(1500, 800);
 background(135, 206, 235);
 terrain = new Terrain(0.0);
 shape(terrain.getTerrainShape());
 tank = new Tank();
 
}


void draw() {
  background(135, 206, 235);
  shape(terrain.getTerrainShape());
  tank.renderTank();
  
  if(keyPressed && keyCode == RIGHT){
    tank.moveTank(1);
  }
  if(keyPressed && keyCode == LEFT){
    tank.moveTank(-1);
  }
  if(keyPressed && keyCode == DOWN){
    tank.rotateTurret(true);
  }
  if(keyPressed && keyCode == UP){
    tank.rotateTurret(false);
  }
}
