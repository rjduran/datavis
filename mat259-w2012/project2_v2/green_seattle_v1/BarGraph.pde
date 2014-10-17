class BarGraph extends DataPlot {
  int currentMonth;
  int currentYear;

  ItemDataTable data; 
  int columnCount;
  int rowCount;

  float mx, my; // mouseX and mouseY inside this graph

  // general interest bargraph specific
  int[] categoryTotals;
  int entriesCounted;
  int monthlyCategoryMax;
  int monthlyCategoryMin;
  float barWidth;
  int nCategories = 7;

  color[] colors;

  BarGraph(float x1, float y1, float w, float h, ItemDataTable data) {
    super(x1, y1, w, h);

    this.data = data;

    columnCount = data.getColumnCount();
    rowCount = data.getRowCount();
    //println(columnCount + ", " + rowCount);

    // setup and parse data
    categoryTotals = new int[nCategories];
    entriesCounted = 0;  
    //String savedData[] = loadStrings("2011data.txt");

    plotX1 = 0; // left side
    plotX2 = w - plotX1; // right side    
    plotY1 = 10;  // top
    plotY2 = h - plotY1; // bottom

    currentMonth = 1; 
    currentYear = 2011;   

    // setup font    
//    plotFont = createFont("SansSerif", 15);
//    textFont(plotFont);

    title = "GENERAL INTEREST BY CATEGORY";
    titleEnable = true;
    headerLineEnable = true;
  }

  void update() {
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
    
    mx = mouseX-x;
    my = mouseY-y;  

    // draw here
    drawDataInYear(currentYear, currentMonth);
    resetCategoryTotals();
    // end draw here
    popMatrix();
  }

  // Draw the data as a series of points
  void drawDataInYear(int cYear, int cMonth) {

    entriesCounted = 0;

    for (int row = 1; row < rowCount; row++) {    
      int year = Integer.parseInt(data.getValue(row, 3));
      int month = Integer.parseInt(data.getValue(row, 4));

      // monthly category totals
      if ((year == cYear) && (month == cMonth)) {
        // sum category totals
        int k = 5; // start at cat1 index      
        for (int j = 0; j < categoryTotals.length; j++) {
          categoryTotals[j] += Integer.parseInt(data.getValue(row, k)); // monthly category totals for cat1-7
          k++;
        }
        entriesCounted++;
      }
    }
        //println(entriesCounted); // number of books checked out per month total

    monthlyCategoryMax = getCategoryMax(categoryTotals);
    monthlyCategoryMin = getCategoryMin(categoryTotals);

    int spacing = 5;
    barWidth = (plotX2-plotX1)/7 - spacing; // set barWidth + spacing    
    noStroke();
    for (int c = 0; c < nCategories; c++) {
      float value = categoryTotals[c];
      float x1 = map(c, 0, nCategories-1, plotX1+barWidth/2, plotX2-barWidth/2);
      float y1 = map(value, 0, monthlyCategoryMax, plotY2, plotY1); // show the results a little lower than the top of the graph. theres a better way to do this

      //      fill(123, 48, 70);
      fill(colors[c]);
      //ellipse(x1, y1, 5, 5);
      rect(x1-barWidth/2, y1, barWidth, plotY2-y1);
    }
  }// end  

  void resetCategoryTotals() {
    for (int j = 0; j < categoryTotals.length; j++) {
      categoryTotals[j] = 0;
    }
  }

  int getCategoryMax(int[] values) {
    int m = 0;

    for (int i =0; i < values.length; i++) {
      if (values[i] > m) {
        m = values[i];
      }
    }
    return m;
  }

  int getCategoryMin(int[] values) {
    int m = 1000;

    for (int i =0; i < values.length; i++) {
      if (values[i] < m) {
        m = values[i];
      }
    }
    return m;
  }

  void setCurrentMonth(int c) {
    currentMonth = c;
  }

  void setCurrentYear(int y) {
    currentYear = y;
  }

  void setColors(color[] c) {
    colors = c;
  }
}

