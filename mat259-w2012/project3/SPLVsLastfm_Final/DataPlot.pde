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

    titleFont = createFont("Helvetica", 12);

    copyFont = createFont("Helvetica", 14);
    textFont(copyFont);

    title = "";
    titleEnable = false;
    headerLineEnable = false;
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
//    rect(x, y, w, h);
  }

  void drawTitle() {

    fill(0);    
    textFont(titleFont);
    textAlign(LEFT, BOTTOM);    
    text(title, 0, 0);
  }

  void drawHeaderLine() {
    strokeWeight(1);
    stroke(0);
    strokeCap(SQUARE);     
    line(0, 0, w, 0 );
  }
}

