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
int nRounds;
int currentRound;
int endRound;
int shuffleDelay;

enum GameState {
  START_MENU,
  GAME_PLAY_1,
  GAME_PLAY_2,
  SHOP,
  GAME_OVER
}


GameState playingState;
GameState gameState = GameState.SHOP;
GameStart gameStartScreen;
GameOver gameOverScreen;
Shop shop;

void setup() {
 size(1800, 960);
 background(135, 206, 235);
 this.customCursor = loadImage("custom_cursor.png");
 cursor(this.customCursor, 5, 5);
 
 this.gameStartScreen = new GameStart(this);
 this.gameOverScreen = new GameOver(this);
 this.shop = new Shop(this);
 
 this.terrain = new Terrain(0.0);
 this.currentRound = 1;
 shape(terrain.getTerrainShape());
 
 //for play again
 this.tanks.clear();
 //p1
 this.tanks.add(new Tank(true, true, "Blue"));
 //p2 - default cpu controlled
 this.tanks.add(new Tank(false, false, "Red"));
 smooth();
 frameRate(100);
 this.shotBar = new TimeBar(1590, 200, "Shot clock");
 this.mapBar = new TimeBar(10, 600, "Time to map shuffle");
}


void draw() {
  background(135, 206, 235);
  frameRate(100);
  
  while(this.endRound > millis()) {
    displayNextRoundScreen();
    return;
  }
  
  while(this.shuffleDelay > millis()) {
    textSize(128);
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    text("Map Shuffle!", width/2, height/2);
    textAlign(LEFT, BASELINE);
    return;
  }
  
  //game state switcher
  switch (gameState) {
    case START_MENU:
      gameStartScreen.display();
      break;
    case GAME_PLAY_1:
      playingState = GameState.GAME_PLAY_1;
      gameEngine();
      break;
    case GAME_PLAY_2:
      playingState = GameState.GAME_PLAY_2;
      this.tanks.get(1).setIsHumanControlled(true);
      gameEngine();
      break;
    case SHOP:
        this.shop.display();
        break;
    case GAME_OVER:
      gameOverScreen.setWinner("Blue");
      gameOverScreen.display();
      break;
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

public void displayNextRoundScreen() {
    textSize(128);
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    text("Round " + this.currentRound + "/" + this.nRounds + "!", width/2, height/2); 
    textAlign(LEFT, BASELINE);
}

public void gameEngine() {
  shape(this.terrain.getTerrainShape());
  this.shotBar.display();
  this.mapBar.display();
  this.tanks.get(0).renderCraters();
  this.tanks.get(1).renderCraters();
  this.tanks.get(0).renderTank();
  this.tanks.get(1).renderTank();
  
  if(this.tanks.get(0).getDead() || this.tanks.get(1).getDead()){
    if(this.tanks.get(0).getDead() && !this.tanks.get(1).getDead()){
      this.tanks.get(1).winRound();
    } else if (!this.tanks.get(0).getDead()) {
      this.tanks.get(0).winRound();
    } else {
      this.tanks.get(0).drawRound();
      this.tanks.get(1).drawRound();
    }
    
    if(this.currentRound == this.nRounds) {
      gameState = GameState.GAME_OVER;
    }else {
      startNextRound();
      gameState = GameState.SHOP;
    }
    return;
  }
  
  float strikeX = 0;
  float strikeY = 0;
  if(isFiring){
    strikeX = this.currentWeapon.update();
    strikeY = this.currentWeapon.getY();
    if(abs(strikeX - this.tanks.get(0).getTankX() - 35) < 50 && abs(strikeY - this.tanks.get(0).getTankY()) < 50 ){
      this.tanks.get(0).decreaseHealth(20);
      if(tankIndex == 1) {
        // + $25 for successful hit
        this.tanks.get(1).successfulHit();
      }
    }
    if(abs(strikeX - this.tanks.get(1).getTankX() - 35) < 50 && abs(strikeY - this.tanks.get(1).getTankY()) < 50){
      this.tanks.get(1).decreaseHealth(20);
      if(tankIndex == 0) {
        this.tanks.get(0).successfulHit();
      }
    }
    shotBar.resetTime();
    this.currentWeapon.display();
  }
  
  if(this.currentWeapon != null){
    this.isFiring = this.currentWeapon.getFire();
  }
  
  //ai tank fire
  if(!this.tanks.get(tankIndex).getIsHumanControlled() && !this.isFiring){
    aiTurretAdjust();
    this.tanks.get(tankIndex).fireWeapon();
    this.isFiring = true;
    this.currentWeapon = this.tanks.get(tankIndex).getCurrentWeapon();
    switchPlayer();
  }
  
  if(keyPressed && keyCode == RIGHT && !this.isFiring){
    this.tanks.get(tankIndex).moveTank(1);
  }
  if(keyPressed && keyCode == LEFT && !this.isFiring){
    this.tanks.get(tankIndex).moveTank(-1);
  }
  if(keyPressed && keyCode == DOWN && !this.isFiring){
    this.tanks.get(tankIndex).rotateTurret(true);
  }
  if(keyPressed && keyCode == UP && !this.isFiring){
    this.tanks.get(tankIndex).rotateTurret(false);
  }
  if(keyPressed && key == ' ' && !this.isFiring){
    this.tanks.get(tankIndex).fireWeapon();
    this.isFiring = true;
    this.currentWeapon = this.tanks.get(tankIndex).getCurrentWeapon();
    switchPlayer();
  }
  if(this.shotBar.getTime() < 1){
    switchPlayer();
    this.shotBar.resetTime();
  }
  
  if(keyPressed && key == '=' && !this.isFiring){
    this.tanks.get(tankIndex).increasePower();
  }
  if(keyPressed && key == '-' && !this.isFiring){
    this.tanks.get(tankIndex).decreasePower();
  }
  //map change
  if(mapBar.getTime() < 1 && !this.isFiring) {
    this.terrain.setTerrainShape(random(0, 5));
    this.mapBar.resetTime();
    this.tanks.get(0).shufflePosition();
    this.tanks.get(1).shufflePosition();
    this.tanks.get(0).removeAllCraters();
    this.tanks.get(1).removeAllCraters();
    this.shuffleDelay = millis() + 1000;
  }
}

public void mousePressed() {
    if (gameState == GameState.START_MENU) {
      gameStartScreen.mousePressed();
    } else if(gameState == GameState.GAME_OVER) {
      gameOverScreen.mousePressed();
    } else if(gameState == GameState.SHOP) {
      shop.mousePressed();
    }
}

public void setNRounds(int rounds){
 this.nRounds = rounds; 
}

public void startNextRound() {
    this.currentRound++;
    this.tanks.get(0).restoreHealth();
    this.tanks.get(1).restoreHealth();
    this.tanks.get(0).setDead(false);
    this.tanks.get(1).setDead(false);
    this.terrain.setTerrainShape(random(0, 5));
    this.mapBar.resetTime();
    this.shotBar.resetTime();
    this.tanks.get(0).shufflePosition();
    this.tanks.get(1).shufflePosition();
    this.tanks.get(0).removeAllCraters();
    this.tanks.get(1).removeAllCraters();
    this.currentWeapon = null;
    this.isFiring = false;
}
