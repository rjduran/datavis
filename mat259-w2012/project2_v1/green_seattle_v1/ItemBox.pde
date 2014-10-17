class ItemBox extends DataPlot {

  ItemDataTable data;

  String[] items;
  int[] itemCategory;
  int[] itemTotalCheckouts;

  color[] categoryColors;

  int currentMonth;
  int currentYear;


  //  int[] categoryLabel;
  //  int nItems;

  ItemBox(float x1, float y1, float w, float h, ItemDataTable data) {
    super(x1, y1, w, h);

    this.data = data;

    //columnCount = data.getColumnCount();
    //rowCount = data.getRowCount();

    // setup and parse data
    items = new String[5];
    itemTotalCheckouts = new int[5];
    itemCategory = new int[5];

    //entriesCounted = 0;  

    plotX1 = 10; // left side
    plotX2 = w - plotX1; // right side    
    plotY1 = 10;  // top
    plotY2 = h - plotY1; // bottom

    currentMonth = 1; 
    currentYear = 2011; 

    // setup font    
    //    copyFont = createFont("HoeflerText-Regular", 14);
    //    textFont(copyFont);

    titleEnable = true;
    headerLineEnable = true; 
    title = "MOST POPULAR READS                                                                               # READ";
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
    for (int i = 0; i < items.length; i++) {

      // draw item text
      fill(0, 0, 100); 
      textFont(copyFont);
      textSize(16);      
      textAlign(LEFT, TOP);
      text(""+items[i], 20, (10 + i*56), 310, 50);

      // draw category box
      fill(categoryColors[itemCategory[i]]);
      noStroke();
      rect(0, (10 + i*56), 8, 36);

      // counter text
      fill(0, 0, 100); 
      textFont(copyFont);
      textSize(30);      
      textAlign(CENTER);
      text(""+itemTotalCheckouts[i], 220, (10 + i*56), 350, 50);
    }

    //println(currentMonth);

    drawPopularItems(currentYear, currentMonth);

    // end draw here
    popMatrix();
  }

  // Draw the data as a series of points
  void drawPopularItems(int cYear, int cMonth) {

    int rowCounter = data.getRowIndex(str(cMonth)); // m = 0 = 0+1 = January          

    //String d = data.getMonth(rowCounter);

    for (int i = 0; i < items.length; i++) {    
      int year = Integer.parseInt(data.getValue(rowCounter, 3));
      int month = Integer.parseInt(data.getValue(rowCounter, 4));

      // monthly category totals
      if ((year == cYear) && (month == cMonth)) {
        items[i] = data.getValue(rowCounter, 0); // title
        itemTotalCheckouts[i] = Integer.parseInt(data.getValue(rowCounter, 2)); // total checkouts of the title        

        // look through categories and find matches to classify item for coloring
        for (int c=0; c < 7; c++) {
          if (Integer.parseInt(data.getValue(rowCounter, 5+c)) == 1) {
            itemCategory[i] = c;
          }
        }

        rowCounter++;
      }
    }
  }

  void setColors(color[] c) {
    categoryColors = c;
  }

  void setCurrentMonth(int c) {
    currentMonth = c;
  }

  void setCurrentYear(int y) {
    currentYear = y;
  }
}

