class Legend extends DataPlot {

  int nCategories;  
  String[] categories;
  color[] colors;

  PFont titleFont;
  PFont copyFont;

  int currentCategory;

  Legend(float x1, float y1, float w, float h, String[] cat) {
    super(x1, y1, w, h);

    categories = cat;    
    nCategories = categories.length;

    colors = new color[nCategories];

    // asign a color to each category
    for (int i = 0; i < nCategories; i++) {
      colors[i] = color(0, 0, i*15);
    }    

    plotX1 = 10; // left side
    plotX2 = w - plotX1; // right side    
    plotY1 = 10;  // top
    plotY2 = h - plotY1; // bottom
    int space = 5;

    // setup font    
    //    titleFont = createFont("HoeflerText-Regular", 15);
    //    textFont(titleFont);

    currentCategory = 0;

    titleEnable = true;
    headerLineEnable = true; 
    title = "CATEGORY";

    titleFont = createFont("HoeflerText-Regular", 11);
  }

  void update(int cCategory) {
    this.currentCategory = cCategory;
  }

  void display() {
    // temp
    //    fill(0, 0, 70, 50);
    //    noStroke();
    //    rect(x, y, w, h);    
    // temp

    pushMatrix();
    translate(x, y);  
    super.display();

    // Translated coordinates add up when using the mouse. They have to be subtracted from current mouse position for each translate.
    float mx = mouseX-x;
    float my = mouseY-y;     
    //println(mx +","+my);

    // draw here
    float nextY = 0;
    for (int i = 0; i < nCategories; i++) {
      fill(legendLight);

      if (currentCategory == i) {
        fill(legendSelected);
      }

      textSize(16);
      textAlign(LEFT, CENTER);
      nextY = (16 + i*28);
      text(categories[i], 0, nextY);
    }



    // draw title 
    fill(227, 3, 80);    
    //textSize(10);
    textFont(titleFont);
    textAlign(LEFT, BOTTOM);    
    text("CONCENTRATION", 0, nextY+96); 

    // draw headerline
    strokeWeight(1);
    stroke(headerLine);
    strokeCap(SQUARE);     
    line(0, nextY+96, w, nextY+96);


    // color key
    fill(0, 0, 100); 
    noStroke();
    for (int i= 0; i < 250; i++ ) {
      int b = int(map(i, 0, 250, 130, 300));

      fill(b, 71, 100);
      rect(0, nextY+106 + i, 30, 1);
    }

    // color key labels
    // low
    textSize(16);
    textAlign(LEFT, CENTER);
    fill(colorLabel);
    text("Low", 45, nextY+112);

    // high
    textSize(16);
    textAlign(LEFT, CENTER);
    fill(colorLabel);
    text("High", 45, nextY+348);

if(toggleControls) {
    // high
    textSize(14);
    textAlign(LEFT, CENTER);
    fill(colorLabel);
    text("[ / ] : -/+ Category", 0, nextY+380);
    text("n / m : -/+ Month", 0, nextY+396);
    text("t : Toggle Control", 0, nextY+412);    
}
    // end draw here
    popMatrix();
  }

  //  void drawTitle() {
  //    textFont(titleFont);
  //    fill(227, 3, 70);    
  //    //textSize(10);
  //    textAlign(LEFT, BOTTOM);    
  //    text(title, 0, 0); 
  //  }

  color[] getColors() {
    return colors;
  }

  void setColors(color[] c) {
    colors = c;
  }  


  boolean overItem(float mx, float my) {
    if ((mx >= x) && (mx <= x+w) && (my >= y) && (my <= y+h)) {
      return true;
    } 
    else {
      return false;
    }
  }// end
}

