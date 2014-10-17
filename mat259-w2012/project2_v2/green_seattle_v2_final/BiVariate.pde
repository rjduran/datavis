class BiVariate extends DataPlot {
  float mx, my;

  int currentMonth;
  int currentYear;
  int currentCategory;

  DataTable data; 
  int columnCount;
  int rowCount;

  String[] date;
  int[][] count;
  int[][] hrVsDayCount;

  int catColumnCount;
  int catRowCount;


  BiVariate(float x1, float y1, float w, float h, DataTable data) {
    super(x1, y1, w, h);

    this.data = data;

    columnCount = data.getColumnCount();
    rowCount = data.getRowCount();

    date = data.getRowNames(); // get array of String[] with all the dates

      hrVsDayCount = new int[12][31]; // 12 rows x 31 possible columns

    for (int r = 0; r< 12; r++) {
      for (int c = 0; c< 31; c++) {
        hrVsDayCount[r][c] = 0;
      }
    }

    // Corners of plotted area (starting at top left of dark outside border)
    plotX1 = 0; // left side
    plotX2 = w - plotX1; // right side    
    plotY1 = 10;  // top
    plotY2 = h - plotY1; // bottom

    titleEnable = true;
    headerLineEnable = true; 
    title = "TOTAL CHECKOUTS PER HOUR";
  }// end


  void update(int cMonth, int cYear, int cCategory) {
    this.currentMonth = cMonth;
    this.currentYear = cYear;
    this.currentCategory = cCategory;

    parseData();
  }


  void display() {
    pushMatrix();
    translate(x, y);  
    super.display();
    // Translated coordinates add up when using the mouse. They have to be subtracted from current mouse position for each translate.
    mx = mouseX-x;
    my = mouseY-y;   

    // draw here

    // background plot area
    stroke(227, 3, 70, 50);
    noFill();
    rect(plotX1, plotY1, plotX2, plotY2-20);

    drawAxisLabels();
    drawLines(); 
    drawCategoryData();

    // end draw here
    popMatrix();
  }// end


  // Here I am parsing the data for the current month and dawing it over each day (12 hrs)
  // For the time periods that have no checkouts, nothing gets drawn
  void parseData() {
    int m = currentMonth;    
    float n = daysInMonth[m]; //get number of days in month    

    // rowCounter needs to be set to the index of the start of the month selected
    int rowCounter = data.getRowIndexForMonth(m+1); // m = 0 = 0+1 = January          
    int nEntries = data.getNEntriesForMonth(m+1); // get number of entries for the month
    ////println("row: " + rowCounter + ", nEntries: " + nEntries);

    // init category counters for month
    for (int r = 0; r < 12; r++) {
      for (int c = 0; c < 31; c++) {
        hrVsDayCount[r][c] = 0;
      }
    }

    // for each entry in month, do this
    for (int i = 0; i < nEntries; i++) {
      String[] pieces = split(date[i+rowCounter], '-');
      int d = int(pieces[2]); // get day index from date

      // if day is less than number of days in month
      if (d <= n) {

        // look at each hour for day d
        for (int h = 0; h < 12; h++) {

          String[] time = split(data.getValue(i, 0), ":");
          int hr = int(time[0]);

          if ((h+8) == int(hr)) {
            //println("day: "+ d +", hour: "+ (h+8) + ", " + "time: " + hr);

            int cVal = Integer.parseInt(data.getValue(i, currentCategory+2));

            if (cVal == 1) {                
              hrVsDayCount[h][d-1]++;
              //println("h: "+h +" ("+(h+8)+")"+ ", day: " + d + ", hrVsDayCount: " +hrVsDayCount[h][d-1]); // MOST HELPFUL TO DEBUG. SHOWS HOUR, DAY AND CATEGORY COUNT PER HR
              break;
            }
          }
        }
      }
    }
  }


  void drawCategoryData() {

    int m = currentMonth;    
    float n = daysInMonth[m]; 
    float hrs = 12;

    float xs = plotX1+10;
    float xe = plotX2-10;    
    float ys = plotY1+10;
    float ye = plotY2-20; 

    float dw = ((xe-10)-(xs+10)) / n; // width of each block
    float dh = ((ye-10)-(ys+10)) / hrs;    //height of each block

    int maxVal = getMax(hrVsDayCount);

    noStroke();

    for (int i = 0; i < n; i++) {    // col (day of month)
      float x =  lerp(xs, xe, i/n);

      for (int j = 0; j < hrs; j++) { // row  (hour of day)   
        float y =  lerp(ys, ye, j/hrs); 
        int countVal = hrVsDayCount[j][i];

        float h;
        float b;

        if (flipColor) { 
          h = map(countVal, 0, maxVal, darkRangeLowH, darkRangeHighH); // assign brightness to counter values, low and high color values for when there is more than 1 counted
          b = brightRange;
        } 
        else {
          h = map(countVal, 0, maxVal, lightRangeHighH, lightRangeLowH); 
          b = brightRange;
        }

        float s = satRange;

        // draw outline on hover
        if (overItem(mx, my, x, y, dw, dh)) {           
          stroke(hoverColor);
          strokeWeight(2);
        } 
        else {
          noStroke();
        }

        // if there are no items counted, darken (or lighten) the square
        if (countVal < 1) {
          fill(zeroCheckoutsColor);
        } 
        else {
          fill(h, s, b);
        }
        rect(x+0.5, y+1, dw, dh);

        // draw count value
        if (overItem(mx, my, x, y, dw, dh)) { 
          fill(0);
          textAlign(CENTER, CENTER);
          text(countVal, x+(dw*0.5), y+(dh*0.5));
        }
      }
    }
  }// end


  void drawAxisLabels() {

    int m = currentMonth;
    fill(axesText); 
    textSize(15);
    textAlign(CENTER, BOTTOM);

    // draw day labels for vertical lines
    float xs = plotX1+10;
    float xe = plotX2-10;    
    float n = daysInMonth[m];

    for (int i = 0; i < n; i++) { 
      float x =  lerp(xs, xe, i/n);  
      // first day of month and last day of month
      if (i == 0 || i == n) {           
        text((i+1), x+15, plotY2+10);
      } 
      else if (i % 2 == 0) {
        text((i+1), x+15, plotY2+10);
      }
    }

    // X axis label
    fill(axesText); 
    textSize(18);
    textAlign(CENTER, CENTER);
    text("Day of Month", (xe-xs)*0.5, plotY2+40);

    // draw hour labels for horizontal lines
    fill(axesText); 
    textSize(15);
    textAlign(LEFT, TOP);

    float hrs = 12;
    float ys = plotY1+10;
    float ye = plotY2-20; 

    for (int i = 0; i < hrs; i++) { 
      float y =  lerp(ys, ye, i/hrs);  

      // first and last hr of day
      if (i == 0 || i == hrs-1) {           
        text((i+8) + ":00", plotX2+10, y+15);
      } 
      else { // every other hr
        text((i+8) + ":00", plotX2+10, y+15);
      }
    }

    // X axis label
    fill(axesText); 
    textSize(18);
    textAlign(CENTER, CENTER);
    text("Hour", plotX2+90, (ye-ys)*0.5 + 18);
  }// end   


  void drawLines() {

    int m = currentMonth;

    // vertical lines represent days
    float xs = plotX1+10;
    float xe = plotX2-10;    
    float n = daysInMonth[m];

    for (int i = 0; i <= n; i++) { 
      float x =  lerp(xs, xe, i/n);  

      // first day of month
      if (i == 0 || i == n) {   
        stroke(linesHeavy);
        strokeWeight(1.5);
      } 
      else { // every other day of month
        stroke(linesLight);        
        strokeWeight(1);
      }
      strokeCap(SQUARE);     
      line(x, plotY1, x, plotY2-10);
    }

    // horizontal lines represent hours in a day
    float hrs = 12;
    float ys = plotY1+10;
    float ye = plotY2-20; 

    for (int i = 0; i <= hrs; i++) { 
      float y =  lerp(ys, ye, i/hrs);  

      // first hr and last hr
      if (i == 0 || i == hrs) {   
        stroke(linesHeavy);
        strokeWeight(1.5);
      } 
      else { // every other hr
        stroke(linesLight);
        strokeWeight(1);
      }
      strokeCap(SQUARE);     
      line(plotX1, y, plotX2, y);
    }
  }// end


  int getMax(int[][] data) {
    int m = -1000;
    for (int i = 0; i < 12; i++) {
      for (int j = 0; j < 31; j++) {              
        if (data[i][j] > m) {
          m = data[i][j];
        }
      }
    }
    return m;
  }// end

  // handle hover
  boolean overItem(float mx, float my, float x, float y, float dw, float dh) {
    if ((mx >= x) && (mx <= x+dw) && (my >= y) && (my <= y+dh)) {
      return true;
    } 
    else {
      return false;
    }
  }// end
}

