class Pyramid 
{
  float x, y, z;
  float r; // distance from center
  float val; // height = data value
  float theta; // cw angle from 0 deg
  color c;

  Pyramid()
  {
    x = 0;
    y = 0;
    z = 0;
    r = 0;
    theta = 0;
    val = 0;
    c = color(pyramidColor);
  }

  Pyramid(float val)
  {
    x = 0;
    y = 0;
    z = 0;
    r = 0;
    theta = 0;
    this.val = val;
  } 

  Pyramid(float r, float theta, float val)
  {
    this.r = r;
    this.theta = theta;
    this.val = val;
  }

  // update all values
  void update(float r, float theta, float val)
  {
    this.r = r;
    this.theta = theta;
    this.val = val;
  }

  // update radius only
  void setRadius(float r)
  {
    this.r = r;
  }

  // update radius and theta
  void setPosition(float r, float theta)
  {
    this.r = r;
    this.theta = theta;
  }

  // update data only
  void setValue(float val)
  {
    this.val = val;
  }


  void display()
  {
    float rx, ry;

    stroke(c, 100); 
    strokeWeight(2); 

    pushMatrix();
    x = (r * cos(radians(theta)));
    y = (r * sin(radians(theta)));
    z = map(val, 0, 10000, 0, 500); // map height

      translate(x, y); // define new center point for pyramid at x,y,z

    float rt = sqrt(val); // map the val to pyramid radius

    for (int i = 0; i < 3; i++) 
    {
      fill(c, 65);
      beginShape(TRIANGLES);
      vertex(0, 0, z);
      rx = rt * cos(radians(0));
      ry = rt * sin(radians(0));
      vertex(rx, ry, 0);
      rx = rt * cos(radians(DEG*8));
      ry = rt * sin(radians(DEG*8));
      vertex(rx, ry, 0);
      endShape();

      rotate(radians(DEG*8)); // rotate by 120 deg
    }
    popMatrix();
  }

  void setColor(color qc) 
  {
    c = qc;
  }
}

