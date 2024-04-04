import processing.core.PApplet;
import processing.core.PFont;
import processing.core.PImage;
import javax.swing.JOptionPane;

public class GameOver {
    int buttonWidth = 200;
    int buttonHeight = 60;
    PFont buttonFont;
    PFont titleFont;
    Main p;
    PImage backgroundImage;
    int baseY = 0;
    String winner;
    
    public GameOver(Main p) {
        this.p = p;
        this.baseY = p.height / 2 - 150;
        
        buttonFont = p.createFont("Arial", 28);
        titleFont = p.createFont("Arial Bold", 88);
        
        this.backgroundImage = p.loadImage("backgroundImage.jpg"); 
        this.backgroundImage.resize(p.width, p.height);
    }
    
    private void drawButton(String label, int yOffset, boolean active) {
        int buttonX = p.width / 2;
        int buttonY = this.baseY + yOffset;
        int highlightColor = p.color(255, 255, 255, 100); 
        int shadowColor = p.color(50, 50, 50, 50); 
        
        p.noStroke();
        
        p.fill(shadowColor);
        p.rect(buttonX, buttonY + 5, buttonWidth, buttonHeight, 20);
        
        p.fill(active ? 200 : 150); 
        p.rectMode(PApplet.CENTER);
        p.rect(buttonX, buttonY, buttonWidth, buttonHeight, 20);
        
        p.fill(highlightColor);
        p.rect(buttonX, buttonY - 2, buttonWidth, buttonHeight - 10, 20);
        
        p.textFont(buttonFont);
        p.fill(0);
        p.textSize(28);
        p.textAlign(PApplet.CENTER, PApplet.CENTER);
        p.text(label, buttonX, buttonY);
    }

    public void drawTitle(){
      p.textFont(titleFont);
      p.fill(0);
      p.textSize(88);
      p.textAlign(PApplet.CENTER, PApplet.CENTER);
      p.text("Game Over: " + winner + " tank wins!", p.width / 2, 400);
    }
    
    public void display() {
      p.background(backgroundImage);
      drawTitle();
      drawButton("Play Again", 210, true);
      drawButton("Exit", 290, true);
    }

    public void mousePressed() {
      int mouseX = p.mouseX;
      int mouseY = p.mouseY;
      
      // Play Again
      if (overRect(p.width / 2 - buttonWidth / 2, baseY + 210, buttonWidth, buttonHeight, mouseX, mouseY)) {
        resetModeDefaults();
        gameState = GameState.START_MENU;
        p.setup();
      } 
      // Exit
      else if (overRect(p.width / 2 - buttonWidth / 2, baseY + 290, buttonWidth, buttonHeight, mouseX, mouseY)) {
        System.exit(0);
      }
    }
    
    private boolean overRect(int centerX, int centerY, int width, int height, int mouseX, int mouseY) {
        int x = centerX - width / 2;
        int y = centerY - height / 2;
        return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
    } 
    
  private void resetModeDefaults() {
    p.rectMode(PApplet.CORNER);
    p.textAlign(PApplet.LEFT, PApplet.BASELINE);
  }
  
  public void setWinner(String winner) {
    this.winner = winner;
  }
 }
