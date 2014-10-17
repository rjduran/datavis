void drawPolarGrid() 
{
  float rx, ry;
  stroke(0, 0, 100, 35); 
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
  fill(213, 86, 99, 40); // lt blue
//  fill(348, 86, 99, 40);   
  rectMode(CENTER);
  pushMatrix(); 
  translate(0, 0, 0);
  ellipse(0, 0, 2500, 2500);
  popMatrix();
}
