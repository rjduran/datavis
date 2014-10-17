// RJ DURAN
// DATA VISUALIZATION 
// MAT259 - WINTER 2012
// PROJECT 3: SPL VS  LASTFM
// 2/28/2012
// RJDURANJR@GMAIL.COM / RJDURAN.NET

// layout
Grid grid;
boolean showGrid = false;
boolean showMousePosition = false;
boolean showInfo = false;

float hSquareSize;
float vSquareSize;
float padding;

// data
DataTable splData;
DataTable lastfmData;

// elements
GridView gridView;
PFont font;
color bgColor;
color textColor;

void setup() {
  size(1280, 800);
  setupGrid();
  colorMode(HSB, 360, 100, 100, 100); 
  smooth();
  setColor();

  font = createFont("Helvetica", 12);

  // load SPL and lastfm data
  splData = new DataTable("2011Data.txt");
  lastfmData = new DataTable("lastfmData_174simgs.txt");  
  
  gridView = new GridView(padding, vSquareSize + 2*padding, 14*hSquareSize - 2*padding, 10*vSquareSize - 2*padding, lastfmData, splData);
}

void draw() {   
  background(bgColor);
  if (showGrid) { 
    grid.displayGrid();
  }
  if (showMousePosition) { 
    grid.displayMousePosition();
  }

  gridView.display();

  // TITLE
  textFont(font);      
  fill(textColor);    
  textAlign(LEFT, TOP);
  textSize(30);
  text("POPULAR MUSIC BY ALBUM FOR 2011", padding, 2*padding);

  // DETAIL
  textFont(font);      
  fill(textColor);    
  textAlign(LEFT, BOTTOM);
  textSize(14);

  // lastfm
  fill(347, 77, 92, 65); 
  rect(padding, vSquareSize -padding, hSquareSize/2, 20);
  fill(textColor);    
  text("% LAST.FM PLAYS", padding + hSquareSize/2+10, vSquareSize + padding);

  // spl
  fill(188, 100, 100, 65);
  rect(padding + 2*hSquareSize + 10, vSquareSize - padding, hSquareSize/2, 20);
  fill(textColor);    
  text("% SPL CHECKOUTS", padding + (5*hSquareSize/2) +10+10, vSquareSize + padding);
  
  if (showInfo) {
    // info label
    textFont(font);      
    fill(textColor);    
    textSize(10);
    textAlign(LEFT, BOTTOM);
    text("RJ DURAN\nDATA VISUALIZATION\nMAT259 - WINTER 2012", padding, height-padding);
  }  
}

void setupGrid() {
  grid = new Grid(width, height, 14, 12, 10); // w, h, hzd, vtd, padding
  hSquareSize = grid.getHSize();
  vSquareSize = grid.getVSize();
  padding = grid.getPadding();
}

void setColor() {
  bgColor = color(0, 0, 0); 
  textColor = color(0, 0, 100);
}

