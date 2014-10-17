void keyPressed() {  
  //press g to toggle the grid on and off  
  if (key == 'g') {
    //showGrid = !showGrid;
  }

  if (key == 'l') {
    //showMousePosition = !showMousePosition;
  }

  // save screenshot
  if (key == 's') {
    saveFrame(getClass().getName() + "-####.png");
    println("File Saved");
  }

  if (key == 'i') {
    showInfo = !showInfo;
  }

}

