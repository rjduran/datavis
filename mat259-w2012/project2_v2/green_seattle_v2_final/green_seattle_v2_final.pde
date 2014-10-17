// RJ DURAN
// DATA VISUALIZATION 
// MAT259 - WINTER 2012
// PROJECT 2: HOW GREEN IS SEATTLE?
// 2/19/2012
// RJDURANJR@GMAIL.COM / RJDURAN.NET

Grid grid;
boolean showGrid = false;
boolean showMousePosition = false;

float hSquareSize;
float vSquareSize;
float padding;

DataTable dataset;
Legend legend;
BiVariate lineGraph;

String[] categories = {
  "Conservation", "Economic", "Political", "Social", "Sustainability", "Science", "Technology"
};

String[] months = {
  "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
};

int[] daysInMonth  = {
  31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
};

int currentMonth;
int currentYear;
int currentCategory;

PFont infoFont;
boolean showInfo = true;
boolean flipColor = true;

color whitebg;
color bgcolor;

color lightText1;
color lightText2;
color infoText;

color linesHeavy;
color linesLight;
color axesText;
color headerLine;
color legendLight;
color legendSelected;
color colorLabel;
color headerTitle;
color hoverColor;
color zeroCheckoutsColor;

int darkRangeLowH, darkRangeHighH, brightRange, satRange, lightRangeHighH, lightRangeLowH;

boolean toggleControls = true;

void setup() {
  size(1280, 800);
  grid = new Grid(width, height, 8, 8, 10); // w, h, hzd, vtd, padding
  colorMode(HSB, 360, 100, 100, 100); 
  smooth();

  hSquareSize = grid.getHSize();
  vSquareSize = grid.getVSize();
  padding = grid.getPadding();

  infoFont = createFont("HoeflerText-Regular", 10);

  // pull data in
  dataset = new DataTable("2011DataForYear.txt");

  drawDark();  

  legend = new Legend(padding, vSquareSize + padding, hSquareSize - 2*padding, 6*vSquareSize - 4*padding, categories);
  lineGraph = new BiVariate(hSquareSize + padding, vSquareSize + padding, 6*hSquareSize - 2*padding, 6*vSquareSize - 4*padding, dataset);

  currentMonth = 0;
  currentYear = 2011;
  currentCategory = 0;
}

void draw() {
  background(bgcolor); // dark

  if (showGrid) { 
    grid.displayGrid();
  }
  if (showMousePosition) { 
    grid.displayMousePosition();
  }

  // main title
  fill(lightText1);  
  textAlign(LEFT, TOP);
  textSize(35);
  text("HOW GREEN IS SEATTLE?", padding, padding);

  // month and year header
  fill(lightText1);
  textAlign(RIGHT, TOP);
  textSize(35);

  text(months[currentMonth].toUpperCase() + " 2011", width - (hSquareSize+padding), padding);

  if (showInfo) {
    // info label
    textFont(infoFont);      
    fill(infoText);    

    textAlign(LEFT, BOTTOM);
    text("RJ DURAN\nDATA VISUALIZATION\nMAT259 - WINTER 2012", padding, height-padding);
  }

  setColors();

  // insert draw code here  
  legend.update(currentCategory);
  legend.display();

  lineGraph.update(currentMonth, currentYear, currentCategory);
  lineGraph.display();
}

void setColors() {
  // dark to light
  if (flipColor) { 
    drawDark();
  } 
  else {
    drawLight();
  }
}

void drawDark() {

  bgcolor = color(219, 6, 30); // dark grey background

  lightText1 = color(0, 0, 100); // white
  lightText2 = color(0, 0, 100); // white
  infoText = color(227, 3, 80); // dark grey
  headerTitle = color(227, 3, 80);

  linesHeavy = color(227, 3, 80, 50);
  linesLight = color(227, 3, 80, 30);
  axesText = color(227, 3, 80);  
  headerLine = color(227, 3, 61);
  legendLight = color(227, 3, 80, 30);
  legendSelected = color(227, 3, 100);
  colorLabel = color(227, 3, 80);
  hoverColor = color(0, 0, 100);
  zeroCheckoutsColor = color(0, 0, 40, 30);

  darkRangeLowH = 250;
  darkRangeHighH = 50;

  satRange = 71;
  brightRange = 100;
}

void drawLight() {

  bgcolor = color(0, 0, 100); // white background

  lightText1 = color(0); // black
  lightText2 = color(0); // black
  infoText = color(20); // grey
  headerTitle = color(0);

  linesHeavy = color(0, 0, 20, 50);
  linesLight = color(0, 0, 20, 30);
  axesText = color(0, 0, 0);  
  headerLine = color(0, 0, 0);
  legendLight = color(0, 0, 20, 30);
  legendSelected = color(0, 0, 0);
  colorLabel = color(0, 0, 0);
  hoverColor = color(0);    
  zeroCheckoutsColor = color(0, 0, 100, 0);

  darkRangeLowH = 250;
  darkRangeHighH = 50; 

  lightRangeLowH = 140;
  lightRangeHighH = 224;

  satRange = 71;
  brightRange = 100;
}

