import java.util.LinkedHashMap;
import java.util.Map;

public class WeaponDisplay {
  
  private Tank currentPlayer;
  private LinkedHashMap<String, Weapon> weapons;
  private int buttonWidth = 300;
  private int buttonHeight = 40;
  private int buttonX = 1200;
  private int buttonY = 900;
  
  public WeaponDisplay(Tank tank) {
    this.currentPlayer = tank;
    this.weapons = this.currentPlayer.getWeapons();
  }
  
  public void display() {
    int currentWeaponAmount = this.currentPlayer.getCurrentWeapon().getCount();
    if(currentWeaponAmount == 0 && !this.currentPlayer.getCurrentWeapon().getFire()) {
      this.changeWeapon();
    }
    //ai tank should use most powerful weapon by default
    if(!this.currentPlayer.getIsHumanControlled() && !this.currentPlayer.getCurrentWeapon().getFire()) {
      this.selectMostPowerfulWeapon();
    }
    String label =  this.currentPlayer.getCurrentWeaponType() + ": " + currentWeaponAmount;
    drawButton(label, buttonX, buttonY, buttonWidth, buttonHeight);
  }
  
  private void drawButton(String label, float x, float y, float w, float h) {
    rectMode(CORNER);
    strokeWeight(2);
    stroke(200);
    fill(211, 211, 211);
    rect(x, y, w, h, 10);
    fill(0);
    textSize(25);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }
  
  private boolean isMouseOverButton() {
    return mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY - buttonHeight/2 && mouseY <= buttonY + buttonHeight/2;
  }
  
  public void mousePressed() {
      if(isMouseOverButton()) {
        this.changeWeapon();
      }
  }
  
  private void changeWeapon() {
    int medCount, largeCount, balCount;
    medCount = this.weapons.get("Medium missile").getCount();
    largeCount = this.weapons.get("Large missile").getCount();
    balCount = this.weapons.get("Ballistic missile").getCount();
    
      if(this.currentPlayer.getCurrentWeaponType().equals("Small missile")) {
        if(medCount > 0 ){
          this.currentPlayer.setCurrentWeapon("Medium missile");
        } else if(largeCount > 0) {
          this.currentPlayer.setCurrentWeapon("Large missile");
        } else if(balCount > 0) {
          this.currentPlayer.setCurrentWeapon("Ballistic missile");
        }
      } else if(this.currentPlayer.getCurrentWeaponType().equals("Medium missile")) {
        if(largeCount > 0){
          this.currentPlayer.setCurrentWeapon("Large missile");
        } else if(balCount > 0) {
          this.currentPlayer.setCurrentWeapon("Ballistic missile");
        } else {
          this.currentPlayer.setCurrentWeapon("Small missile");
        }
    } else if(this.currentPlayer.getCurrentWeaponType().equals("Large missile")) {
        if(balCount > 0){
          this.currentPlayer.setCurrentWeapon("Ballistic missile");
        } else if(this.weapons.containsKey("Small missile")) {
          this.currentPlayer.setCurrentWeapon("Small missile");
        } else if(medCount > 0 ) {
          this.currentPlayer.setCurrentWeapon("Medium missile");
        }
    } else if(this.currentPlayer.getCurrentWeaponType().equals("Ballistic missile")) {
        if(this.weapons.containsKey("Small missile")){
          this.currentPlayer.setCurrentWeapon("Small missile");
        } else if(medCount > 0 ) {
          this.currentPlayer.setCurrentWeapon("Medium missile");
        } else if(largeCount > 0) {
          this.currentPlayer.setCurrentWeapon("Large missile");
        }
      }
  }
  
  private void selectMostPowerfulWeapon() {
    int medCount, largeCount, balCount;
    medCount = this.weapons.get("Medium missile").getCount();
    largeCount = this.weapons.get("Large missile").getCount();
    balCount = this.weapons.get("Ballistic missile").getCount();
    
      if(this.currentPlayer.getCurrentWeaponType().equals("Small missile")) {
        if(balCount > 0 ){
          this.currentPlayer.setCurrentWeapon("Ballistic missile");
        } else if(largeCount > 0) {
          this.currentPlayer.setCurrentWeapon("Large missile");
        } else if(medCount > 0) {
          this.currentPlayer.setCurrentWeapon("Medium missile");
        }
      } else if(this.currentPlayer.getCurrentWeaponType().equals("Medium missile")) {
        if(balCount > 0){
          this.currentPlayer.setCurrentWeapon("Ballistic missile");
        } else if(largeCount > 0) {
          this.currentPlayer.setCurrentWeapon("Large missile");
        }
    } else if(this.currentPlayer.getCurrentWeaponType().equals("Large missile")) {
        if(balCount > 0){
          this.currentPlayer.setCurrentWeapon("Ballistic missile");
        } 
    }
  }
}
