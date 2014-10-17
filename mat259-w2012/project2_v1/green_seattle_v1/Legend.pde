class Legend extends DataPlot {

  int nCategories;  
  String[] categories;
  color[] colors;
  
  PFont titleFont;
  PFont copyFont;
  
  Legend(float x1, float y1, float w, float h, String[] cat) {
    super(x1, y1, w, h);

    categories = cat;    
    nCategories = categories.length;

    colors = new color[nCategories];

    // asign a color to each category
    for (int i = 0; i < nCategories; i++) {
      colors[i] = color(random(50, 300), 100, 100);
    }    

    plotX1 = 10; // left side
    plotX2 = w - plotX1; // right side    
    plotY1 = 10;  // top
    plotY2 = h - plotY1; // bottom
    int space = 5;
    
    // setup font    
//    titleFont = createFont("HoeflerText-Regular", 15);
//    textFont(titleFont);
    
    titleEnable = true;
    headerLineEnable = true; 
    title = "CATEGORY";
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
  
    // draw here
    for (int i = 0; i < nCategories; i++) {
      fill(colors[i]);
      noStroke();
//      rect(10, (10 + i*(20+mouseY)), 10+mouseX, 10+mouseY);
      rect(0, (10 + i*(28)), 8, 16);
      //rect(10, (10 + i*20), 10, 10);

      fill(0, 0, 100);
      textSize(14);
      textAlign(LEFT, CENTER);
      text(categories[i], 30, (16 + i*28));
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

}

