/**************************************************/
// Global Variables
/**************************************************/

// This helps with overlaying GUI + peasycam
PMatrix3D currCameraMatrix;
PGraphics3D g3; 
Integrator slide; 
ControlP5 controlP5;

boolean displayGUI = true;
boolean lockGUI = true;
public int myColorRect = 200;

// fonts
PFont fpFont = createFont("Consolas", 10);
PFont font = createFont("Consolas", 125);


// Peasy cam & visual effects
PeasyCam cam; 
boolean displayHUD = true;


boolean rotateCam = false;
float xRotation = 0;
float yRotation = 0;
float zRotation = 0;
float xRotationTarget = 0;
float yRotationTarget = 0;
float zRotationTarget = 0;

float[] rotations = new float[3];  // for billboarding
float[] peasyCamPosition;


// grid
int EPICENTER_X, EPICENTER_Y;
int DX = 100;             // individual ellipse radius
int RINGS = 24;           // number of rings to draw axes
float R = 100*RINGS*0.5;  // radius from center
int DEG = 15;             // grid angle segment size - theta (CW dir)
boolean displayGrid = true; 



// fp data
int minimumSupport = 500;
FP fp = new FP();
String transaction[];
//String filename = "simple.txt";
String filename = "spacetime.txt";
String[] ignoreString = {
  "the", "in", "on", "at", "of", "a", "and", "an", "to", "by", "for", "spacetime", "spacetimes"
};

// fp data display
int displayMode = 1;
boolean displayLines = true;
boolean displayPyramids = true;

// elements
float[] variance;
Integrator[] varianceIntegrator;
int idx;
int nTransactions;
boolean varianceEnabled = false;

// colors
color bgColor;
color treeColor, nodeColor, labelColor, pyramidColor;


// keyboard vars / controlP5 params
float masterRotation = 0.0;
float nodeSpacing = 560;
float rootDistance = 500;
float camRotationRate = 0.01;
float spread = 1.8;

