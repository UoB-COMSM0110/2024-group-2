import java.util.LinkedHashMap;
import java.util.Map;

public class Shop {
  LinkedHashMap<String, Item> map;
  PImage sm, mm, lm, hk, bg, tc;
  Main p;

  int totalMoney = 300;
  int errorMessageDuration = 180;
  boolean showError = false;

  int textSize = 30;
  int buttonWidth = 300;
  int buttonHeight = 50;
  int buttonRadius = 10;
  color buttonColour = color(255);
  color hoverColour = color(255, 204, 0);
  
  public Shop(Main p) {
    this.p = p;
    this.map = new LinkedHashMap<String, Item>();
    this.bg = p.loadImage(".jpg");
    this.bg.resize(p.width, p.height);
    background(bg);
  
    this.sm = p.loadImage("small_missile.png");
    this.mm = p.loadImage("medium_missile.png");
    this.lm = p.loadImage("large_missile.png");
    this.hk = p.loadImage("health_kit.png");
    this.tc = loadImage("tank.png");
  
    this.sm.resize(60, 60);
    this.mm.resize(60, 60);
    this.lm.resize(60, 60);
    this.hk.resize(60, 60);
    this.tc.resize(25, 25);
  
  //shop = new Shop();
    this.itemList();
  }
  
  public void itemList() {
    this.map.put("Small missile: $25", new Item(this.sm, 25));
    this.map.put("Medium missile: $100", new Item(this.mm, 100));
    this.map.put("Large missile: $200", new Item(this.lm, 200));
    this.map.put("Health pack: $150", new Item(this.hk, 150));
    }
    
    int extractPrice(String item) {
      String[] parts = item.split(": ");
      String priceStr = parts[1].replaceAll("[^\\d]", "");
      return Integer.parseInt(priceStr);
    }
    
    
  void display() {
    p.background(this.bg);
    p.cursor(this.tc, this.tc.width/2, this.tc.height/2);
  
    p.fill(255);
    p.textSize(60);
    p.textAlign(CENTER);
    p.text("Item Shop", p.width/2, 100);
    p.fill(255);
    p.textSize(30);
    p.textAlign(CENTER);
    p.text("Select items you wish to purchase by hovering mouse above the name of the product and click left mouse button to buy the item. \n", 900, 750);
  
    drawButton("Return", p.width/2 - this.buttonWidth/2, p.height - 100, this.buttonWidth, this.buttonHeight);

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
      if(isMouseOverButton(x, y, textWidth(entry.getKey()), lineHeight)) {
        p.fill(hoverColour);
      } else {
        p.fill(buttonColour);
      }
      
      drawButton(entry.getKey(), x - buttonWidth/2, y - lineHeight/2, buttonWidth, buttonHeight);
      p.image(item.image, x + 300, y - lineHeight/2);
      p.fill(255);
      p.text("Amount: " + item.purchaseCount, x + 450, y + 0);
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
  
  void mousePressed() {
    int x = 800;
    int y = 250;
    int lineHeight = 60;
  
    for(Map.Entry<String, Item> entry : this.map.entrySet()){
      if(isMouseOverButton(x, y, textWidth(entry.getKey()), lineHeight)) {
        Item item = entry.getValue();
        int price = this.extractPrice(entry.getKey());
        if(price <= totalMoney) {  
          totalMoney -= price;
          item.purchaseCount++;
        }
        else {
          showError = true;
          errorMessageDuration = 180;
        }
        totalMoney = Math.max(totalMoney, 0);
      }
      y += lineHeight + entry.getValue().image.height + 10;
    }
    if(mouseX > width/2 - 50 && mouseX < width/2 + 50 && mouseY > height - 100 && mouseY < height - 50) {
      exit();
    }
  }

  boolean isMouseOverButton(float x, float y, float buttonWidth, float buttonHeight) {
    return mouseX >= x && mouseX <= x + buttonWidth && mouseY >= y - buttonHeight/2 && mouseY <= y + buttonHeight/2;
  }

  void drawButton(String label, float x, float y, float w, float h) {
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
      
  //item subclass
  class Item {
    PImage image;
    int price;
    int purchaseCount;
      
    Item(PImage image, int price) {
      this.image = image;
      this.price = price;
      this.purchaseCount = 0;
    }
  }  
}
