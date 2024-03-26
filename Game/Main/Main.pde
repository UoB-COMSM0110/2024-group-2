Terrain terrain;
ArrayList<Tank> tanks = new ArrayList<Tank>();
Weapon smallMissile;
float time = 0;
boolean stop;
int tankIndex = 0;
boolean gameOver = false;
TimeBar bar = new TimeBar();


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
  bar.display();
  tanks.get(0).renderTank();
  tanks.get(1).renderTank();
  frameRate(100);
  if(tanks.get(0).getDead() || tanks.get(1).getDead()){
    textSize(128);
    fill(255, 0, 0);
    bar.setTime(0);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2, height/2); 
    return;
  }
  float strikePoint = 0;
  if(smallMissile.getFire()){
    strikePoint = smallMissile.update();
    if(abs(strikePoint - tanks.get(0).getTankX() - 35) < 50){
      tanks.get(0).decreaseHealth(20);
    }
    if(abs(strikePoint - tanks.get(1).getTankX() - 35) < 50){
      tanks.get(1).decreaseHealth(20);
    }
    smallMissile.display();
    bar.setTime(200);

  }
  
  if(keyPressed && keyCode == RIGHT && !smallMissile.getFire()){
    tanks.get(tankIndex).moveTank(1);
  }
  if(keyPressed && keyCode == LEFT && !smallMissile.getFire()){
    tanks.get(tankIndex).moveTank(-1);
  }
  if(keyPressed && keyCode == DOWN && !smallMissile.getFire()){
    tanks.get(tankIndex).rotateTurret(true);
  }
  if(keyPressed && keyCode == UP && !smallMissile.getFire()){
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
  if(bar.getTime() < 1){
    if(tankIndex == 0){
      tankIndex = 1;
    }else{
      tankIndex = 0;
    }
    bar.setTime(200);
  }
}
