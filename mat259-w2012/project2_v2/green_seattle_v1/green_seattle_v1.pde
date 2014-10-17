boolean showGrid = false;
boolean showMousePosition = false;

float hSquareSize;
float vSquareSize;
float padding;

Grid grid;

//ItemDataTable dataset0;
DataTable dataset;

Legend legend;
LineGraph lineGraph;

// test
//YearSelector yearSelector;

color[] catColors;

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

color whitebg;
color darkbg;

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
boolean toggleControls = true;

void setup() {
  size(1280, 800);
  grid = new Grid(width, height, 8, 8, 10); // w, h, hzd, vtd, padding
  colorMode(HSB, 360, 100, 100, 100); 
  smooth();

  hSquareSize = grid.getHSize();
  vSquareSize = grid.getVSize();
  padding = grid.getPadding();

  infoFont = createFont("HoeflerText-Regular", 9);

  // pull in data from text files
  //  dataset0 = new ItemDataTable("2011data.txt");
  //  dataset1 = new DataTable("checkouts_per_day_2011data.txt"); 
  dataset = new DataTable("2011DataForYear.txt");

  //  catColors = new color[7];
  //
  //  catColors[0] = color(91, 99, 91);
  //  catColors[1] = color(190, 96, 61);
  //  catColors[2] = color(54, 99, 99);
  //  catColors[3] = color(81, 99, 59);
  //  catColors[4] = color(163, 99, 42);
  //  catColors[5] = color(162, 54, 81);
  //  catColors[6] = color(54, 54, 99); 

  whitebg = color(0, 0, 100); // white
  darkbg = color(219, 6, 30); // dark grey background

  lightText1 = color(0, 0, 100); // white
  lightText2 = color(0, 0, 100); // white
  infoText = color(227, 3, 80); // dark grey

  linesHeavy = color(227, 3, 80, 50);
  linesLight = color(227, 3, 80, 30);
  axesText = color(227, 3, 80);  
  headerLine = color(227, 3, 61);
  legendLight = color(227, 3, 80, 30);
  legendSelected = color(227, 3, 100);
  colorLabel = color(227, 3, 80);
  
  // using dataset0
  legend = new Legend(padding, vSquareSize + padding, hSquareSize - 2*padding, 6*vSquareSize - 4*padding, categories);
  //legend.setColors(catColors);

  // using dataset1
  lineGraph = new LineGraph(hSquareSize + padding, vSquareSize + padding, 6*hSquareSize - 2*padding, 6*vSquareSize - 4*padding, dataset);

  currentMonth = 0;
  currentYear = 2011;
  currentCategory = 0;
}

void draw() {
  background(darkbg); // dark
  //background(lightbg); // white

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
  
//  textSize(11);
//  text("[ / ] : +/- Year", padding, padding+40);

  // month and year header
  fill(lightText1);
  textAlign(RIGHT, TOP);
  textSize(35);

  // bug here with counter if using both keyboard and mouse. fix later
  text(months[currentMonth].toUpperCase() + " 2011", width - (hSquareSize+padding), padding);

  if (showInfo) {
    // info label
    textFont(infoFont);      
    fill(infoText);    

    textAlign(LEFT, BOTTOM);
    text("RJ DURAN\nDATA VISUALIZATION\nMAT259 - WINTER 2012", padding, height-padding);
  }

  // insert draw code here  
  legend.update(currentCategory);
  legend.display();

  lineGraph.update(currentMonth, currentYear, currentCategory);
  lineGraph.display();
}

