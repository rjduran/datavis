/**************************************************
 RJ DURAN
 DATA VISUALIZATION 
 MAT259 - WINTER 2012
 PROJECT 4: WATER + FPTREE
 3/17/2012
 RJDURANJR@GMAIL.COM / RJDURAN.NET
 **************************************************/

import processing.opengl.*;
import javax.media.opengl.*;
import peasy.*;
import peasy.org.apache.commons.math.*;
import controlP5.*;
import codeanticode.glgraphics.*;

void setup()
{
  ///Set up Canvas 
  //  size(1280, 800, GLConstants.GLGRAPHICS);       
  size(screen.width, screen.height, GLConstants.GLGRAPHICS);       
  hint(DISABLE_OPENGL_2X_SMOOTH);
  hint(ENABLE_OPENGL_4X_SMOOTH); 

  smooth();
  colorMode(HSB, 360, 100, 100, 100);
  frameRate(60);
  setupColor();

  offScreen = createGraphics(500, 200, P2D);

  loadData(); // load fp data

    EPICENTER_X = 0; // center of grid
  EPICENTER_Y = 0;  

  cam = new PeasyCam(this, 0, 0, 0, 2400);
  cam.setMinimumDistance(1);
  cam.setMaximumDistance(5000);

  // give nodes a variable display to declutter
  variance = new float[nTransactions];
  varianceIntegrator = new Integrator[nTransactions];

  for (int i = 0; i < variance.length; i++) 
  {
    variance[i] = random(-100, 100); //random positioning
    varianceIntegrator[i] = new Integrator(variance[i], 0.3, 0.8);
  }

  idx = 0; // variance index  

  g3 = (PGraphics3D)g;
  slide = new Integrator(-80, 0.3, 0.8);
  setupGUI();
}


/**************************************************/
// draw
/**************************************************/
void draw() 
{
  background(bgColor); 
  slide.update();

  for (int i = 0; i < varianceIntegrator.length; i++) 
  {
    varianceIntegrator[i].update();
  }  

  // draw GUI
  if (displayGUI) 
  {
    //this moves the interface up and down
    if ((mouseY > 1) && (mouseY < 40)) // as long as the mouse gets within 60 from the top, open GUI
    {
      slide.target(0);
      lockGUI = true;
      cam.setActive(false); // disable peasycam while gui is open
    } 
    else if (mouseY > 100) {
      slide.target(-80);
      cam.setActive(true);
    }

    if (lockGUI == false)
    {
      slide.target(-80);
    }

    // set position of gui panel
    if (l.position().y != slide.value)
    {
      l.position().y = slide.value;
    }
  }


  // peasy cam  
  peasyCamPosition = cam.getPosition(); // get position
  rotations = cam.getRotations(); // get rotations

    if (rotateCam) 
  {
    // constant rotation
    cam.rotateY(camRotationRate);

    float[] rot = cam.getRotations(); // get rotations
    xRotation = rot[0];
    yRotation = rot[1];
    zRotation = rot[2];
    xRotationTarget = rot[0];
    yRotationTarget = rot[1];
    zRotationTarget = rot[2];
  } 
  else {
    float f = 10.0; // the higher the value, the slower it rotates
    xRotation = xRotation + ((xRotationTarget-xRotation)/f);
    yRotation = yRotation + ((yRotationTarget-yRotation)/f);
    zRotation = zRotation + ((zRotationTarget-zRotation)/f);

    // if mouse pressed, stop setting rotations
    if (!mousePressed) 
    { 
      cam.setRotations(xRotation, yRotation, zRotation);
    }
  }

  //use HUD to write stuff that is stationary in relation to the camera
  if (displayHUD) 
  {
    cam.beginHUD();

    // Active Dataset 
    fill(hudTextColor);
    textAlign(RIGHT, BOTTOM);
    textFont(font);  
    textSize(40);
    text("WATER", width-10, height);

    // display framerate
    //    fill(hudTextColor);
    //    textAlign(LEFT, BOTTOM);
    //    textFont(font);  
    //    textSize(14);
    //    text(frameRate, 2, height-2);

    cam.endHUD();
  }

  idx = 0; // idx for variance

  // draw everything else
  if (displayGrid) 
  {
    drawPolarGrid();
    //drawPolarPlot();
  }

  drawData();

  if (displayGUI)
  {
    drawGUI();
  }
}


void drawData()
{   
  //(Node t, int wide, int deep, int siblings, float currentRotation)
  // first node, number of levels out, depth of this branch, number of siblings
  fp.graphViz(fp.root, 0, 1, fp.root.child.size(), 0.0);   // lines
  fp.graphViz2(fp.root, 0, 1, fp.root.child.size(), 0.0);  // pyramids
}

