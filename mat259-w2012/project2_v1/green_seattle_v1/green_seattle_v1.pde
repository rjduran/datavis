boolean showGrid = false;
boolean showMousePosition = false;

float hSquareSize;
float vSquareSize;
float padding;

Grid grid;

ItemDataTable dataset0;
DataTable dataset1;

BarGraph barGraph;
Legend legend;
ItemBox itemBox;
LineGraph lineGraph;
TimelineGraph timelineGraph;
MiscBox miscBox;

// test
YearSelector yearSelector;

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
int monthIdx = 0;

PFont infoFont;
boolean showInfo = true;

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
  dataset0 = new ItemDataTable("2011data.txt");
  dataset1 = new DataTable("checkouts_per_day_2011data.txt");    

  catColors = new color[7];

  catColors[0] = color(91, 99, 91);
  catColors[1] = color(190, 96, 61);
  catColors[2] = color(54, 99, 99);
  catColors[3] = color(81, 99, 59);
  catColors[4] = color(163, 99, 42);
  catColors[5] = color(162, 54, 81);
  catColors[6] = color(54, 54, 99); 


  // using dataset0
  legend = new Legend(padding, vSquareSize + padding, hSquareSize - 2*padding, 2*hSquareSize - 4*padding, categories);
  legend.setColors(catColors);

  barGraph = new BarGraph(hSquareSize + padding, vSquareSize + padding, 3*hSquareSize - 2*padding, 3*vSquareSize - 2*padding, dataset0);
  barGraph.setColors(catColors);

  itemBox = new ItemBox(4*hSquareSize + padding, vSquareSize + padding, 3*hSquareSize - 2*padding, 3*vSquareSize - 2*padding, dataset0); // popular titles
  itemBox.setColors(catColors);

  // using dataset1
  lineGraph = new LineGraph(hSquareSize + padding, 4*vSquareSize + padding, 3*hSquareSize - 2*padding, 2*vSquareSize - 4*padding, dataset1);
  timelineGraph = new TimelineGraph(hSquareSize + padding, 6*vSquareSize +padding, 6*hSquareSize - 2*padding, 2*vSquareSize - 2*padding, dataset1);

  miscBox = new MiscBox(4*hSquareSize + padding, 4*vSquareSize + padding, 3*hSquareSize - 2*padding, 2*vSquareSize - 2*padding, dataset1); // popular titles
  miscBox.setColors(catColors);

  //yearSelector = new YearSelector(padding, 4*vSquareSize + padding, hSquareSize - 2*padding, 2*hSquareSize - 4*padding); // left side
  //yearSelector = new YearSelector(7*hSquareSize + padding, vSquareSize + padding, hSquareSize - 2*padding, 2*hSquareSize - 4*padding); // right side

  currentMonth = 0;
  currentYear = 2011;
}

void draw() {
  background(219, 6, 30); // dark
  //  background(0, 0, 98); // off white
  //  background(149, 2, 92);
  if (showGrid) { 
    grid.displayGrid();
  }
  if (showMousePosition) { 
    grid.displayMousePosition();
  }

  // main title
  fill(0, 0, 100);
  textAlign(LEFT, TOP);
  textSize(35);
  text("HOW GREEN IS SEATTLE?", padding, padding);

  // month and year header
  fill(0, 0, 100);
  textAlign(RIGHT, TOP);
  textSize(35);

  // bug here with counter if using both keyboard and mouse. fix later
  text(months[currentMonth].toUpperCase() + " 2011", width - (hSquareSize+padding), padding);

  if (showInfo) {
    // info label
    textFont(infoFont);  
    fill(227, 3, 70);    
    textAlign(LEFT, BOTTOM);
    text("RJ DURAN\nDATA VISUALIZATION\nMAT259 - WINTER 2012", padding, height-padding);
  }

  // insert draw code here  
  barGraph.display();  
  legend.display();
  itemBox.display(); 
  lineGraph.display();
  timelineGraph.display();

  miscBox.update();
  miscBox.display();

  //yearSelector.display();
}

