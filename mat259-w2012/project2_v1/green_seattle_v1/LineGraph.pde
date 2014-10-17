class LineGraph extends DataPlot {
  int currentMonth;
  int currentYear;

  DataTable data; 
  float dataMin, dataMax;  

  int columnCount;
  int rowCount;

  int currentColumn = 0; // in this there is only 1 column of data, the total checkouts at each day
  String date[];

  float mx, my;

  Integrator[] monthInterpolater;  

  LineGraph(float x1, float y1, float w, float h, DataTable data) {
    super(x1, y1, w, h);

    this.data = data;

    columnCount = data.getColumnCount();
    rowCount = data.getRowCount();
    //println(columnCount + ", " + rowCount);

    dataMin = 0;
    dataMax = ceil(data.getTableMax());
    //date = data.getRowNames(); // get array of String[] with all the dates

    monthInterpolater = new Integrator[31]; // 0 to 30
    int dayCounter = 1;
    int rowCounter = 0;
    float initialValue = 0.0;

    // init the whole month worth
    for (int i = 0; i < monthInterpolater.length; i++) {

      String d = data.getDay(rowCounter);
      if (int(d) == dayCounter) {
        initialValue = data.getValue(rowCounter, 0); // start at row 0 of January
        rowCounter++;
        dayCounter++;
      } 
      else {
        initialValue = 0.0; // fill the holes in date with 0.0
        dayCounter++;
      }
      monthInterpolater[i] = new Integrator(initialValue);
    }

    // Corners of plotted time series 
    plotX1 = 0; // left side
    plotX2 = w - plotX1; // right side    
    plotY1 = 10;  // top
    plotY2 = h - plotY1; // bottom

    currentMonth = 1;

    titleEnable = true;
    headerLineEnable = true; 
    title = "CHECKOUTS PER DAY FOR MONTH";
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
    // Translated coordinates add up when using the mouse. They have to be subtracted from current mouse position for each translate.
    mx = mouseX-x;
    my = mouseY-y;     

    // draw here
    // background plot area
    stroke(227, 3, 70, 70);
    noFill();
    rect(plotX1, plotY1, plotX2, plotY2-20);

    drawAxisLabels(currentMonth);
    drawLinesInMonth(currentMonth);    
    drawDataPointsInMonth(currentColumn, currentMonth); 
    drawDataHighlight(currentColumn, currentMonth);

    for (int i = 0; i < monthInterpolater.length; i++) {
      monthInterpolater[i].update();
    }

    // end draw here
    popMatrix();
  }


  void drawAxisLabels(int m) {
    fill(0, 0, 100); 
    textSize(14);

    // draw day labels
    float xs = plotX1+10;
    float xe = plotX2-10;    
    float n = daysInMonth[m-1]-1; // days in month - 1. Ex, 30 if there are 31 days in month  

    textAlign(CENTER, BOTTOM);
    for (int i = 0; i <= n; i++) { 
      float x =  lerp(xs, xe, i/n);  
      // first day of month
      if (i == 0 || i == n) {           
        text((i+1), x, plotY2+10);
      } 
      // this can fill other dates in a month if needed, experiment with later.
      else if (i % 2 == 0) {
        text((i+1), x, plotY2+10);
      }
    }
  }// end


  // Draw the data as a series of points
  void drawDataPointsInMonth(int col, int m) {
    beginShape();
    float n = daysInMonth[m-1]-1; //get number of days in month    

    // rowCounter needs to be set to the index of the start of the month selected
    int rowCounter = data.getRowIndex(str(m)); // m = 0 = 0+1 = January          
    int dayCounter = 1;

    // loop over whole month and draw points 
    for (int i = 0; i <= n; i++) {
      float x =  lerp(plotX1+10, plotX2-10, i/n);
      float y = plotY2-10;

      // check to see if day is in list
      //String parsedDate[] = split(date[rowCounter], "-");      
      String d = data.getDay(rowCounter);
      if (int(d) == dayCounter) {       
        float value = monthInterpolater[i].value;
        y = map(value, dataMin, dataMax, plotY2-10, plotY1+10); 
        dayCounter++;
        rowCounter++;
      } 
      else {
        y = plotY2-10; // 0 checkouts
        dayCounter++;
      }

      // always draw point at x, y
      stroke(0, 0, 70);
      strokeWeight(5);
      strokeCap(ROUND);     
      point(x, y);

      noFill();
      stroke(0, 0, 70);
      strokeWeight(1);
      strokeCap(ROUND);     
      vertex(x, y);

      if ((dayCounter == 2) || (dayCounter == n+2)) {
        vertex(x, y);
      }
    }
    endShape();
  }// end


  // Draw the data as a series of points
  void drawLinesInMonth(int m) {

    float xs = plotX1+10;
    float xe = plotX2-10;    
    float n = daysInMonth[m-1]-1; // days in month - 1. Ex, 30 if there are 31 days in month  
    for (int i = 0; i <= n; i++) { 

      float x =  lerp(xs, xe, i/n);  
      // textAlign(CENTER, BOTTOM);

      // first day of month
      if (i == 0 || i == n) {   
        stroke(0, 0, 70, 30);
        strokeWeight(2);
      } 
      else {
        stroke(0, 0, 70, 30);
        strokeWeight(1);
      }
      strokeCap(SQUARE);     
      line(x, plotY1, x, plotY2-10);
    }
  }// end


  void setCurrentMonth(int m) {
    currentMonth = m;

    // update interpolator values for month
    int n = (int)daysInMonth[m-1]-1; //get number of days in month     
    int rowCounter = data.getRowIndex(str(m)); // m = 0 = 0+1 = January 
    int dayCounter = 1;

    // go through the month, grab the target values and put them into the interpolator, and fill the excess with zeros
    for (int i = 0; i <= n; i++) {
      String d = data.getDay(rowCounter);
      if (int(d) == dayCounter) {
        monthInterpolater[i].target(data.getValue(rowCounter, 0)); // set target value to next set of data values
        dayCounter++;
        rowCounter++;
      } 
      else {
        monthInterpolater[i].target(0.0); // set target value to next set of data values
        dayCounter++;
      }
    }
  }// end


  void setCurrentYear(int y) {
    currentYear = y;
  }  


  void drawDataHighlight(int col, int m) {

    float n = daysInMonth[m-1]-1; //get number of days in month    

    // rowCounter needs to be set to the index of the start of the month selected
    int rowCounter = data.getRowIndex(str(m)); // m = 0 = 0+1 = January          
    int dayCounter = 1;

    float textPosX = plotX2-135;
    float textPosY = plotY1;

    //    textAlign(LEFT, TOP);   
    //    text("checkouts per day", textPosX, textPosY);        

    // loop over whole month and draw points 
    for (int i = 0; i <= n; i++) {
      float x =  lerp(plotX1+10, plotX2-10, i/n);
      float y = plotY2-10;

      float value = 0;

      // check to see if day is in list
      String d = data.getDay(rowCounter);
      if (int(d) == dayCounter) {
        value = data.getValue(rowCounter, col);
        y = map(value, dataMin, dataMax, plotY2-10, plotY1+10); 
        dayCounter++;
        rowCounter++;
      } 
      else {
        y = plotY2-10; // 0 checkouts
        dayCounter++;
      }

      // handle rollover
      if (dist(mx, my, x, y) < 9) {
        // point        
        stroke(0, 0, 100);        
        strokeWeight(9); 
        strokeCap(ROUND);            
        point(x, y);             

        // text
        fill(0, 0, 100);
        textAlign(CENTER);   
        text((int)value, plotX1-10, y);

        stroke(0, 0, 70);
        strokeWeight(1);
        strokeCap(ROUND);     
        line(plotX1, y, plotX1-2, y);
      }
    }
  }
}

