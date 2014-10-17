class DataPlot {
  float x, y;
  float w, h;

  float plotX1, plotY1;
  float plotX2, plotY2;  

  PFont copyFont; 
  PFont titleFont;

  String title;
  boolean titleEnable, headerLineEnable;  

  DataPlot(float x1, float y1, float w, float h) {
    this.x = x1;
    this.y = y1;
    this.w = w;
    this.h = h;

    titleFont = createFont("HoeflerText-Regular", 12);
    
    copyFont = createFont("HoeflerText-Regular", 14);
    textFont(copyFont);
    
    title = "";
    titleEnable = false;
    headerLineEnable = false;
  }

  void update() {
  }

  void display() {
    if (titleEnable) {
      drawTitle();
    }
    if (headerLineEnable) {
      drawHeaderLine();
    }
    
//    fill(0, 0, 70, 50);
//    noStroke();
//    rect(0, 0, w, h);    
  }

  void drawTitle() {
    
    fill(headerTitle);    
    textFont(titleFont);
    textAlign(LEFT, BOTTOM);    
    text(title, 0, 0); 
  }

  void drawHeaderLine() {
    strokeWeight(1);
    stroke(headerLine);
    strokeCap(SQUARE);     
    line(0, 0, w, 0 );
  }
}

