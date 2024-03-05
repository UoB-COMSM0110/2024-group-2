Terrain terrain;
ArrayList<Tank> tanks = new ArrayList<Tank>();
Weapon smallMissile;
float time = 0;
boolean stop;
int tankIndex = 0;

void setup() {
 size(1800, 960);
 background(135, 206, 235);
 terrain = new Terrain(0.0);
 shape(terrain.getTerrainShape());
 //p1
 tanks.add(new Tank());
 //p2
 tanks.add(new Tank());
 smallMissile = new Weapon(0, 0, 3, 0);
 smooth();
 frameRate(100);
}


void draw() {
  background(135, 206, 235);
  shape(terrain.getTerrainShape());
  smallMissile.displayCraters();
  tanks.get(0).renderTank();
  tanks.get(1).renderTank();
  frameRate(100);
  if(smallMissile.getFire()){
    smallMissile.update();
    smallMissile.display();
  }
  
  if(keyPressed && keyCode == RIGHT){
    tanks.get(tankIndex).moveTank(1);
  }
  if(keyPressed && keyCode == LEFT){
    tanks.get(tankIndex).moveTank(-1);
  }
  if(keyPressed && keyCode == DOWN){
    tanks.get(tankIndex).rotateTurret(true);
  }
  if(keyPressed && keyCode == UP){
    tanks.get(tankIndex).rotateTurret(false);
  }
  if(keyPressed && key == ' ' && !smallMissile.getFire()){
    smallMissile.setX(tanks.get(tankIndex).getTurretX() - cos(radians(tanks.get(tankIndex).getTurretAngle())) * 20);
    smallMissile.setY(tanks.get(tankIndex).getTurretY()- sin(radians(tanks.get(tankIndex).getTurretAngle())) * 20);
    smallMissile.setFire(true);
    smallMissile.setTheta(tanks.get(tankIndex).getTurretAngle());
    if(tankIndex == 0){
      tankIndex = 1;
    }else{
      tankIndex = 0;
    }
  }
}