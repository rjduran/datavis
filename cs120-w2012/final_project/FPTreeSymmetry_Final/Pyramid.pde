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
    x = (r * cos(radians(theta)));// - map(val, 0, 10000, mouseX, 0);
    y = (r * sin(radians(theta)));// - map(val, 0, 10000, mouseX, 0);
    z = val; // map 0->10000 TO 0->-1000


      translate(x, y); // define new center point for pyramid at x,y,z

    float rt = sqrt(2*val); // map the val to pyramid radius

    // Style 1: Wireframe 3 legged pyramid
    // 3 point pyramid  
    /*    for (int i = 0; i < 3; i++) 
     {
     noFill();
     beginShape();
     vertex(0, 0, map(val, 0, 10000, 1, 300)); // vertex 0 center
     rx = rt * cos(radians(DEG*8*i));
     ry = rt * sin(radians(DEG*8*i));
     vertex(rx, ry, 0); // vertex 1
     endShape();
     }
     */
    // Style 2: Filled 3 sided
    // this draws a pyramid with filled sides
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

    //pushMatrix();
    // draw label  
    //    rotate(-PI/2);
    //    rotateX(-PI/2); // rotate vertically
    //
    //    fill(0, 0, 100);
    //    textAlign(CENTER, CENTER);
    //    textFont(font);
    //    textSize(15);  
    //    text(int(val), 0, -z-15, 0);

    //popMatrix();



    popMatrix();
  }

  void setColor(color qc) 
  {
    c = qc;
  }
}

