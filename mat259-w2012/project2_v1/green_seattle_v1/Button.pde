class Button {
  float x, y, w, h;
  color currentbg, bg, bgh;
  boolean over = false;

  Button(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    bg = color(0, 0, 5, 7); // default background color
    bgh = color(0, 0, 10, 50); // hover color
  }

  void update(float mx, float my) {

    if (overItem(mx, my)) {
      currentbg = bgh;      
      over = true;
    } 
    else {
      currentbg = bg;      
      over = false;
    }
  }// end

  void display() {
    noStroke();    

    // background
    fill(currentbg);
    rectMode(CORNER);
    rect(x, y, w, h);
  }// end

  boolean overItem(float mx, float my) {
    if ((mx >= x) && (mx <= x+w) && (my >= y) && (my <= y+h)) {
      return true;
    } 
    else {
      return false;
    }
  }// end

  boolean isOver() {
    return over;
  }// end

  void setColor(color bgcolor) {
    bg = bgcolor;
  }// end

  void setHoverColor(color hoverColor) {
    bgh = hoverColor;
  }// end

  void setActive() {
    bg = color(0, 0, 70, 30); // active item
  }

  void setInactive() {
   bg = color(0, 0, 5, 7);
  }
}

