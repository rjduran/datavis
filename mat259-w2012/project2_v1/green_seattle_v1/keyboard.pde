// Quick File Save Function
void keyPressed() {  
  //press spacebar to toggle the grid on and off  
  if (key == 'g') {
    showGrid = !showGrid;
  }

  if (key == 'm') {
    showMousePosition = !showMousePosition;
  }

  if (key == 's') {
    saveFrame(getClass().getName() + "-####.png");
    println("File Saved");
  }

  if (key == 'i') {
    showInfo = !showInfo;
  }


  //  if (key == '[') {
  //    currentMonth--;
  //    if (currentMonth < 1) {
  //      currentMonth = 12;
  //    }
  //    timelineGraph.setCurrentMonth(currentMonth-1);    
  //    lineGraph.setCurrentMonth(currentMonth);
  //    barGraph.setCurrentMonth(currentMonth);
  //    itemBox.setCurrentMonth(currentMonth);   
  //    miscBox.setCurrentMonth(currentMonth);
  //  } 
  //  else if (key == ']') {
  //    currentMonth++;
  //    if (currentMonth > 12) {
  //      currentMonth = 1;
  //    }
  //    timelineGraph.setCurrentMonth(currentMonth-1);    
  //    lineGraph.setCurrentMonth(currentMonth); 
  //    barGraph.setCurrentMonth(currentMonth);
  //    itemBox.setCurrentMonth(currentMonth);  
  //    miscBox.setCurrentMonth(currentMonth);
  //  }
}

