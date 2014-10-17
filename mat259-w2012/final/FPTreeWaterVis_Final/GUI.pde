// gui group
ControlGroup l;

// info labels
Textlabel guiTitleLabel;
Textlabel infoLabel;
Textlabel modeLabel;
Textlabel controlLabel;
Textlabel paramLabel;

// elements
Slider paramSlider0;
Slider paramSlider1;
Slider paramSlider2;
Slider paramSlider3;
Slider paramSlider4;

// info text
String author = "RJ DURAN";
String title = "WATER";
String course = "DATA VISUALIZATION";
String courseInfo = "MAT259 - WINTER 2012";
String guiTitle = "INFORMATION";

// gui element colors
color c0, c1, c2;
color guiBgColor;

int tc0 = #000000; // black text 
int tc1 = #FFFFFF; // white text

void setupGUI()
{

  c0 = color(50.04608, 87.85425, 96.86275); // item hover/drag/selected - active
  c1 = color(0, 0, 100);                    // item background
  c2 = color(50.847458, 86.7647, 80.0);     // item - inactive
  guiBgColor = color(0, 0, 100, 25);

  g3 = (PGraphics3D)g;  

  //interface functions:   
  controlP5 = new ControlP5(this);

  // color for sliders and other elements
  controlP5.setColorActive(c0);
  controlP5.setColorBackground(c1);
  controlP5.setColorForeground(c2);      
  controlP5.setColorLabel(tc1);
  controlP5.setColorValue(tc1);

  // group settings
  l = controlP5.addGroup("", 0, 0, width);
  l.activateEvent(true);
  l.hideBar(); // hide default control bar
  l.setBackgroundColor(guiBgColor); // gui bg color
  l.setBackgroundHeight(100); // set default bg height

  // gui title label
  guiTitleLabel = controlP5.addTextlabel("guiTitleLabel", guiTitle, 5, 87);
  guiTitleLabel.setColorValue(tc1);
  guiTitleLabel.setGroup(l); 

  // coordinates
  int infoY = 5;
  int infoX = width-120;

  // info labels
  infoLabel = controlP5.addTextlabel("author", author, width-53, infoY);
  infoLabel.setColorValue(tc1);
  infoLabel.setGroup(l);    
  infoY+=15;

  infoLabel = controlP5.addTextlabel("course", course, width-100, infoY);
  infoLabel.setColorValue(tc1);
  infoLabel.setGroup(l);    
  infoY+=15;

  infoLabel = controlP5.addTextlabel("courseInfo", courseInfo, width-118, infoY);
  infoLabel.setColorValue(tc1);
  infoLabel.setGroup(l);    
  infoY+=15;


  //////////////////////////////////////////////////////////////////////////////////////////
  // DISPLAY MODES
  //////////////////////////////////////////////////////////////////////////////////////////
  infoY = 5;
  infoX = 5;

  modeLabel = controlP5.addTextlabel("infoDisplayModesAll", "PRESS '1 - 9' FOR DISPLAY MODES", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);      
  infoY+=15; 

  modeLabel = controlP5.addTextlabel("infoDisplayMode0", "0: RESET", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);      
  infoY+=15;

  modeLabel = controlP5.addTextlabel("infoDisplayMode1", "1: OVERVIEW", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);      
  infoY+=15;

  modeLabel = controlP5.addTextlabel("infoDisplayMode2", "2: EXPANDED VIEW", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);      
  infoY+=15; 

  modeLabel = controlP5.addTextlabel("infoDisplayMode3", "3: FP TREE 1", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);      

  infoX+=120;
  infoY=20;  

  modeLabel = controlP5.addTextlabel("infoDisplayMode4", "4: PYRAMID OVERLAY", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);  
  infoY+=15; 

  modeLabel = controlP5.addTextlabel("infoDisplayMode5", "5: FP TREE 2", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);      
  infoY+=15; 

  modeLabel = controlP5.addTextlabel("infoDisplayMode6", "6: PYRAMIDS", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);      
  infoY+=15; 

  modeLabel = controlP5.addTextlabel("infoDisplayMode7", "7: SIDE VIEW", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);        

  infoX+=120;
  infoY=20; 

  modeLabel = controlP5.addTextlabel("infoDisplayMode8", "8: RANDOM VIEW", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);      
  infoY+=15;

  modeLabel = controlP5.addTextlabel("infoDisplayMode9", "9: TOGGLE ROTATION", infoX, infoY);
  modeLabel.setColorValue(tc1);
  modeLabel.setGroup(l);       


  //////////////////////////////////////////////////////////////////////////////////////////
  // CONTROL PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////
  infoX+=140;
  infoY=5; 

  controlLabel = controlP5.addTextlabel("infoControlAll", "CONTROL PARAMETERS", infoX, infoY);
  controlLabel.setColorValue(tc1);
  controlLabel.setGroup(l);      
  infoY+=15; 

  controlLabel = controlP5.addTextlabel("infoControl1", "G: HIDE/SHOW GRID", infoX, infoY);
  controlLabel.setColorValue(tc1);
  controlLabel.setGroup(l);      
  infoY+=15; 

  controlLabel = controlP5.addTextlabel("infoControl2", "L: HIDE/SHOW LINES", infoX, infoY);
  controlLabel.setColorValue(tc1);
  controlLabel.setGroup(l);      
  infoY+=15; 

  controlLabel = controlP5.addTextlabel("infoControl3", "P: HIDE/SHOW PYRAMIDS", infoX, infoY);
  controlLabel.setColorValue(tc1);
  controlLabel.setGroup(l);      
  infoY+=15; 

  controlLabel = controlP5.addTextlabel("infoControl4", "V: TOGGLE VARIANCE", infoX, infoY);
  controlLabel.setColorValue(tc1);
  controlLabel.setGroup(l);      


  //////////////////////////////////////////////////////////////////////////////////////////
  // FPTREE PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////
  infoX+=140;
  infoY=5; 

  paramLabel = controlP5.addTextlabel("infoParamSlidersAll", "PARAMETERS", infoX, infoY);
  paramLabel.setColorValue(tc1);
  paramLabel.setGroup(l);      
  infoY+=15; 

  paramSlider0 = controlP5.addSlider("MASTER ROTATION", -PI, PI, 0.0, infoX, infoY, 120, 15); 
  paramSlider0.setGroup(l); 
  paramSlider0.setId(0);  
  infoY+=20; 

  paramSlider1 = controlP5.addSlider("NODE SPACING", 250, 800, 560.0, infoX, infoY, 120, 15); 
  paramSlider1.setGroup(l); 
  paramSlider1.setId(1);  
  infoY+=20;  

  paramSlider2 = controlP5.addSlider("ROOT DISTANCE", 100, 900, 500.0, infoX, infoY, 120, 15); 
  paramSlider2.setGroup(l); 
  paramSlider2.setId(2);  


  infoX+=220;
  infoY=20; 

  paramSlider3 = controlP5.addSlider("BRANCH SPREAD", -3.0, 3.0, 1.8, infoX, infoY, 120, 15); 
  paramSlider3.setGroup(l); 
  paramSlider3.setId(3);  
  infoY+=20; 

  paramSlider4 = controlP5.addSlider("ROTATION SPEED", 0.005, 0.09, 0.01, infoX, infoY, 120, 15); 
  paramSlider4.setGroup(l); 
  paramSlider4.setId(4);  
  infoY+=20;   

  // auto draw false
  controlP5.setAutoDraw(false);
}

void drawGUI() 
{
  currCameraMatrix = new PMatrix3D(g3.camera);
  camera();
  controlP5.draw();
  g3.camera = currCameraMatrix;
}

void controlEvent(ControlEvent theEvent) 
{
  //  println("got a control event from controller with id "+theEvent.controller().id());
  switch(theEvent.controller().id()) 
  {
    case(0):
    masterRotation = (float)(theEvent.controller().value());
    break;

    case(1):
    nodeSpacing = (float)(theEvent.controller().value());
    break;

    case(2):
    rootDistance = (float)(theEvent.controller().value());
    break;

    case(3):
    spread = (float)(theEvent.controller().value());
    break;

    case(4):
    camRotationRate = (float)(theEvent.controller().value());
    break;
  }
}

