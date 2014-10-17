void drawPolarGrid() 
{
  float rx, ry;
  stroke(polarGridColor); 
  strokeWeight(1);
  noFill(); 

  for (int i = 0; i < 360/DEG; i++) 
  {
    ellipse(EPICENTER_X, EPICENTER_Y, DX*i, DX*i);

    rx = R * cos(radians(DEG*i));
    ry = R * sin(radians(DEG*i));    

    line(EPICENTER_X, EPICENTER_Y, rx, ry);
  }
  ellipse(EPICENTER_X, EPICENTER_Y, 2400, 2400);
}

void drawPolarPlot()
{
  noStroke();
  fill(polarPlotColor);   
  rectMode(CENTER);
  pushMatrix(); 
  translate(0, 0, 0);
  ellipse(0, 0, 2500, 2500);
  popMatrix();
}
