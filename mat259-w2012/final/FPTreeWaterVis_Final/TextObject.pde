public class TextObject {
  PFont tFont = createFont("Consolas", 20); // FPTree Font
  String textString = "test";              //This is the text that is displayed for this object
  PVector pos = new PVector(0, 0, 0);          //x,y position
  GLTexture blitImage;                    //This is the GLTexture that gets rendered. GLTextures are subclasses of PImage, so can be used in the same way.
  color c;
  float alphaVal;

  TextObject(String t, color c) {
    textString = t; 
    this.c = c;    
    makeImage();
  };

  void makeImage() {
    //Here, we draw the text to the offscreen graphics object.
    offScreen.beginDraw();
    offScreen.colorMode(HSB, 360, 100, 100, 100);
    offScreen.background(c); // canvas bg
    offScreen.noStroke();
    offScreen.smooth();

    int w = ceil(offScreen.textWidth(textString))+8;
    int h = 24;

    // draw label background
    //offScreen.rectMode(CENTER);
    offScreen.fill(c); // white
    offScreen.rect(0, 0, w, h);

    // draw label text
//    offScreen.hint(DISABLE_DEPTH_TEST);
    
    offScreen.fill(0, 0, 0);
    offScreen.textAlign(CENTER, CENTER);    
    offScreen.textFont(tFont);    
    //    offScreen.textSize(20);
    offScreen.text(textString, w/2, h/2, 0); // center text on label
//    offScreen.hint(ENABLE_DEPTH_TEST);
    
    offScreen.endDraw();

    //When we're done drawing, we grab pixels from the offscreen GO and store it temporarily in a PImage.
    PImage temp = offScreen.get(0, 0, w, h);

    //Finally, we create a GLtexture, and put the image data inside of it
    blitImage = new GLTexture(app);
    blitImage.putImage(temp);
  };

  void setColor(color c) {
    this.c = c;
  }

  void setAlpha(float a) {
    alphaVal = a;
  }

  void render() {
    //Rendering the text objects involves just drawing the GLTexture using our usual image() method.
    pushMatrix();
    translate(pos.x, pos.y);
    tint(0, 0, 100, alphaVal); // make image transparent based on distance from camera
    image(blitImage, 0, 0);
    popMatrix();
  };
};

