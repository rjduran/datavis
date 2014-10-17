class MiscBox extends DataPlot {

  DataTable data;
  int rowCount;

  String[] items;
  int[] itemCategory;
  color[] categoryColors;
  int currentColumn = 0; 

  int currentMonth;
  int currentYear;

  int totalCheckoutsPerYear;
  int totalCheckoutsPerMonth;
  int mostCheckoutsInAMonth;
  int mostCheckoutsInAYear;

  MiscBox(float x1, float y1, float w, float h, DataTable data) {
    super(x1, y1, w, h);

    this.data = data;

    //columnCount = data.getColumnCount();
    rowCount = data.getRowCount(); // rowCount
    totalCheckoutsPerYear = data.getRowCount(); // rowCount

      mostCheckoutsInAYear = ceil(data.getTableMax());
    // need date of most checkouts




    // setup and parse data
    items = new String[5];
    itemCategory = new int[5];  

    plotX1 = 10; // left side
    plotX2 = w - plotX1; // right side    
    plotY1 = 10;  // top
    plotY2 = h - plotY1; // bottom

    currentMonth = 1; 
    currentYear = 2011; 

    titleEnable = true;
    headerLineEnable = true; 
    title = "                   TOTAL CHECKOUTS                                       MOST CHECKOUTS";
  }

  void update() {
    // calculate total checkouts per month
    totalCheckoutsPerMonth = calculateCheckoutsPerMonth();
    totalCheckoutsPerYear = calculateCheckoutsPerYear();
    mostCheckoutsInAMonth = calculateMostCheckoutsInAMonth();
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
    // chart horizontal and vertical axes
    stroke(0, 0, 70, 30);
    strokeWeight(1);
    strokeCap(SQUARE);     
    float xCenter = w*0.5;
    float yCenter = h*0.5;
    line(xCenter, plotY1, xCenter, plotY2); // vertical
    line(0, yCenter, plotX2+10, yCenter);    

    // left "MONTH" and "YEAR" labels
    fill(227, 3, 70); 
    textFont(titleFont);      
    textAlign(LEFT, TOP);
    text("M\nO\nN\nT\nH", 0, 10);

    fill(227, 3, 70); 
    textFont(titleFont);      
    textAlign(LEFT, TOP);
    text("Y\nE\nA\nR", 0, 10+yCenter);


    // draw totalCheckoutsPerMonth
    fill(0, 0, 100);
    textFont(copyFont);
    textSize(32);
    textAlign(CENTER, CENTER);
    text(nfc(totalCheckoutsPerMonth), xCenter*0.5, yCenter*0.45);

    // draw totalCheckoutsPerYear
    fill(0, 0, 100);
    textFont(copyFont);
    textSize(32);
    textAlign(CENTER, CENTER);
    text(nfc(totalCheckoutsPerYear), xCenter*0.5, yCenter + yCenter*0.45);

    // draw mostCheckoutsInAMonth
    fill(0, 0, 100);
    textFont(copyFont);
    textSize(32);
    textAlign(CENTER, CENTER);
    text(nfc(mostCheckoutsInAMonth), xCenter + xCenter*0.5, yCenter*0.45);

    // draw mostCheckoutsInAYear
    fill(0, 0, 100);
    textFont(copyFont);
    textSize(32);
    textAlign(CENTER, CENTER);
    text(nfc(mostCheckoutsInAYear), xCenter + xCenter*0.5, yCenter + yCenter*0.45);    

    // end draw here
    popMatrix();
  }

  int calculateMostCheckoutsInAMonth() {
    float n = daysInMonth[currentMonth-1]-1; //get number of days in month    
    int rowCounter = data.getRowIndex(str(currentMonth)); // m = 0 = 0+1 = January          
    int dayCounter = 1;
    int maxCheckouts = 0;

    for (int i = 0; i <= n; i++) {
      String d = data.getDay(rowCounter);
      if (int(d) == dayCounter) {       
        if (data.getValue(rowCounter, 0) > maxCheckouts) {
          maxCheckouts = (int)data.getValue(rowCounter, 0);
        }
        dayCounter++;
        rowCounter++;
      } 
      else {
        dayCounter++;
      }
    }

    return maxCheckouts;
  }// end


  int calculateCheckoutsPerMonth() {
    float n = daysInMonth[currentMonth-1]-1; //get number of days in month    
    int rowCounter = data.getRowIndex(str(currentMonth)); // m = 0 = 0+1 = January          
    int dayCounter = 1;
    int totalCheckouts = 0;

    for (int i = 0; i <= n; i++) {
      String d = data.getDay(rowCounter);
      if (int(d) == dayCounter) {       
        totalCheckouts += data.getValue(rowCounter, 0);
        dayCounter++;
        rowCounter++;
      } 
      else {
        dayCounter++;
      }
    }
    return totalCheckouts;
  }// end

  int calculateCheckoutsPerYear() {
    //float n = daysInMonth[m-1]-1; //get number of days in month    
    int rowCounter = data.getYearRowIndex(str(currentYear)); // get row the year starts in in file
    int yearCounter = currentYear;    // start year counter at 2011
    int totalCheckouts = 0;

    // over current year, add up all the checkout values
    for (int i = 0; i < rowCount; i++) { // over the course of n, where n= 365 or 366 (leap year), add up daily checkout totals
      String y = data.getYear(rowCounter);
      if (int(y) == currentYear) {       
        totalCheckouts += data.getValue(rowCounter, 0);
        rowCounter++;
      }
    }
    return totalCheckouts;
  }// end



  //void drawDataInYear(int cYear, int cMonth) {
  //
  //    entriesCounted = 0;
  //
  //    for (int row = 1; row < rowCount; row++) {    
  //      int year = Integer.parseInt(data.getValue(row, 3));
  //      int month = Integer.parseInt(data.getValue(row, 4));
  //
  //      // monthly category totals
  //      if ((year == cYear) && (month == cMonth)) {
  //        // sum category totals
  //        int k = 5; // start at cat1 index      
  //        for (int j = 0; j < categoryTotals.length; j++) {
  //          categoryTotals[j] += Integer.parseInt(data.getValue(row, k)); // monthly category totals for cat1-7
  //          k++;
  //        }
  //        entriesCounted++;
  //      }
  //    }
  //    
  //    




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

