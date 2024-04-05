import java.util.LinkedHashMap;
import java.util.Map;

public class WeaponDisplay {
  
  private Tank currentPlayer;
  private LinkedHashMap<String, Weapon> weapons;
  private String currentWeapon;
  private int buttonWidth = 300;
  private int buttonHeight = 40;
  private int buttonX = 1200;
  private int buttonY = 900;
  
  public WeaponDisplay(Tank tank) {
    this.currentPlayer = tank;
    this.weapons = this.currentPlayer.getWeapons();
    this.currentWeapon = this.currentPlayer.getCurrentWeapon().getType();
  }
  
  public void display() {
    int currentWeaponAmount = this.weapons.get(currentWeapon).getCount();
    String label = currentWeapon + ": " + currentWeaponAmount;
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
      if(this.currentWeapon.equals("Small missile")) {
        if(this.weapons.containsKey("Medium missile") ){
          this.currentWeapon = "Medium missile";
          this.currentPlayer.setCurrentWeapon("Medium missile");
        } else if(this.weapons.containsKey("Large missile")) {
          this.currentWeapon = "Large missile";
          this.currentPlayer.setCurrentWeapon("Large missile");
        } else if(this.weapons.containsKey("Ballistic missile")) {
          this.currentWeapon = "Ballistic missile";
          this.currentPlayer.setCurrentWeapon("Ballistic missile");
        }
      } else if(this.currentWeapon.equals("Medium missile")) {
        if(this.weapons.containsKey("Large missile") ){
          this.currentWeapon = "Large missile";
          this.currentPlayer.setCurrentWeapon("Large missile");
        } else if(this.weapons.containsKey("Ballistic missile")) {
          this.currentWeapon = "Ballistic missile";
          this.currentPlayer.setCurrentWeapon("Ballistic missile");
        } else if(this.weapons.containsKey("Small missile")) {
          this.currentWeapon = "Small missile";
          this.currentPlayer.setCurrentWeapon("Small missile");
        }
    } else if(this.currentWeapon.equals("Large missile")) {
        if(this.weapons.containsKey("Ballistic missile") ){
          this.currentWeapon = "Ballistic missile";
          this.currentPlayer.setCurrentWeapon("Ballistic missile");
        } else if(this.weapons.containsKey("Small missile")) {
          this.currentWeapon = "Small missile";
          this.currentPlayer.setCurrentWeapon("Small missile");
        } else if(this.weapons.containsKey("Medium missile")) {
          this.currentWeapon = "Medium missile";
          this.currentPlayer.setCurrentWeapon("Medium missile");
        }
    } else if(this.currentWeapon.equals("Ballistic missile")) {
        if(this.weapons.containsKey("Small missile") ){
          this.currentWeapon = "Small missile";
          this.currentPlayer.setCurrentWeapon("Small missile");
        } else if(this.weapons.containsKey("Medium missile")) {
          this.currentWeapon = "Medium missile";
          this.currentPlayer.setCurrentWeapon("Medium missile");
        } else if(this.weapons.containsKey("Large missile")) {
          this.currentWeapon = "Large missile";
          this.currentPlayer.setCurrentWeapon("Large missile");
        }
    }
  }
  }
}
