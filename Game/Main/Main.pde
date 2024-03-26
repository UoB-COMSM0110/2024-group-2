Terrain terrain;
ArrayList<Tank> tanks = new ArrayList<Tank>();
float time = 0;
boolean stop;
int tankIndex = 0;
boolean gameOver = false;
TimeBar shotBar;
TimeBar mapBar;

boolean isFiring = false;
Weapon currentWeapon;


void setup() {
 size(1800, 960);
 background(135, 206, 235);
 terrain = new Terrain(0.0);
 shape(terrain.getTerrainShape());
 //p1
 tanks.add(new Tank(true));
 //p2
 tanks.add(new Tank(false));
 smooth();
 frameRate(100);
 shotBar = new TimeBar(1590, 200, "Shot clock");
 mapBar = new TimeBar(10, 600, "Time to map shuffle");
}


void draw() {
  background(135, 206, 235);
  shape(terrain.getTerrainShape());

  shotBar.display();
  mapBar.display();

  tanks.get(0).renderCraters();
  tanks.get(1).renderCraters();

  tanks.get(0).renderTank();
  tanks.get(1).renderTank();
  frameRate(100);
  if(tanks.get(0).getDead() || tanks.get(1).getDead()){
    textSize(128);
    fill(255, 0, 0);
    shotBar.resetTime();
    mapBar.resetTime();
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2, height/2); 
    return;
  }
  float strikePoint = 0;
  if(isFiring){
    strikePoint = this.currentWeapon.update();
    if(abs(strikePoint - tanks.get(0).getTankX() - 35) < 50){
      tanks.get(0).decreaseHealth(20);
    }
    if(abs(strikePoint - tanks.get(1).getTankX() - 35) < 50){
      tanks.get(1).decreaseHealth(20);
    }
    shotBar.resetTime();
    this.currentWeapon.display();
  }
  
  if(this.currentWeapon != null){
    this.isFiring = this.currentWeapon.getFire();
  }
  
  if(keyPressed && keyCode == RIGHT && !isFiring){
    tanks.get(tankIndex).moveTank(1);
  }
  if(keyPressed && keyCode == LEFT && !isFiring){
    tanks.get(tankIndex).moveTank(-1);
  }
  if(keyPressed && keyCode == DOWN && !isFiring){
    tanks.get(tankIndex).rotateTurret(true);
  }
  if(keyPressed && keyCode == UP && !isFiring){
    tanks.get(tankIndex).rotateTurret(false);
  }
  if(keyPressed && key == ' ' && !isFiring){
    this.tanks.get(tankIndex).fireWeapon();
    this.isFiring = true;
    this.currentWeapon = this.tanks.get(tankIndex).getCurrentWeapon();
    if(tankIndex == 0){
      this.tanks.get(tankIndex).setCurrentPlayer(false);
      this.tankIndex = 1;
      this.tanks.get(tankIndex).setCurrentPlayer(true);
    }else{
      this.tanks.get(tankIndex).setCurrentPlayer(false);
      this.tankIndex = 0;
      this.tanks.get(tankIndex).setCurrentPlayer(true);
    }
  }
  if(shotBar.getTime() < 1){
    if(tankIndex == 0){
      tankIndex = 1;
    }else{
      tankIndex = 0;
    }
    shotBar.resetTime();
  }
  
  if(keyPressed && key == '=' && !isFiring){
    this.tanks.get(tankIndex).increasePower();
  }
  if(keyPressed && key == '-' && !isFiring){
    this.tanks.get(tankIndex).decreasePower();
  }
  //map change
  if(mapBar.getTime() < 1) {
    this.terrain.setTerrainShape(random(0, 5));
    this.mapBar.resetTime();
    this.tanks.get(0).shufflePosition();
    this.tanks.get(1).shufflePosition();
  }
}
 
