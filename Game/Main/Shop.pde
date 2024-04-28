// class responsible for behaviour of the shop game state

import java.util.LinkedHashMap;
import java.util.Map;

public class Shop {
  LinkedHashMap<String, Item> map;
  PImage sm, mm, lm, bm, bg;
  Main p;

  int totalMoney;
  int errorMessageDuration = 180;
  boolean showError = false;

  int textSize = 30;
  int buttonWidth = 300;
  int buttonHeight = 50;
  int buttonRadius = 10;
  color buttonColour = color(255);
  color hoverColour = color(255, 204, 0);
  private int currentPlayer;
  
  private ArrayList<Tank> players;
  
  public Shop(Main p, ArrayList<Tank> tanks) {
    this.p = p;
    this.players = tanks;
    this.map = new LinkedHashMap<String, Item>();
    this.bg = p.loadImage("dark_display.jpg");
    this.bg.resize(p.width, p.height);
  
    this.sm = this.p.loadImage("small_missile.png");
    this.mm = this.p.loadImage("medium_missile.png");
    this.lm = this.p.loadImage("large_missile.png");
    this.bm = this.p.loadImage("ballistic_missile.png");
    
    this.sm.resize(60, 60);
    this.mm.resize(60, 60);
    this.lm.resize(60, 60);
    this.bm.resize(60, 60);
    this.currentPlayer = 0;
  
    this.itemList();
    this.updateItemAmount();
  }
  
  public void itemList() {
    this.map.put("Small missile", new Item(this.sm, 25));
    this.map.put("Medium missile", new Item(this.mm, 100));
    this.map.put("Large missile", new Item(this.lm, 200));
    this.map.put("Ballistic missile", new Item(this.bm, 750));
    }
    
  private void updateItemAmount() {
    for(Map.Entry<String, Weapon> w : this.players.get(currentPlayer).getWeapons().entrySet()) {
      int playerAmount = w.getValue().getCount();
      String weaponType = w.getKey();
      
      this.map.get(weaponType).updateAmount(playerAmount);
    }
  }
    
    
  public void display() {
    this.totalMoney = this.players.get(currentPlayer).getMoney();
    p.background(this.bg);
    this.updateItemAmount();
    p.fill(255);
    p.textSize(60);
    p.textAlign(CENTER);
    p.text("Item Shop", p.width/2, 100);
    p.fill(255);
    p.textSize(30);
    p.textAlign(CENTER);
    p.text("Select items you wish to purchase by hovering mouse above the name of the product and click left mouse button to buy the item. \n", 900, 750);
  
    drawButton("Next", p.width/2 - this.buttonWidth/2, p.height - 100, this.buttonWidth, this.buttonHeight);

    String money = "Money: $" + totalMoney;
    p.fill(255);
    p.text(money, p.width - textWidth(money) - 20, 80);
  
    int x = 800;
    int y = 250;
    int lineHeight = 60;
    float maxTextWidth = 0;
    for(Map.Entry<String, Item> entry : this.map.entrySet()){
      Item item = entry.getValue();
      float currentTextWidth = textWidth(entry.getKey());
      if(currentTextWidth > maxTextWidth){
        maxTextWidth = currentTextWidth;
      }
      
      drawButton(entry.getKey() + ": $" + entry.getValue().getPrice(), x - buttonWidth/2, y - lineHeight/2, buttonWidth, buttonHeight);
      p.image(item.image, x + 300, y - lineHeight/2);
      p.fill(255);
      p.text("Current amount: " + item.amount, x + 500, y + 0);
      y += lineHeight + item.image.height + 10;
      
      if(showError && errorMessageDuration > 0) {
        fill(255, 0, 0);
        textSize(30);
        textAlign(CENTER, BOTTOM);
        text("You don't have enough money for this item.", width/2, height - 20);
        errorMessageDuration--;
      }
    }
  }
  
  public void mousePressed() {
    int x = 800;
    int y = 250;
    int lineHeight = 60;
  
    for(Map.Entry<String, Item> entry : this.map.entrySet()){
      if(isMouseOverButton(x - buttonWidth/2, y - lineHeight/2, buttonWidth, buttonHeight)) {
        Item item = entry.getValue();
        String type = entry.getKey();
        int price = item.getPrice();
        if(price <= totalMoney) {  
          item.amount++;
          this.players.get(currentPlayer).buyWeapons(type, price);
        }
        else {
          showError = true;
          errorMessageDuration = 180;
        }
      }
      y += lineHeight + entry.getValue().image.height + 10;
    }
    if(isMouseOverButton(this.p.width/2 - this.buttonWidth/2, this.p.height - 100, this.buttonWidth, this.buttonHeight)) {
      if(this.p.playingState == GameState.GAME_PLAY_1 || this.currentPlayer == 1) {
        if(this.p.playingState == GameState.GAME_PLAY_1){
          this.aiPurchase();
        }
        gameState = this.p.playingState;
        resetModeDefaults();
        this.p.endRound = millis() + 1000;
      } else {
        this.currentPlayer = 1;
        this.resetItemAmounts();
        this.updateItemAmount();
      }
    }
  }

  private boolean isMouseOverButton(float x, float y, float buttonWidth, float buttonHeight) {
    return mouseX >= x && mouseX <= x + buttonWidth && mouseY >= y - buttonHeight/2 && mouseY <= y + buttonHeight/2;
  }
  
  // in single player mode the cpu controlled tank will iteratively buy the most expensive weapon it can
  private void aiPurchase() {
    int budget = this.players.get(1).getMoney();
    
    while(budget >= 25) {
      if(budget >= 200){
        this.players.get(1).buyWeapons("Large missile", 200);
        budget -= 200;
      } else if (budget >= 100) {
        this.players.get(1).buyWeapons("Medium missile", 100);
        budget -= 100;
      } else if (budget >= 25) {
        this.players.get(1).buyWeapons("Small missile", 25);
        budget -= 25;
      }
    }
  }

  private void drawButton(String label, float x, float y, float w, float h) {
    this.p.rectMode(CORNER);
    this.p.strokeWeight(2);
    this.p.stroke(200);
    if(isMouseOverButton(x, y, w, h)){
      this.p.fill(hoverColour);
    } else {
      this.p.fill(buttonColour);
    }
    this.p.rect(x, y, w, h, buttonRadius);
  
    this.p.fill(0);
    this.p.textSize(textSize);
    this.p.textAlign(CENTER, CENTER);
    this.p.text(label, x + w/2, y + h/2);
  }
  
  // to ensure display of game play is not affected after returning from the shop
  private void resetModeDefaults() {
    this.p.rectMode(PApplet.CORNER);
    this.p.textAlign(PApplet.LEFT, PApplet.BASELINE);
    this.p.strokeWeight(1);
    this.p.noStroke();
  }
  
  private void resetItemAmounts() {
    for(Map.Entry<String, Item> entry : this.map.entrySet()){
      entry.getValue().updateAmount(0);
    }
  }
      
  //item subclass
  public class Item {
    PImage image;
    int price;
    int amount;
      
    public Item(PImage image, int price) {
      this.image = image;
      this.price = price;
      this.amount = 0;
    }
    
    public void updateAmount(int playerAmount) {
      this.amount = playerAmount;
    }
    
    public int getPrice() {
      return this.price;
    }
  }  
}
