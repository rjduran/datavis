class LineGraph extends DataPlot {
  int currentMonth;
  int currentYear;

  DataTable data; 
  float dataMin, dataMax;  

  int columnCount;
  int rowCount;

  int currentCategory;
  String[] date;

  //DataTable categoryData;

  float mx, my;

  int catColumnCount;
  int catRowCount;

  int[][] count;

  int[][] hrVsDayCount;

  LineGraph(float x1, float y1, float w, float h, DataTable data) {
    super(x1, y1, w, h);

    this.data = data;

    columnCount = data.getColumnCount();
    rowCount = data.getRowCount();
    //    println(columnCount + ", " + rowCount); // this works

    date = data.getRowNames(); // get array of String[] with all the dates


      // category data
    //    categoryData = new DataTable("categories.txt");
    //    catColumnCount = categoryData.getColumnCount();
    //    catRowCount = categoryData.getRowCount();
    //println(catColumnCount + ", " + catRowCount); // this works

      //count = new int[12][7]; // 12 rows x 7 cols

      hrVsDayCount = new int[12][31]; // 12 rows x 31 possible columns

    // init
    //    for (int r = 0; r< 12; r++) {
    //      for (int c = 0; c< 7; c++) {
    //        count[r][c] = 0;
    //      }
    //    }

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


    //currentMonth = 1;

    titleEnable = true;
    headerLineEnable = true; 
    title = "TOTAL CONCENTRATION OF CHECKOUTS PER HOUR";
  }// end

  void update(int cMonth, int cYear, int cCategory) {
    this.currentMonth = cMonth;
    this.currentYear = cYear;
    this.currentCategory = cCategory;

    parseData();
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
    mx = mouseX-x;
    my = mouseY-y;     

    // draw here
    // background plot area
    //stroke(227, 3, 70, 70);
    stroke(227, 3, 70, 50);
    noFill();
    rect(plotX1, plotY1, plotX2, plotY2-20);

    drawAxisLabels();
    drawLines(); 

    drawCategoryData();

    //    println("print month counts");
    //    for (int r = 0; r< 12; r++) {
    //      for (int c = 0; c< 7; c++) {
    //        println("["+r+"]["+c+"]"+count[r][c]);
    //      }
    //    }

    // end draw here
    popMatrix();
  }// end


  /*
  I want to take in the current month and draw data for each day over the course of 12 hours
   
   I need to parse the data structure for
   the month
   then the day
   if there are days that dont have data, nothing gets drawn
   
   for the days that have data I need to compare the title of the entry in that row to my keywords for each category.
   for the entry I need to keep track of the categories that match words in the title and add 1 to a counter for that category in that hour
   
   */
  void parseData() {
    int m = currentMonth;    
    float n = daysInMonth[m]; //get number of days in month    

    // rowCounter needs to be set to the index of the start of the month selected
    int rowCounter = data.getRowIndexForMonth(m+1); // m = 0 = 0+1 = January          
    int nEntries = data.getNEntriesForMonth(m+1); // need number of entries for the month

    // loop over entries until end of month 
    // loop over each day until end of day


    // categorize each entry based on category keywords using 2d array
    // look at the title and hour for entry, match to category, add 1 to category counter for that hour

    // 
    // take the totals of each category and associate with a color brightness
    // and draw on the plot

    // init counters for month
    for (int r = 0; r< 12; r++) {
      for (int c = 0; c< 31; c++) {
        hrVsDayCount[r][c] = 0;
      }
    }

    //////for each entry
    for (int i = 0; i < nEntries; i++) {
      String[] pieces = split(date[i+rowCounter], '-');
      int d = int(pieces[2]); // day index from date

      // if day is less than number of days in month
      if (d < n) {

        for (int h = 0; h < 12; h++) {
          // look at each hour for day d
          // does the current entry at i belong in this hour h?
          // look at cout time

          // println("day: "+ d +", hour: "+ (h+8) + ", " + "time: " + data.getValue(i, 0));
          // if the value is found to be a match with (h+8), exit for loop to reduce cycles using break     

          // NEXT STEPS ARE TO IMPLEMENT A CATEGORY COUNTER 2D ARRAY THAT HOLDS THE CATEGORY COUNT FOR EACH HOUR OF THE DAY
          String[] time = split(data.getValue(i, 0), ":");
          int hr = int(time[0]);

          if ((h+8) == int(hr)) {
            //println("day: "+ d +", hour: "+ (h+8) + ", " + "time: " + hr);

            // add 1 to the category counter for this entry
            // to do this i need to categorize the item
            // [0] = hr, [1] = cat idx

            //int cIdx = categorize(data.getValue(i, 1)); // get our title to categorize, get back the category to increment
            // here we can just pull the category for the entry and add it to the current count for the hour

              //for (int j = 0; j < 7; j++) {
            int cVal = Integer.parseInt(data.getValue(i, currentCategory+2));

            // check if the value in one of our 7 categories is 1, if it is, grab the index and use to increment 
            // the counter for that category in that hour of the day
            //            println("entry: "+ i + ", cVal: " + cVal);
            if (cVal == 1) {                
              //print(cIdx + ", ");
              //count[h][j]++; // hour, category

              hrVsDayCount[h][d]++;
              //println("h: "+h +" ("+(h+8)+")"+ ", day: " + d + ", hrVsDayCount: " +hrVsDayCount[h][d]); // MOST HELPFUL TO DEBUG. SHOWS HOUR, DAY AND CAT COUNT PER HR
              //break;
            }
            //}

            //break;

            // here save current category count for day vs hr
            //            hrVsDayCount[h][d]
            //println("hour: "+h +" ("+(h+8)+")"+ ", day: "+ d);
          }
        }
      }
    }
  }

  void drawCategoryData() {

    int m = currentMonth;    
    float n = daysInMonth[m]; // days in month - 1. Ex, 30 if there are 31 days in month since i starts at 0  
    float hrs = 12;

    float xs = plotX1+10;
    float xe = plotX2-10;    
    float ys = plotY1+10;
    float ye = plotY2-20; 

    float dw = ((xe-10)-(xs+10)) / n; // width
    float dh = ((ye-10)-(ys+10)) / hrs;    //height

    int maxVal = getMax(hrVsDayCount);

    //color start = color(0, 71, 78);
    // color end = color(184, 71, 78);    


    noStroke();

    for (int i = 0; i < n; i++) {    // col (day of month)
      float x =  lerp(xs, xe, i/n);

      for (int j = 0; j < hrs; j++) { // row  (hour of day)   
        float y =  lerp(ys, ye, j/hrs); 
        //println( "["+j+", "+i+"] = " + hrVsDayCount[j][i]);

        float b = map(hrVsDayCount[j][i], 0, maxVal, 130, 300); // assign brightness to counter values, low and high color values for when there is more than 1 counted

        // if there are no items counted, darken the square
        if (hrVsDayCount[j][i] < 1) {
          fill(0, 0, 40, 30);
        } 
        else {
          fill(b, 71, 100);
        }
        rect(x+0.5, y+0.5, dw, dh);
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

    // Y axis label
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


  // Draw the data as a series of points
  void drawLines() {

    int m = currentMonth;
    // vertical lines represent days
    // 
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

      // first day of month
      if (i == 0 || i == hrs) {   
        stroke(linesHeavy);
        strokeWeight(1.5);
      } 
      else { // every other day of month
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
        //if (isValid(i, j)) {
        if (data[i][j] > m) {
          m = data[i][j];
        }
        //}
      }
    }
    return m;
  }// end
}

