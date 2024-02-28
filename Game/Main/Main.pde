Terrain terrain;
Tank tank;
Weapon smallMissile;
float time = 0;
boolean stop;

void setup() {
 size(1800, 960);
 background(135, 206, 235);
 terrain = new Terrain(0.0);
 shape(terrain.getTerrainShape());
 tank = new Tank();
 smallMissile = new Weapon(0, 0, 3);
 smooth();
 frameRate(100);
}


void draw() {
  background(135, 206, 235);
  shape(terrain.getTerrainShape());
  tank.renderTank();
  if(smallMissile.getFire()){
    smallMissile.update();
    smallMissile.display();
  }
  
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
  if(keyPressed && keyCode == BACKSPACE){
    smallMissile.setX(tank.getTankX());
    smallMissile.setY(tank.getTankY());
    smallMissile.setFire(true);
  }
}
