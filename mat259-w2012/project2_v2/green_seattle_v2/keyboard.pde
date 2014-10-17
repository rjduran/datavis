// Quick File Save Function
void keyPressed() {  
  //press spacebar to toggle the grid on and off  
  if (key == 'g') {
    showGrid = !showGrid;
  }

//  if (key == 'l') {
//    showMousePosition = !showMousePosition;
//  }

  if (key == 's') {
    saveFrame(getClass().getName() + "-####.png");
    println("File Saved");
  }

  if (key == 'i') {
    showInfo = !showInfo;
  }

  // category control
  if (key == '[') {
    currentCategory--;
    if (currentCategory < 0) {
      currentCategory = 6;
    }
  } 
  
  if (key == ']') {
    currentCategory++;
    if (currentCategory > 6) {
      currentCategory = 0;
    }
  }
  
  // month control
  if (key == 'n') {
    currentMonth--;
    if (currentMonth < 0) {
      currentMonth = 11;
    }
  } 
  
  if (key == 'm') {
    currentMonth++;
    if (currentMonth > 11) {
      currentMonth = 0;
    }
  }  
  
  if(key == 't') {
    toggleControls = !toggleControls;
  }
  
  if(key == 'f') {
    flipColor = !flipColor;
  }
  
  
}

