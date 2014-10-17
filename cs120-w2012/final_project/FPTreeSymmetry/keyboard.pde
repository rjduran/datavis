void keyPressed() 
{
  // camera actions
  // reset position / top view
  if (key == '0') 
  {    
    cam.reset(300); 

    xRotationTarget = 0;
    yRotationTarget = 0;
    zRotationTarget = 0;

    // reset everything
    spread = 1.8;
    masterRotation = 0.0;
    nodeSpacing = 560;
    rootDistance = 500;
    camRotationRate = 0.01;

    // reset controllers
    Controller c = controlP5.controller("MASTER ROTATION");
    c.setValue(masterRotation);

    c = controlP5.controller("NODE SPACING");
    c.setValue(nodeSpacing);

    c = controlP5.controller("ROOT DISTANCE");
    c.setValue(rootDistance);

    c = controlP5.controller("BRANCH SPREAD");
    c.setValue(spread);

    c = controlP5.controller("ROTATION SPEED");
    c.setValue(camRotationRate);
  }

  // display modes
  if (key == '1') 
  {
    displayMode = 1;

    cam.lookAt(0, 0, 0, 300);    

    xRotationTarget = -PI/4;
    yRotationTarget = 0; 
    zRotationTarget = 0;
  } 

  if (key == '2') 
  {
    displayMode = 2;

    cam.lookAt(0, 0, -1000, 300);    

    xRotationTarget = -PI/2;
    yRotationTarget = 0; 
    zRotationTarget = 0;
  } 

  if (key == '3') 
  {
    displayMode = 3;

    cam.lookAt(0, 0, 0, 300);    

    xRotationTarget = 0;
    yRotationTarget = 0; 
    zRotationTarget = 0;
  } 

  if (key == '4') 
  {
    displayMode = 4;

    cam.lookAt(0, 0, 0, 300);    

    xRotationTarget = 0;
    yRotationTarget = 0; 
    zRotationTarget = 0;
  } 

  if (key == '5') 
  {
    displayMode = 5;

    cam.lookAt(0, 0, -1000, 300);    

    xRotationTarget = -PI/2;
    yRotationTarget = 0; 
    zRotationTarget = 0;
  } 

  if (key == '6') 
  {
    displayMode = 6;

    cam.lookAt(0, 0, 0, 300);    

    xRotationTarget = -PI/4;
    yRotationTarget = 0; 
    zRotationTarget = 0;
  }   

  // side view
  if (key == '7') 
  {
    cam.reset(300); // reset in 1 sec

    xRotationTarget = -PI/2;
    yRotationTarget = 0;
    zRotationTarget = 0;
  }  

  // random tree view
  if (key == '8') 
  {
    cam.lookAt(random(-200.0, 200.0), 0, random(-1300.0, 0.0), 300);    

    xRotationTarget = -PI/2;
    yRotationTarget = PI; // spins to other side of tree
    zRotationTarget = 0;
  }  

  // rotate around 
  if (key == '9') 
  {
    rotateCam = !rotateCam;
  }  


  // save image
  if (key == 's') 
  {
    saveFrame(getClass().getName() + "-####.png");
    println("File Saved");
  }

  // hide/show HUD
  if (key == 'h') 
  {
    displayHUD = !displayHUD;
  }

  // hide/show grid
  if (key == 'g') 
  {
    displayGrid = !displayGrid;
  } 

  // hide/show connecting lines
  if (key == 'l') 
  {
    displayLines = !displayLines;
  }  

  // hide/show pyramids
  if (key == 'p') 
  {
    displayPyramids = !displayPyramids;
  }  

  // variance control
  if (key == 'v') 
  {
    varianceEnabled = !varianceEnabled;
  }


  // rotations
  /*
  // replaced by slider0
   if (key == ',') 
   {
   masterRotation -= 0.1;
   }
   if (key == '.') 
   {
   masterRotation += 0.1;
   }
   
   */

  // modifications
  /*
  if (key == ']') 
   {
   nodeSpacing +=20;
   println("nodeSpacing: "+ nodeSpacing);
   } 
   
   if (key == '[') 
   {
   nodeSpacing -=20;
   println("nodeSpacing: "+ nodeSpacing);
   }
   */

  /*
  // increase root distance
   if (key == ';') 
   {
   rootDistance +=20;
   println("rootDistance: "+ rootDistance);
   }
   
   if (key == '\'') 
   {
   rootDistance -=20;
   println("rootDistance: "+ rootDistance);
   }
   */




  /*
  if (key == 'i') 
   {
   spread += 0.1;
   println("spread: " + spread);
   }
   
   if (key == 'o') 
   {
   spread -= 0.1;
   println("spread: " + spread);
   }  
   */

  // reset spread
  if (key == 'u') 
  {
    spread = 1.8;
    println("spread: " + spread);
  }  

  // hide/show GUI bar
  if (key == 'd') 
  {
    displayGUI = !displayGUI;
  }




  // calculate new minimum support
  /*
  if (key == '-') 
   {
   if (minimumSupport <= 1200) 
   {
   minimumSupport = 1200;  // lower limit
   } 
   else {
   minimumSupport -= 100;
   //calculate();
   }
   }
   if (key == '=') 
   {
   if (minimumSupport >= 2000) 
   {
   minimumSupport = 2000;  // upper limit
   } 
   else {
   minimumSupport += 100;
   //calculate();
   }
   }
   */
}

