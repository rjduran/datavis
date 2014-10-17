
ClLovers cl;
ClLoversTheme[] themes;

int swatch = 10; // swatch # selected. (Note: swatch < results)
int results = 77; // total requested results
String keyword = "purple+pink+neon";
//color[] clColor;

// variables
color bgColor, polarGridColor, polarPlotColor;
color hudTextColor;
color treeColor, nodeColor, nodeLabelColor, pyramidColor, pyramidStrokeColor;


void setupColor()
{
  /*
cl = new ClLovers(this);
   cl.setNumResults(results);
   themes = cl.searchForThemes(keyword);
   
   // get colors from swatch
   clColor = new color[5]; // 5 colors per swatch
   
   for (int i = 0; i < themes[swatch].totalSwatches(); i++) 
   {
   clColor[i] = themes[swatch].getColor(i);
   println( "color["+i+"]: "+hue(clColor[i]) + ", " + saturation(clColor[i]) + ", " + brightness(clColor[i]) );
   
   }
   */

  // background
  //  bgColor = color(213, 86, 99);      // lt blue color
  //  bgColor = color(38, 5, 99);  // creamier white
  //    bgColor = color(0, 0, 20); // dark grey
  bgColor = color(0, 0, 20); // dark grey

  //    bgColor = color(351, 86, 20); 

  hudTextColor = color(0, 0, 100);

  // grid
  polarGridColor = color(0, 0, 100, 35);
  polarPlotColor = color(213, 86, 99, 40);

  treeColor = color(0, 0, 100, 30);  
  nodeColor = color(0, 0, 100, 100);
  nodeLabelColor = color(0, 0, 0, 100);  
  pyramidColor = color(0, 0, 100, 50);  
  pyramidStrokeColor = color(0, 0, 100, 100);
}


//  background(348, 86, 99); // pink/red color
//background(0, 0, 100); // pink/red color

//background(mouseX%360, 86, 99);  
//println(mouseX%360);



/*
Color Palettes Tried
 
 #30 with bgColor = color(38, 5, 99);
 
 #38 with bgColor = color(38, 5, 99);
 
 // This is a nice grey with subtle highlights for the tags. Might be a good option for symmetry vis.
 #11 with   bgColor = color(0, 0, 20);
 
 */
