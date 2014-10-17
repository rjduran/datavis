class GridView extends DataPlot {
  float plotW, plotH; 

  float mx, my; // mouseX and mouseY inside this graph

  DataTable lastfmData;
  DataTable splData;

  int columnCount;
  int rowCount;
  float lastfmMinVal, lastfmMaxVal, splMinVal, splMaxVal;
  int nEntries;

  PImage[] images;
  PImage notFound;
  int imgsPerRow = 14;
  int totalRows = 7;

  int timer;
  int timelength = 500; // 500 ms
  boolean enableTimer = false;

  Integrator alphVal;

  GridView(float x1, float y1, float w, float h, DataTable lastfmData, DataTable splData) {
    super(x1, y1, w, h);

    plotX1 = 0; // left side
    plotX2 = w - plotX1; // right side    
    plotY1 = 0;  // top
    plotY2 = h - plotY1; // bottom
    plotW = plotX2-plotX1;
    plotH = plotY2-plotY1;

    this.lastfmData = lastfmData;
    this.splData = splData;

    nEntries = imgsPerRow*totalRows; // display ~100 entries from file

    lastfmMinVal = lastfmData.getColumnMin(2, nEntries);
    lastfmMaxVal = lastfmData.getColumnMax(2, nEntries);    

    splMinVal = splData.getColumnMin(1, nEntries);
    splMaxVal = splData.getColumnMax(1, nEntries); 

    notFound = loadImage("notFound.png");    
    images = new PImage[nEntries];

    // load images
    for (int i = 0; i < nEntries; i++) {
      String s = lastfmData.getStringValue(i, 3);

      if (s.equals("imgURL Not Found") || s.equals("")) {
        images[i] = notFound;// fill image space with blank image
        //println(i + ": no img");
      } 
      else {                
        images[i] = loadImage(s);
        //println(i + ": " + s );
      }
    }

    titleEnable = false;
    headerLineEnable = false;

    alphVal = new Integrator(100, 0.1f, 5.0f);
  }

  void display() {
    super.display();

    pushMatrix();
    translate(x, y);  

    mx = mouseX-x;
    my = mouseY-y;  

    // draw here

    alphVal.update();

    noStroke();

    int overIdx = -1;
    boolean darken = false;

    for (int i = 0; i < totalRows; i++) {
      for (int j = 0; j < imgsPerRow; j++) {

        int idx = i*imgsPerRow + j;
        float smImgWidth = w/imgsPerRow;
        float smImgHeight = w/imgsPerRow;

        float x1 = j*smImgWidth;
        float y1 = i*smImgHeight;

        if (overItem(mx, my, x1, y1, smImgWidth, smImgHeight)) {           
          overIdx = idx;

          if (!enableTimer) {
            enableTimer = true;
            timer = millis();
          }

          if (!( millis() - timer < timelength)) {
            darken = true;
          }
        } 


        // if darken, set alpha target to darker
        if (darken) {
          alphVal.target(15);
        } 
        else {
          alphVal.target(100);
        }

        // if overIdx is active, tint with hover color
        if (overIdx != idx) {
          tint(0, 0, 100, alphVal.value);
        }

        image(images[idx], x1, y1, smImgWidth, smImgHeight);

        int lfmPlays = int(lastfmData.getStringValue(idx, 2));                
        int splCheckouts = int(splData.getStringValue(idx, 1));
        float tot = lfmPlays + splCheckouts;

        float lfmPerc = lfmPlays/tot;
        float splPerc = splCheckouts/tot;

        noTint();
        if (overIdx == idx) {          
          fill(347, 77, 92, 65); // lastfm
          rect(x1, y1, smImgWidth * lfmPerc, smImgHeight);  

          fill(188, 100, 100, 65); // spl
          rect(x1+(smImgWidth * lfmPerc), y1, smImgWidth * splPerc, smImgHeight);
        } 
        else {
          noFill();
        }
      }
    }

    // end draw here
    popMatrix();
  }

  // handle hover
  boolean overItem(float mx, float my, float x, float y, float dw, float dh) {
    if ((mx >= x) && (mx <= x+dw) && (my >= y) && (my <= y+dh)) {
      return true;
    } 
    else {
      return false;
    }
  }// end
}

