class TimelineGraph extends DataPlot {
  String monthLabels[] = {
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"
  };

  DataTable data; 
  float dataMin, dataMax;  

  int columnCount;
  int rowCount;

  int currentColumn = 0; // in this there is only 1 column of data, the total checkouts at each day
  String date[];

  float divisions;

  LineGraph[] monthGraphs;

  Button[] monthSelector;
  int currentMonth;
  int currentYear;


  TimelineGraph(float x1, float y1, float w, float h, DataTable data) {
    super(x1, y1, w, h);

    this.data = data;

    columnCount = data.getColumnCount();
    rowCount = data.getRowCount();
    //println(columnCount + ", " + rowCount);

    dataMin = 0;
    dataMax = ceil(data.getTableMax());
    //date = data.getRowNames(); // get array of String[] with all the dates

    // Corners of plotted time series 
    plotX1 = 0; // left side
    plotX2 = w - plotX1; // right side    
    plotY1 = 10;  // top
    plotY2 = h - plotY1; // bottom
    divisions = 12;

    monthSelector = new Button[12];

    float xs = plotX1+10;
    float xe = plotX2-10;   
    float dw = ((xe-10)-(xs+10)) / divisions;
    for (int i = 0; i < divisions; i++) { 
      float d = i/divisions;
      float x =  lerp(xs, xe, d);  

      // draw rectangles on timeline
      //fill(100, 70, 70, 20);
      noStroke();
      monthSelector[i] = new Button(x+0.5, plotY1+1, dw+0.5, plotY2-21);
    }

    //    plotFont = createFont("SansSerif", 15);
    //    textFont(plotFont);

    currentMonth = 0;

    titleEnable = true;
    headerLineEnable = true; 
    title = "CHECKOUTS PER MONTH FOR YEAR";
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
    float mx = mouseX-x;
    float my = mouseY-y;           

    // draw here
    // background plot area
    stroke(227, 3, 70, 70);
    fill(0, 0, 70, 30);
    rect(plotX1, plotY1, plotX2, plotY2-20);

    // draw elements
    drawAxisLabels();
    drawDataPointsInYear(currentColumn);
    
    // draw buttons
    for (int i = 0; i < divisions; i++) { 
      if (i == currentMonth) {
        monthSelector[currentMonth].setActive();
      } 
      else {
        monthSelector[i].setInactive() ;
      }       
      monthSelector[i].update(mx, my);
      monthSelector[i].display();
    }
    
      drawDivisions();

    // end draw here
    popMatrix();
  } 


  void drawAxisLabels() {
    fill(0, 0, 100); 
    textSize(14);

    float xs = plotX1+10;
    float xe = plotX2-10;      
    textAlign(CENTER, BOTTOM);
    float dw = ((xe-10)-(xs+10)) / divisions;    
    for (int i = 0; i < divisions; i++) { 
      float x =  lerp(xs, xe, i/divisions);  
      text(monthLabels[i], x + dw*0.5, plotY2+10);
    }
  }// end


  // Draw the data as a series of points
  void drawDataPointsInYear(int col) {
    beginShape();
    float xs = plotX1+10; // x start
    float xe = plotX2-10; // x end
    float dw = ((xe-10)-(xs+10)) / divisions; // division width

    for (int m = 0; m < divisions; m++) {
      float xm =  lerp(xs, xe, m/divisions);  // get x at each month division

      float nDays = daysInMonth[m]-1; //get number of days in month    
      int rowCounter = data.getRowIndex(str(m+1)); // m = 0 = 0+1 = January          
      int dayCounter = 1;

      for (int i = 0; i <= nDays; i++) {
        float x =  lerp(xm, xm+dw, i/nDays);
        float y = plotY2-10;

        String d = data.getDay(rowCounter);
        if (int(d) == dayCounter) {
          float value = data.getValue(rowCounter, col);
          y = map(value, dataMin, dataMax, plotY2-10, plotY1+10); 
          dayCounter++;
          rowCounter++;
        } 
        else {
          y = plotY2-10; // 0 checkouts
          dayCounter++;
        }

        //stroke(0);        
//        strokeWeight(0.1);
        noStroke();
        vertex(x, y);
      }
    }
    vertex(plotX2-10, plotY2-10);
    vertex(plotX1+10, plotY2-10);    
    endShape(CLOSE);
  }// end


  // draws the division lines
  void drawDivisions() {
    float xs = plotX1+10;
    float xe = plotX2-10;    
    for (int i = 0; i <= divisions; i++) { 
      float x =  lerp(xs, xe, i/divisions);        

      if (i == 0 || i == divisions) {   
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


  int getNDivisions() {
    return (int)divisions;
  }


  void setCurrentMonth(int c) {
    currentMonth = c;
  }


  void setCurrentYear(int y) {
    currentYear = y;
  }
}

