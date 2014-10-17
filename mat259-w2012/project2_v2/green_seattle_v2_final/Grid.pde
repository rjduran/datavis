class Grid {

  PFont font1 = createFont("SansSerif", 15); 

  int gridWidth;
  int gridHeight;

  boolean showGrid = false;
  boolean showMousePosition = false;

  int padding;
  float hDiv;
  float vDiv;
  float hSquareSize;
  float vSquareSize;  

  // sketch width, sketch height, horizontal divisions, vertical divisions, padding
  Grid(int w, int h, float hdiv, float vdiv, int p) {
    gridWidth = w;
    gridHeight = h;
    hDiv = hdiv;
    vDiv = vdiv;
    padding = p;

    hSquareSize = gridWidth/hDiv;
    vSquareSize = gridHeight/vDiv;
  }

  void displayGrid() {
    strokeWeight(1.0);

    //draw horizontal grid
    for (int i = 0;i<=hDiv;i++) {
      stroke(0, 0, 85);
      line(i*hSquareSize-padding, 0, i*hSquareSize-padding, height);
      line(i*hSquareSize+padding, 0, i*hSquareSize+padding, height);
      //dottedLine(i*hSquareSize, 0, i*hSquareSize, height, gridWidth/10);
    }

    //draw vertical grid
    for (int i = 0;i<=vDiv;i++) {
      stroke(0, 0, 85);
      line(0, i*vSquareSize-padding, width, i*vSquareSize-padding);
      line(0, i*vSquareSize+padding, width, i*vSquareSize+padding);
      //dottedLine(0, i*vSquareSize, width, i*vSquareSize, gridWidth/10);
    }
  }

  void displayMousePosition() {
    stroke(0, 0, 70);
    strokeWeight(1.0);

    // vertical line
    line(mouseX, height, mouseX, 0);
    fill(0, 0, 60);
    textFont(font1);

    if (mouseX > width - 5*padding) {
      textAlign(RIGHT, TOP);    
      text("x: " + mouseX, mouseX-padding, padding);
    } 
    else {
      textAlign(LEFT, TOP);
      text("x: " + mouseX, mouseX+padding, padding);
    }

    // horizontal line
    line(width, mouseY, 0, mouseY);
    fill(0, 0, 60);  
    textFont(font1);

    if (mouseY < 3*padding) {
      textAlign(LEFT, TOP);
      text("y: " + mouseY, padding, mouseY+padding/2);
    } 
    else {
      textAlign(LEFT, BOTTOM);
      text("y: " + mouseY, padding, mouseY);
    }
  }

  float getHSize() {
    return hSquareSize;
  }
  
  float getVSize() {
    return vSquareSize;
  }

  int getPadding() {
    return padding;
  }

  void dottedLine(float x1, float y1, float x2, float y2, float steps) {
    for (int i=0; i<=steps; i++) {
      float x = lerp(x1, x2, i/steps);
      float y = lerp(y1, y2, i/steps);
      fill(0, 0, 80);
      noStroke();
      ellipse(x, y, 1, 1);
    }
  }
}

