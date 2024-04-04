import java.util.LinkedHashMap;
import java.util.Map;

PImage sm, mm, lm, hk, bg, tc;

Shop shop;
int totalMoney = 300;
int errorMessageDuration = 180;
boolean showError = false;

int textSize = 30;
int buttonWidth = 300;
int buttonHeight = 50;
int buttonRadius = 10;
color buttonColour = color(255);
color hoverColour = color(255, 204, 0);

void setup() {
  size(1800, 960);
  bg = loadImage("dark_display.jpg");
  bg.resize(1800, 960);
  background(bg);
  
  sm = loadImage("small_missile.png");
  mm = loadImage("medium_missile.png");
  lm = loadImage("large_missile.png");
  hk = loadImage("health_kit.png");
  tc = loadImage("tank.png");
  
  sm.resize(60, 60);
  mm.resize(60, 60);
  lm.resize(60, 60);
  hk.resize(60, 60);
  tc.resize(25, 25);
  
  shop = new Shop();
}

void draw() {
  background(bg);
  cursor(tc, tc.width/2, tc.height/2);
  
  fill(255);
  textSize(60);
  textAlign(CENTER);
  text("Item Shop", width/2, 100);
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("Select items you wish to purchase by hovering mouse above the name of the product and click left mouse button to buy the item. \n", 900, 750);
  
  drawButton("Return", width/2 - buttonWidth/2, height - 100, buttonWidth, buttonHeight);

  String money = "Money: $" + totalMoney;
  fill(255);
  text(money, width - textWidth(money) - 20, 80);
  
  int x = 800;
  int y = 250;
  int lineHeight = 60;
  float maxTextWidth = 0;
  if(shop != null && shop.map != null) {
    for(Map.Entry<String, Item> entry : shop.map.entrySet()){
      Item item = entry.getValue();
      float currentTextWidth = textWidth(entry.getKey());
      if(currentTextWidth > maxTextWidth){
        maxTextWidth = currentTextWidth;
      }
      if(isMouseOverButton(x, y, textWidth(entry.getKey()), lineHeight)) {
        fill(hoverColour);
      } else {
        fill(buttonColour);
      }
      
      drawButton(entry.getKey(), x - buttonWidth/2, y - lineHeight/2, buttonWidth, buttonHeight);
      image(item.image, x + 300, y - lineHeight/2);
      fill(255);
      text("Amount: " + item.purchaseCount, x + 450, y + 0);
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
}

void mousePressed() {
  int x = 800;
  int y = 250;
  int lineHeight = 60;
  
  if(shop != null && shop.map != null) {
    for(Map.Entry<String, Item> entry : shop.map.entrySet()){
      if(isMouseOverButton(x, y, textWidth(entry.getKey()), lineHeight)) {
        Item item = entry.getValue();
        int price = shop.extractPrice(entry.getKey());
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
  }
  if(mouseX > width/2 - 50 && mouseX < width/2 + 50 && mouseY > height - 100 && mouseY < height - 50) {
    exit();
  }
}

boolean isMouseOverButton(float x, float y, float buttonWidth, float buttonHeight) {
  return mouseX >= x && mouseX <= x + buttonWidth && mouseY >= y - buttonHeight/2 && mouseY <= y + buttonHeight/2;
}

void drawButton(String label, float x, float y, float w, float h) {
  rectMode(CORNER);
  strokeWeight(2);
  stroke(200);
  if(isMouseOverButton(x, y, w, h)){
    fill(hoverColour);
  } else {
    fill(buttonColour);
  }
  rect(x, y, w, h, buttonRadius);
  
  fill(0);
  textSize(textSize);
  textAlign(CENTER, CENTER);
  text(label, x + w/2, y + h/2);
}

class Shop {
  LinkedHashMap<String, Item> map;
  
  Shop() {
    map = new LinkedHashMap<String, Item>();
    itemList();
  }
  
    public void itemList() {
      map.put("Small missile: $25", new Item(sm, 25));
      map.put("Medium missile: $100", new Item(mm, 100));
      map.put("Large missile: $200", new Item(lm, 200));
      map.put("Health pack: $150", new Item(hk, 150));
    }
    
    int extractPrice(String item) {
      String[] parts = item.split(": ");
      String priceStr = parts[1].replaceAll("[^\\d]", "");
      return Integer.parseInt(priceStr);
    }
}
    
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
