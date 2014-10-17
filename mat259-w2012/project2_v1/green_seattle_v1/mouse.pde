void mousePressed() {
}

void mouseMoved() {
}

void mouseClicked() {

  // draw buttons
  for (int i = 0; i < timelineGraph.getNDivisions(); i++) {
    if (timelineGraph.monthSelector[i].isOver()) {
      currentMonth = i;
      timelineGraph.setCurrentMonth(currentMonth);
      lineGraph.setCurrentMonth(currentMonth+1); 
      barGraph.setCurrentMonth(currentMonth+1); 
      itemBox.setCurrentMonth(currentMonth+1);
      miscBox.setCurrentMonth(currentMonth+1);
      if(currentMonth > monthIdx) {
      monthIdx++;
      } else {
       monthIdx--; 
      }
    }
  }
}

void mouseReleased() {
}

