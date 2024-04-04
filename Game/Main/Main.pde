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
PImage customCursor;

enum GameState {
  START_MENU,
  GAME_PLAY,
  GAME_OVER
}

GameState gameState = GameState.START_MENU;
GameStart gameStartScreen;

void setup() {
 size(1800, 960);
 background(135, 206, 235);
 customCursor = loadImage("custom_cursor.png");
 cursor(customCursor, 5, 5);
 
 gameStartScreen = new GameStart(this);
 
 terrain = new Terrain(0.0);
 shape(terrain.getTerrainShape());
 //p1
 tanks.add(new Tank(true, true));
 //p2
 tanks.add(new Tank(false, false));
 smooth();
 frameRate(100);
 shotBar = new TimeBar(1590, 200, "Shot clock");
 mapBar = new TimeBar(10, 600, "Time to map shuffle");
}


void draw() {
  background(135, 206, 235);
  
  //game state switcher
  switch (gameState) {
    case START_MENU:
      gameStartScreen.display();
      break;
    case GAME_PLAY:
      shape(terrain.getTerrainShape());
      shotBar.display();
      mapBar.display();
      tanks.get(0).renderCraters();
      tanks.get(1).renderCraters();
      tanks.get(0).renderTank();
      tanks.get(1).renderTank();
      break;      
    case GAME_OVER:
      displayGameOverScreen();
      break;
  }
  
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
  float strikeX = 0;
  float strikeY = 0;
  if(isFiring){
    strikeX = this.currentWeapon.update();
    strikeY = this.currentWeapon.getY();
    if(abs(strikeX - tanks.get(0).getTankX() - 35) < 50 && abs(strikeY - tanks.get(0).getTankY()) < 50 ){
      tanks.get(0).decreaseHealth(20);
    }
    if(abs(strikeX - tanks.get(1).getTankX() - 35) < 50 && abs(strikeY - tanks.get(1).getTankY()) < 50){
      tanks.get(1).decreaseHealth(20);
    }
    shotBar.resetTime();
    this.currentWeapon.display();
  }
  
  if(this.currentWeapon != null){
    this.isFiring = this.currentWeapon.getFire();
  }
  
  //ai tank fire
  if(!this.tanks.get(tankIndex).getIsHumanControlled() && !isFiring){
    this.tanks.get(tankIndex).fireWeapon();
    this.isFiring = true;
    this.currentWeapon = this.tanks.get(tankIndex).getCurrentWeapon();
    switchPlayer();
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
    switchPlayer();
  }
  if(shotBar.getTime() < 1){
    switchPlayer();
    shotBar.resetTime();
  }
  
  if(keyPressed && key == '=' && !isFiring){
    this.tanks.get(tankIndex).increasePower();
  }
  if(keyPressed && key == '-' && !isFiring){
    this.tanks.get(tankIndex).decreasePower();
  }
  //map change
  if(mapBar.getTime() < 1 && !isFiring) {
    this.terrain.setTerrainShape(random(0, 5));
    this.mapBar.resetTime();
    this.tanks.get(0).shufflePosition();
    this.tanks.get(1).shufflePosition();
    this.tanks.get(0).removeAllCraters();
    this.tanks.get(1).removeAllCraters();
  }
}

void switchPlayer() {
  
  if(tankIndex == 0){
    this.tanks.get(tankIndex).setCurrentPlayer(false);
    this.tankIndex = 1;
    this.tanks.get(tankIndex).setCurrentPlayer(true);
  }else{
    this.tanks.get(tankIndex).setCurrentPlayer(false);
    this.tankIndex = 0;
    this.tanks.get(tankIndex).setCurrentPlayer(true);
  }
  
  if(!this.tanks.get(tankIndex).getIsHumanControlled()){
    aiTurretAdjust();
  }
}

void aiTurretAdjust() {
  
  int opIndex = (tankIndex - 1) * -1;
  
  float opX = this.tanks.get(opIndex).getTankX();
  float opY = this.tanks.get(opIndex).getTankY();
  
  
  float xDist = this.tanks.get(tankIndex).getTurretX() - opX;
  float yDist = this.tanks.get(tankIndex).getTurretY() - opY;
  int turretAdjust;
  float iSpeed;
  
  
  if(xDist < 0) {
    turretAdjust = this.tanks.get(tankIndex).getTurretAngle() - 135;
    iSpeed = aiCalcISpeed(-xDist, yDist);
  } else {
    turretAdjust = this.tanks.get(tankIndex).getTurretAngle() - 45;
    iSpeed = aiCalcISpeed(xDist, yDist);
  }
  
  if(turretAdjust < 0) {
    for(int i = turretAdjust; i < 0; i++) {
      tanks.get(tankIndex).rotateTurret(true);
    }
  } else {
    for(int i = 0; i < turretAdjust; i++) {
      tanks.get(tankIndex).rotateTurret(false);
    }
  }
  tanks.get(tankIndex).getCurrentWeapon().setISpeed(iSpeed);
}

float aiCalcISpeed(float absXDist, float yDist) {
  
  float iSpeed;
  if(yDist > 0){
    iSpeed = (0.5 + 0.25*yDist/absXDist) * absXDist * 0.02 * sin(radians(45)) * sin(radians(45));
  }else{
    iSpeed = 0.5 * absXDist * 0.02 * sin(radians(45)) * sin(radians(45));
  }
  return iSpeed;
}

public void displayGameOverScreen() {
  textSize(128);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2);
}

public void mousePressed() {
    // 只有在开始菜单状态下才处理鼠标点击
    if (gameState == GameState.START_MENU) {
      gameStartScreen.mousePressed();
    }
    // 检查是否准备好开始游戏
    //if (gameStartScreen.isStartGameRequested()) {
      //gameState = GameState.GAME_PLAY; // 更新游戏状态
      //gameStartScreen.startGameRequested = false; // 重置请求开始游戏的标志
    //}
}
