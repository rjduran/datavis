// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 18-8: Loading XML with simpleML

import simpleML.*;

XMLRequest xmlRequest;

String keyword;

void setup() {
  size(1, 1);

  // Creating and starting the request
  // An array of XML elements can be retrieved using getElementArray. 
  // This only works for elements with the same name that appear multiple times in the XML document.
  
  keyword = "symmetry";
  
  xmlRequest = new XMLRequest(this, "http://export.arxiv.org/api/query?search_query=all:"+ keyword +"&start=0&max_results=10000" );
  xmlRequest.makeRequest();
}

void draw() {
  noLoop(); // Nothing to see here
}

// When the request is complete
void netEvent(XMLRequest ml) {

  // Retrieving an array of all XML elements inside"  title*  "tags
  String[] headlines = ml.getElementArray( "title" );

  for (int i = 0; i < headlines.length; i++ ) {
    headlines[i] = headlines[i].replaceAll("\\s+", " ");
    //    println(); // strip whitespace
  }

  saveStrings("data/"+keyword+".txt", headlines);
  println("data saved");
  exit();
}

