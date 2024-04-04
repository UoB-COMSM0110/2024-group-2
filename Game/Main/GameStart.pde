import processing.core.PApplet;
import processing.core.PFont;
import processing.core.PImage;
import javax.swing.JOptionPane;

public class GameStart {
    int buttonWidth = 200;
    int buttonHeight = 60;
    PFont buttonFont;
    PFont titleFont;
    PApplet p;
    PImage backgroundImage;
    int baseY = 0;
    
    public GameStart(PApplet p) {
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
      p.textAlign(PApplet.CENTER, PApplet.TOP);
      p.text("Tank Battle", p.width / 2, 50);
    }
    
    public void display() {
      p.background(backgroundImage);
      drawTitle();
      drawButton("1 Player", 50, true); 
      drawButton("2 Players", 130, true);
      drawButton("Instructions", 210, true);
      drawButton("Exit", 290, true);
    }

    public void mousePressed() {
      int mouseX = p.mouseX;
      int mouseY = p.mouseY;
      
      // 检查1 Player按钮是否被点击
      if (overRect(p.width / 2 - buttonWidth / 2, baseY + 50, buttonWidth, buttonHeight, mouseX, mouseY)) {
        resetModeDefaults();
        gameState = GameState.GAME_PLAY_1;
      } 
      // 检查2 Players按钮是否被点击
      else if (overRect(p.width / 2 - buttonWidth / 2, baseY + 130, buttonWidth, buttonHeight, mouseX, mouseY)) {
        resetModeDefaults();
        gameState = GameState.GAME_PLAY_2;
      } 
      // 检查Instructions按钮是否被点击
      else if (overRect(p.width / 2 - buttonWidth / 2, baseY + 210, buttonWidth, buttonHeight, mouseX, mouseY)) {
        String gameInstructions = "Welcome to Tank Battle!\n\n" +
                              "Gameplay:\n" +
                              "- Use the left and right keys to move your tank.\n" +
                              " - Use '=' to increase shot power and '-' to decrease shot power.\n" +
                              "- Press space to shoot.\n\n" +
                              "First to score three hits wins the match!\n\n" +
                              "Good luck, and may the best tank win!";
        JOptionPane.showMessageDialog(null, gameInstructions, "Game Instructions", JOptionPane.INFORMATION_MESSAGE);
      } 
      // 检查Exit按钮是否被点击
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
  
 }
