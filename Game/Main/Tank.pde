import java.util.LinkedHashMap;
import java.util.Map;

public class Tank{
  
  private PShape tankBody;
  private float tankX;
  private float tankY;
  private PShape tankTurret;
  private int turretAngle;
  private float turretAdjustX;
  private float turretAdjustY;
  private HealthBar health;
  private boolean dead;
  private PowerBar power;
  private boolean currentPlayer;
  private LinkedHashMap<String, Weapon> weapons;
  private String currentWeapon;
  private boolean isHumanControlled;
  private int money;
  private float roundsWon;
  
  public Tank(boolean currentPlayer, boolean isHuman, String colour){
    this.tankBody = loadShape("tankBody" + colour + ".svg");
    this.tankTurret = loadShape("tankTurret.svg");
    this.tankX = random(width - 50);
    this.turretAngle = 180;
    this.turretAdjustX = 30;
    this.turretAdjustY = 5;
    this.health = new HealthBar();
    this.dead = false;
    this.power = new PowerBar();
    this.currentPlayer = currentPlayer;
    this.weapons = new LinkedHashMap<>();
    this.weapons.put("Small missile", new Weapon("Small missile", 50));
    this.currentWeapon = "Small missile";
    this.isHumanControlled = isHuman;
    this.money = 0;
    this.roundsWon = 0;
    setTankY();
  }
  
  public void setTankY(){
    int index1 = int(this.tankX) + int(height - 1) * (int)width;
    int index2 = int(this.tankX) + 70 + int(height - 1) * (int)width;
    loadPixels();
    while(pixels[index1] != color(135, 206, 235) || pixels[index2] != color(135, 206, 235)){
      index1 -= width;
      index2 -= width;
    }
    if(pixels[index1] == color(135, 206, 235)){
      this.tankY = index1/width - 25;
    }else{
      this.tankY = index2/width - 25;
    }
  }
    
  
  public void renderTank(){
    if(this.dead){
      return;
    }
    this.setTankY();
    shape(this.tankTurret, this.tankX + this.turretAdjustX, this.tankY + this.turretAdjustY, 40, 10);
    shape(this.tankBody, this.tankX, this.tankY, 70, 40);
    this.health.update(this.tankX, this.tankY);
    this.health.display();
    if(this.currentPlayer){
      this.power.display();
    }
  }
  
  public void renderCraters() {
    for(Map.Entry<String, Weapon> w : this.weapons.entrySet()) {
      w.getValue().displayCraters();
    }
  }
  
  public void moveTank(float moveDist){
    
    float oldTankX = this.tankX;
    float oldTankY = this.tankY;
    
    if(moveDist > 0 && this.tankX < (width - 70)){
      this.tankX += moveDist;
      setTankY();
      
    }
    if(moveDist < 0 && this.tankX > 0){
      this.tankX += moveDist;
      setTankY();
    }
    float newTankY = this.tankY;
    //reset if up slope is too steep
    if((newTankY - oldTankY) < -2){
      this.tankX = oldTankX;
      this.tankY = oldTankY;
    }
    
  }
  public float getTankX(){
    return this.tankX;
  }
  public float getTankY(){
    return this.tankY;
  }
  public float getTurretX(){
    return this.tankX + this.turretAdjustX;
  }
  
  public float getTurretY(){
    return this.tankY + this.turretAdjustY;
  }
  public void rotateTurret(boolean clockwise){
    if(clockwise && this.turretAngle < 180){
      this.tankTurret.rotate(radians(1));
      this.turretAngle +=1;
      this.turretAdjustY -= 0.053;
      this.turretAdjustX -= 0.03;
    }
    if(!clockwise && this.turretAngle > 0){
      this.tankTurret.rotate(radians(-1));
      this.turretAngle -= 1;
      this.turretAdjustY += 0.053;
      this.turretAdjustX += 0.03;
    }
  }
  public int getTurretAngle(){
    return this.turretAngle;
  }
  public PShape getTankTurret(){
    return this.tankTurret;
  }
  public void decreaseHealth(int amount){
    this.health.decreaseHealth(amount);
    if(this.health.getValue() <= 0){
      this.dead = true;
    }
  }
  public boolean getDead(){
    return this.dead;
  }
  public void decreasePower() {
    this.power.decrease();
    float powerVal = this.power.getValue();
    this.weapons.get(this.currentWeapon).setISpeed(powerVal);
  }
    public void increasePower() {
    this.power.increase();
    float powerVal = this.power.getValue();
    this.weapons.get(this.currentWeapon).setISpeed(powerVal);
  }
  
  public void setCurrentPlayer(boolean value) {
    this.currentPlayer = value;
  }
  
  public void fireWeapon() {
    this.weapons.get(this.currentWeapon).setX(this.getTurretX() - cos(radians(this.getTurretAngle())) * 40);
    this.weapons.get(this.currentWeapon).setY(this.getTurretY()- sin(radians(this.getTurretAngle())) * 40);
    this.weapons.get(this.currentWeapon).setFire(true);
    this.weapons.get(this.currentWeapon).setTheta(this.getTurretAngle());
  }
  
  public Weapon getCurrentWeapon(){
    return this.weapons.get(this.currentWeapon);
  }
  
  public void shufflePosition() {
    this.tankX = random(0, width - 70);
    this.setTankY();
  }
  
  public void removeAllCraters(){
    for(Map.Entry<String, Weapon> w : this.weapons.entrySet()) {
      w.getValue().removeCraters();
    }
  }
  
  public boolean getIsHumanControlled(){
    return this.isHumanControlled;
  }
  
  public void setIsHumanControlled(boolean humanControlled) {
    this.isHumanControlled = humanControlled;
  }
  
  public void restoreHealth(){
    this.health.restore();
  }
  
  public void setDead(boolean dead){
    this.dead = dead;
  }
  
  public void successfulHit(){
    this.money += 25;
  }
  
  public void winRound() {
    this.money += 500;
    this.roundsWon++;
  }
  
  public void drawRound() {
    this.money += 250;
    this.roundsWon += 0.5;
  }
  
  public LinkedHashMap<String, Weapon> getWeapons() {
    return this.weapons;
  }
  
  public void buyWeapons(String type, int price) {
    if(!this.weapons.containsKey(type)) {
      this.weapons.put(type, new Weapon(type, 0));
    }
      this.weapons.get(type).buy();
      this.money -= price;
  }
  
  public int getMoney() {
    return this.money;
  }
}
