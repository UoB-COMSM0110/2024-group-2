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
boolean isHard = false;
PImage customCursor;
int nRounds;
int currentRound;
int endRound;
int shuffleDelay;
boolean miss = false;
float windSpeed = 0.2;
int changeWindCallCount = 0;

enum GameState {
  START_MENU,
  GAME_PLAY_1,
  GAME_PLAY_2,
  SHOP,
  GAME_OVER
}


GameState playingState;
GameState gameState = GameState.START_MENU;
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
 
 this.shop = new Shop(this, tanks);
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
    iSpeed = aiCalcISpeed2(-xDist - 20, yDist);
  } else {
    turretAdjust = this.tanks.get(tankIndex).getTurretAngle() - 45;
    iSpeed = aiCalcISpeed2(xDist - 20, yDist);
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

float aiCalcISpeed2(float absXDist, float yDist) {
  float iSpeed;
  
  iSpeed = sqrt((0.02 * pow(absXDist, 2) / pow(cos(radians(45)), 2)) * (1 / (absXDist * tan(radians(45)) - yDist)) * 0.5);
  
  // miss 50% of the time in easy mode
  if(!this.isHard && this.miss) {
    //change value of miss
    this.miss = !this.miss;
    return iSpeed * 2;
  }
  
  //change value of miss
  this.miss = !this.miss;
  
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
  this.displayMoney();
  this.displayWindFlag();
  
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
    int blastRadius = this.currentWeapon.getBlastRadius();
    int damage = this.currentWeapon.getDamage();
    if(abs(strikeX - this.tanks.get(0).getTankX() - 35) < blastRadius  && abs(strikeY - this.tanks.get(0).getTankY()) < blastRadius){
      this.tanks.get(0).decreaseHealth(damage);
      if(tankIndex == 0) {
        // + $25 for successful hit
        this.tanks.get(1).successfulHit();
      }
    }
    if(abs(strikeX - this.tanks.get(1).getTankX() - 35) < blastRadius && abs(strikeY - this.tanks.get(1).getTankY()) < blastRadius){
      this.tanks.get(1).decreaseHealth(damage);
      if(tankIndex == 1) {
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
    changeWind();
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
    changeWind();
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
    } else {
      this.tanks.get(tankIndex).getWDisplay().mousePressed();
    }
}

public void setNRounds(int rounds){
 this.nRounds = rounds; 
}

public void displayMoney() {
  String money = "$" + this.tanks.get(tankIndex).getMoney();
  if(tankIndex == 0) {
    fill(0,0,255);
  } else {
    fill(255,0,0);
  }
  textSize(40);
  text(money, 50, 50);
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

public void setHard(boolean isHard) {
  this.isHard = isHard;
}

void displayWindFlag() {
    stroke(0);
    fill(255, 0, 0);

    line(170, 20, 170, 70);

    if (windSpeed > 0) {
      triangle(170, 20, 170, 50, 130, 35);
    } 
    else {
      triangle(170, 20, 170, 50, 210, 35);
    }
}

public void changeWind() {
      changeWindCallCount++;  

      if (changeWindCallCount == 4) {
          windSpeed = -windSpeed;
          changeWindCallCount = 0;  
      }
  }
