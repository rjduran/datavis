// RJ Duran
// rjduranjr@gmail.com / rjduran.net
// MAT259 Winter 2012 
// Data Visualization 
// Project 1: Top 10 DVD's checked out

String[] titles;
int[] totalCheckouts;
float theta;
float radius;
float x, y;
float centerX, centerY;

PFont itemFont;
boolean showInfo = false;

void setup() {
  size(1280, 800);
  colorMode(HSB, 360, 100, 100); 
  smooth(); 
  //itemFont = createFont("GothamMedium", 15);
  itemFont = loadFont("GothamMedium.vlw");

  titles = new String[10];
  totalCheckouts = new int[10];

  String savedData[] = loadStrings("savedData.txt");
  println("QUERY: " + savedData[0]);
  for (int i=1; i < savedData.length; i++) {

    String temp[] = split(savedData[i], ",");
    titles[i-1] = temp[0];
    totalCheckouts[i-1] = Integer.parseInt(temp[2]);
  }

  centerX = width/2;
  centerY = height/2;
}

void draw() {
  background(0, 0, 96);

  fill(0);
  textSize(30);
  textAlign(LEFT, TOP);    
  text("TOP 10 DVD'S\nCHECKED\nOUT IN 2011", 10, 10);

  fill(0);
  textSize(12);
  textAlign(CENTER, CENTER);
  text("#\nCHECKOUTS", 60, 160);

  stroke(0);
  noFill();
  ellipse(60, 160, 100, 100);

  radius = 50;
  theta = radians(map(mouseX, 0, width, -220, 220));

  float r = 0;

  for (int i=0; i < 10; i++) {
    // start at end of array since we grow out from center
    int idx = totalCheckouts.length-1; 

    r = map(sqrt(totalCheckouts[idx - i]), sqrt(totalCheckouts[idx]), sqrt(totalCheckouts[0]), 50, 220); 
    x = centerX - cos(theta) * radius;
    y = centerY + sin(theta) * radius;

    fill(0, 0, 0);
    noStroke();
    ellipse(x, y, r, r);
    
    // draw dvd title
    fill(20*i, 50, 80);
    textFont(itemFont);
    textSize(15);
    textAlign(RIGHT, CENTER);    
    text(titles[idx - i], x - (r/2) - 10, y-r/6);
    
    // draw total checkout numbers
    textSize(15);
    textAlign(CENTER, CENTER);    
    text(nfc(totalCheckouts[idx- i]), x, y);

    theta += 0.75;
    radius += 37;
  }

  if (showInfo) {
    fill(0);
    textSize(12);
    textAlign(LEFT, BOTTOM);    
    text("RJ DURAN\nDATA VISUALIZATION\nMAT259 WINTER 2012", 10, height-10);
  }
}

void keyPressed() {
  if ( key == 'i' ) { 
    showInfo = !showInfo;
  }

  if (key == 's') {
    saveFrame(getClass().getName() + "-####.png");
    println("File Saved");
  }
}

