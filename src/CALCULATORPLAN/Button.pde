class Button {
  float x, y, w, h;
  color c1, c2;
  char val;
  boolean hover;

  // Constructor
  Button(float x, float y, float w, float h, char val) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    c1 = color(#B5EAD7); // Mint hover
    c2 = color(#FFDAC1); // Soft peach default
    this.val = val;
    hover = false;
  }

  // Member Methods
  void display() {
    stroke(255);
    strokeWeight(2);
    if (hover) {
      fill(c1);
    } else {
      fill(c2);
    }
    rect(x, y, w, h, 10); // Rounded corners
    
    fill(#555555);
    textSize(20);
    textAlign(CENTER, CENTER);
    text(val, x + w/2, y + h/2 - 2);
  }

  void mouseOver(float tempX, float tempY) {
    // Correct boundary check for top-left aligned rects
    if (tempX >= x && tempX <= x + w && tempY >= y && tempY <= y + h) {
      hover = true;
    } else {
      hover = false;
    }
  }
}
