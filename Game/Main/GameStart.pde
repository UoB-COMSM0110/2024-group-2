import processing.core.PApplet;
import processing.core.PFont;
import processing.core.PImage;
import javax.swing.JOptionPane;// 导入JOptionPane类

public class GameStart {
    int buttonWidth = 200;
    int buttonHeight = 60;
    PFont buttonFont;
    PFont titleFont;
    boolean isPlayerNameEntered = false;
    boolean startGameRequested = false; // 用于跟踪是否请求开始游戏
    private String playerName = "";
    private String player1Name = "";
    private String player2Name = "";
    PApplet p; // 保持对PApplet实例的引用
    PImage backgroundImage; // 背景图片
    int baseY = 0; // 基础Y坐标，用于计算按钮的位置
    
    // 构造函数中接收PApplet实例并计算基础Y坐标
    public GameStart(PApplet p) {
        this.p = p;
        this.baseY = p.height / 2 - 150;
        
        // 加载或创建字体
        buttonFont = p.createFont("Arial", 28);
        titleFont = p.createFont("Arial Bold", 88);
        
        this.backgroundImage = p.loadImage("backgroundImage.jpg"); // 加载背景图片
        this.backgroundImage.resize(p.width, p.height);
    }
    
    // 绘制按钮，包括游戏的开始按钮
    private void drawButton(String label, int yOffset, boolean active) {
        int buttonX = p.width / 2;
        int buttonY = this.baseY + yOffset;
        int highlightColor = p.color(255, 255, 255, 100); // 高光颜色
        int shadowColor = p.color(50, 50, 50, 50); // 阴影颜色
        
        // 禁用绘制矩形边框
        p.noStroke();
        
        // 绘制按钮阴影
        p.fill(shadowColor);
        p.rect(buttonX, buttonY + 5, buttonWidth, buttonHeight, 20);// 阴影位置和大小并添加圆角
        
        // 绘制按钮主体
        p.fill(active ? 200 : 150); // 如果按钮活跃，使用较亮的颜色
        p.rectMode(PApplet.CENTER);
        p.rect(buttonX, buttonY, buttonWidth, buttonHeight, 20);// 按钮位置和大小并添加圆角
        
        // 在按钮顶部添加高光
        p.fill(highlightColor);
        p.rect(buttonX, buttonY - 2, buttonWidth, buttonHeight - 10, 20);
        
        // 绘制按钮文本
        p.textFont(buttonFont);
        p.fill(0); // 文本颜色设置为黑色
        p.textSize(28); // 文本大小
        p.textAlign(PApplet.CENTER, PApplet.CENTER); // 文本对齐方式设置为居中
        p.text(label, buttonX, buttonY); // 绘制文本
    }

    public void drawTitle(){
      // 绘制标题
      p.textFont(titleFont);
      p.fill(0);// 文字颜色设置为黑色
      p.textSize(88);//文字大小
      p.textAlign(PApplet.CENTER, PApplet.TOP);//设置文字对其方式
      p.text("Tank Battle", p.width / 2, 50);// 绘制标题文本
    }
    
    public void drawSmallTitle(){
      p.textFont(titleFont);
      p.fill(0);
      p.textSize(52);
      p.text("Setting", p.width / 2, baseY - 80);
    }
    
    public void display() {
      //p.background(0, 0, 100); // 暗蓝色背景
      p.background(backgroundImage); // 使用背景图片
      drawTitle();
      drawSmallTitle();
      drawButton("1 Player", 50, true); // yOffset为0，表示在基础位置
      drawButton("2 Players", 130, true); // yOffset为70，表示向下偏移60像素
      drawButton("Instructions", 210, true); // yOffset为140
      drawButton("Start Game", 290, isPlayerNameEntered); // 根据玩家是否输入名字来激活按钮
      drawButton("Exit", 370, true);
    }
    
    // 处理鼠标点击事件
    public void mousePressed() {
      // 通过按钮的y坐标确定按钮的中心位置
      //int onePlayerButtonY = this.baseY;
      //int twoPlayerButtonY = this.baseY + 60;
      //int instructionButtonY = this.baseY + 120;
      //int startGameButtonY = this.baseY + 180;
      //int exitButtonY = this.baseY + 240;
      // 获取鼠标点击的位置
      int mouseX = p.mouseX;
      int mouseY = p.mouseY;
      
      // 检查1 Player按钮是否被点击
      if (overRect(p.width / 2 - buttonWidth / 2, baseY + 50, buttonWidth, buttonHeight, mouseX, mouseY)) {
        String inputName = JOptionPane.showInputDialog("Enter your name:");
        if (inputName != null && !inputName.trim().isEmpty()) {
          playerName = inputName;
          //player1Name = ""; // 清除之前可能输入的玩家1名称
          //player2Name = ""; // 清除之前可能输入的玩家2名称
          isPlayerNameEntered = true;// 确保已输入玩家名称
          //startGameRequested = false; // 重置开始游戏请求
        }
      } 
      // 检查2 Players按钮是否被点击
      else if (overRect(p.width / 2 - buttonWidth / 2, baseY + 130, buttonWidth, buttonHeight, mouseX, mouseY)) {
        String inputPlayer1Name = JOptionPane.showInputDialog("Enter player 1 name:");
        if (inputPlayer1Name != null && !inputPlayer1Name.trim().isEmpty()) {
          player1Name = inputPlayer1Name;// 存储玩家1的名字
          String inputPlayer2Name = JOptionPane.showInputDialog("Enter player 2 name:");
          if (inputPlayer2Name != null && !inputPlayer2Name.trim().isEmpty()) {
            player2Name = inputPlayer2Name;// 存储玩家2的名字
            //playerName = ""; // 清除之前可能输入的单玩家名称
            isPlayerNameEntered = true;// 确保两个玩家名称都已输入
            //startGameRequested = false; // 重置开始游戏请求
          }
        }
      } 
      // 检查Instructions按钮是否被点击
      else if (overRect(p.width / 2 - buttonWidth / 2, baseY + 210, buttonWidth, buttonHeight, mouseX, mouseY)) {
        String gameInstructions = "Welcome to Tank Battle!\n\n" +
                              "Gameplay:\n" +
                              "- Use the left and right keys to move your tank.\n" +
                              "- Press space to shoot.\n\n" +
                              "First to score three hits wins the match!\n\n" +
                              "Good luck, and may the best tank win!";
        JOptionPane.showMessageDialog(null, gameInstructions, "Game Instructions", JOptionPane.INFORMATION_MESSAGE);
      } 
      // 检查Exit按钮是否被点击
      else if (overRect(p.width / 2 - buttonWidth / 2, baseY + 370, buttonWidth, buttonHeight, mouseX, mouseY)) {
        System.exit(0); // 退出程序
      }
      // 检查Start Game按钮是否被点击，并且玩家名字已输入
      if (isPlayerNameEntered && overRect(p.width / 2 - buttonWidth / 2, baseY + 290, buttonWidth, buttonHeight, p.mouseX, p.mouseY)) {
        startGameRequested = true; // 此标志需要在主类中检查以改变游戏状态
        gameState = GameState.GAME_PLAY; // 立即更新游戏状态
      } 
    }
  
    public boolean isStartGameRequested() {
      return startGameRequested;
  }
  
      // 检查鼠标是否在矩形区域内的辅助方法
    private boolean overRect(int centerX, int centerY, int width, int height, int mouseX, int mouseY) {
        int x = centerX - width / 2;
        int y = centerY - height / 2;
        return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
    }
    
    
     // 获取玩家名称的方法，可以用于在游戏开始时获取玩家信息
    public String getPlayerName() {
        return playerName;
    }
    
    public String getPlayer1Name() {
        return player1Name;
    }
    
    public String getPlayer2Name() {
        return player2Name;
    }
    
  
 }
