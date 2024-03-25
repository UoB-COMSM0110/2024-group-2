Terrain terrain;
ArrayList<Tank> tanks = new ArrayList<Tank>();
float time = 0;
boolean stop;
int tankIndex = 0;
boolean gameOver = false;
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
}


void draw() {
  background(135, 206, 235);
  shape(terrain.getTerrainShape());
  tanks.get(0).renderTank();
  tanks.get(1).renderTank();
  frameRate(100);
  if(tanks.get(0).getDead() || tanks.get(1).getDead()){
    textSize(128);
    fill(255, 0, 0);
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
  if(keyPressed && key == '=' && !isFiring){
    this.tanks.get(tankIndex).increasePower();
  }
  if(keyPressed && key == '-' && !isFiring){
    this.tanks.get(tankIndex).decreasePower();
  }
}
