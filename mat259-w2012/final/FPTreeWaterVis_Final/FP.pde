// Karl Yerkes - 2012/02/09
//
// FP-Growth Data Structure and Algorithm
//   http://www.cs.uiuc.edu/~hanj/pdf/dami04_fptree.pdf
//
// This work is part of the SPL data-mining project
// special thanks to the Robert W. Deutsch Foundation
//

//Terminal$ dot fptree.dot -Tpng -Otree.png


public class FP {

  public Node root;
  public HashMap<String, Node> head;

  public class Node {
    public HashMap<String, Node> child;
    public Node next, parent;

    String item;
    Integer support;

    int xLoc;
    int yLoc;   

    Node(String item) {
      this.item = item;
      child = new HashMap<String, Node>();
      support = 1;
      next = null;
      parent = null;
    }
  }

  public void make(String[] transaction, int minimumSupport) {

    // create new root and head
    //
    root = new Node("");
    head = new HashMap<String, Node>();

    final HashMap<String, Integer> support = new HashMap<String, Integer>();

    class ByDescendingSupport implements Comparator<String> {
      public int compare(String left, String right) {
        return support.get(right).intValue() - support.get(left).intValue();
      }
    } 

    // calculate the support for each item
    //
    for (String t : transaction)
      for (String item : split(t, ",")) {
        Integer i = support.get(item);
        if (i == null)
          support.put(item, new Integer(1));
        else
          support.put(item, new Integer(1 + i.intValue()));
      }

    // remove all items that do not have minimal support
    //
    for (String item : new LinkedList<String>(support.keySet()))
      if (support.get(item).intValue() < minimumSupport)
        //if(support.get(item).intValue() < minimumSupport || support.get(item).intValue() > maximumSupport)
        support.remove(item);

    // make a list of items sorted first alphabetically, then by descending support
    //
    LinkedList<String> ordered = new LinkedList(support.keySet());
    Collections.sort(ordered);
    Collections.sort(ordered, new ByDescendingSupport());

    print("ITEMS: ");



    int itemCount = 0; // threshold for counting off top 10 items

    for (String item : ordered) 
    {
      print(item + ":" + support.get(item).intValue() + " "); // print item


      int strlen = item.length();

      // HSB
      float h = 0;
      float s = 0;
      float b = 0;

      // make string version
      String cs = h +","+ s +","+ b; // ex, 213, 86, 99

      // make color version     
      color cc = color(h, s, b); 

      // set colors for labels here based on string length
      if (strlen <= 3) 
      {
        h = 172.10526;
        s = 16.033754;
        b = 92.94118;
      } 
      else if (strlen <= 4) 
      {
        h = 172.25807;
        s = 27.927929;
        b = 87.05882;
      } 
      else if (strlen <= 5) 
      {
        h = 177.0;
        s = 38.83495;
        b = 80.78432;
      } 
      else if (strlen <= 6) 
      {
        h = 187.08661;
        s = 64.79591;
        b = 76.86275;
      }       
      else if (strlen <= 7)   
      {
        h = 187.55243;
        s = 86.666664;
        b = 64.70589;
      }
      else if (strlen <= 8)  
      {
        h = 162.10526;
        s = 43.846153;
        b = 50.980396;
      }
      else if (strlen <= 9)  
      {
        h = 135.40541;
        s = 43.274853;
        b = 67.05882;
      }
      else if (strlen <= 10)  
      {
        h = 63.839993;
        s = 49.019608;
        b = 100.0;
      }
      else
      {
        h = 50.847458;
        s = 86.7647;
        b = 80.0;
      }

      // COMMON TO BOTH
      cs = h +","+ s +","+ b;

      // save for drawing lines
      itemColorHashMap.put(item, cs);

      cc = color(h, s, b);
      // Make TextObject
      TextObject t = new TextObject(item, cc);

      // associate string with TextObject for each item
      textObjects.put(item, t);

      itemCount++;
    }
    println();

    // process each transaction
    //
    for (String t : transaction) {

      // list all items that have minimal support
      //
      LinkedList<String> supported = new LinkedList();
      for (String item : split(t, ","))
        if (support.containsKey(item))
          supported.add(item);

      // if there are 0 supported items in the transaction, skip it
      //
      if (supported.isEmpty())
        continue;

      //      print("TRANSACTION: ");
      //      for (String item : split(t, ","))
      //        print(item + " ");
      //      print("--> ");

      // sort the list of supported items first alphabetically, then by descending support
      //
      Collections.sort(supported);
      Collections.sort(supported, new ByDescendingSupport());

      //      print("ORDERED: ");
      //      for (String item : supported)
      //        print(item + " ");
      //      println();

      insert(root, supported);
    }
  }

  public void insert(Node tree, LinkedList<String> supported) {

    // recursive stopping condition
    //
    if (supported.isEmpty())
      return;

    String item = supported.removeFirst(); 
    Node nextTree = tree.child.get(item);
    if (nextTree == null) {
      nextTree = new Node(item);
      tree.child.put(item, nextTree);
      nextTree.parent = tree;

      Node h = head.get(item);
      if (h == null)
        head.put(item, nextTree);
      else {
        nextTree.next = h;
        head.put(item, nextTree);
      }
    }
    else
      nextTree.support++;

    // recursive call
    //
    insert(nextTree, supported);
  }

  // save a GraphViz (dot) file that shows the FP tree
  //
  // see http://www.graphviz.org/doc/info/lang.html
  //
  public void graphViz(String file) {
    PrintWriter output = createWriter(file);
    output.println("digraph fptree {");
    graphViz(root, output);
    output.println("}");
    output.close();
  }

  // this is the recursive version
  //
  private void graphViz(Node t, PrintWriter output) {
    output.println("  " + t.hashCode() + " [label=\"" + t.item + "\\n" + t.support + "\"];");
    for (Node n : t.child.values()) {

      // recursive call
      //
      graphViz(n, output);
      output.println("  " + n.hashCode() + " -> " + t.hashCode() + ";");
    }
  }


  //Visualization method
  // LINES
  public void graphViz(Node t, int wide, int deep, int siblings, float currentRotation) {

    // for each Node in tree do this
    for (Node n : t.child.values()) {

      int support = n.support; // *** this Node's support value***
      String label = n.item;

      // maybe the length of the branch is determed by the length of the word?
      int labelLen = label.length()/4;

      //Pyramid pyramid = new Pyramid(support);
      float z = map(support, 0, 10000, rootDistance, 150);

      // recursive call
      pushMatrix();    // Save the current state of transformation (i.e. where are we now)

      // rotation
      if (deep < 2) {
        rotate((PI*2.0/siblings)*wide + deep*0.2 );
        rotate(masterRotation); // overall graph rotation
      }
      else {
        rotate( spread*(PI*0.5/siblings)*(wide-(siblings-1)*0.5) + deep*0.2 );
      }

      // Get color for node label/line
      String colorString = (String)itemColorHashMap.get(label); // get color string associated with label
      String[] q = splitTokens(colorString, ",");
      color qc = color(int(q[0]), int(q[1]), int(q[2])); // color for node, line

      // set variance target if enabled
      if (varianceEnabled) 
      {
        varianceIntegrator[idx].target(variance[idx]);
      } 
      else {
        varianceIntegrator[idx].target(0);
      }

      // make calculation for alpha fade
      // my location
      float locpX = 0;
      float locpY = nodeSpacing/pow(deep, 1.1) * labelLen;
      float locpZ = -z+varianceIntegrator[idx].value;

      // peasy cam position
      float diffX = peasyCamPosition[0] - locpX;
      float diffY = peasyCamPosition[1] - locpY;
      float diffZ = peasyCamPosition[2] - locpZ;

      // associate diff with alpha
      // the further away, the lower so the BIGGER diff, the smaller alpha
      // get magnitude from node to camera
      float sMag = sqrt((diffX*diffX) + (diffY*diffY) + (diffZ*diffZ));
      float alphaFade = map(sMag, 5500, 2000.0, 0, 100);

      TextObject textObject = (TextObject)textObjects.get(label); // get TextObject based on label

        // display modes
      // mountains + roots shown
      if (displayMode == 1) 
      {        
        displayGrid = true;       

        // draw nodes and connections between them
        stroke(qc, alphaFade); 
        strokeWeight(0.5); 

        if (displayLines) line(0, 0, 0, 0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);
        translate(0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);

        // render text label object
        pushMatrix();
        rotate(-PI/2);
        rotateX(-PI/2);

        pushMatrix();
        rotateY(-1.75); //experimental
        textObject.setAlpha(alphaFade);
        textObject.render();
        popMatrix();

        popMatrix();
      }

      // only roots shown (with variance option)
      if (displayMode == 2) 
      {
        //displayGrid = false;
        alphaFade = map(sMag, 5500, 2500.0, 0, 100); 

        stroke(qc, alphaFade);        
        strokeWeight(0.5); 

        if (displayLines) line(0, 0, 0, 0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);
        translate(0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);              

        // render text label object
        pushMatrix();
        rotate(-PI/2);
        rotateX(-PI/2);

        pushMatrix();
        rotateY(-1.75); //experimental      
        textObject.setAlpha(alphaFade);        
        textObject.render();
        popMatrix();

        popMatrix();
      }

      // flat nodes + connections + labels
      if (displayMode == 3) 
      {
        //displayGrid = true;

        // these would look good in both white and color modes
        stroke(qc);        
        strokeWeight(1);         

        if (displayLines) line(0, 0, 0, nodeSpacing/pow(deep, 1.1));  
        translate(0, nodeSpacing/pow(deep, 1.1)); 

        noStroke();
        // these would look good in both white and color modes
        fill(qc);
        stroke(qc, alphaFade);

        pushMatrix();
        translate(0, 0, 2); // move ellipse 1 above 0 to avoid artifacts
        // render text label object
        rotate(-PI/2);
        textObject.setAlpha(alphaFade);
        textObject.render();
        popMatrix();
      }


      // flat lines + mountains + connections
      if (displayMode == 4) 
      {
        stroke(qc); 
        strokeWeight(1); 

        if (displayLines) line(0, 0, 0, nodeSpacing/pow(deep, 1.1));  // Draw the branch
        translate(0, nodeSpacing/pow(deep, 1.1)); // Move to the end of the branch

        pushMatrix();
        translate(0, 0, 1); 
        fill(qc);  
        ellipse(0, 0, sqrt(support), sqrt(support));
        popMatrix();
      }

      // lines + boxes (as nodes)
      if (displayMode == 5) 
      {
        displayGrid = false;

        stroke(qc, alphaFade);
        strokeWeight(1);         

        if (displayLines) line(0, 0, 0, 0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);
        translate(0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);       

        noStroke();
        fill(qc, alphaFade);

        pushMatrix();
        //        translate(0, 0, 1); // move box 1 above 0 to avoid artifacts
        rotateY(-PI/2);

        rotateX(abs(rotations[0]));        
        box(sqrt(support));
        popMatrix();
      }            

      if (displayMode == 6) 
      {
      }  

      if (displayMode == 7) 
      {
      }

      wide++;
      graphViz(n, 0, deep+1, n.child.size(), currentRotation);     // Ok, now call myself to draw a new branch recursively

      popMatrix();

      idx++;
    }
  }



  //Visualization method
  // PYRAMIDS
  public void graphViz2(Node t, int wide, int deep, int siblings, float currentRotation) {

    // for each Node in tree do this
    for (Node n : t.child.values()) {

      int support = n.support; // *** this Node's support value***
      String label = n.item;

      // Get color for node label/line
      String colorString = (String)itemColorHashMap.get(label); // get color string associated with label
      String[] q = splitTokens(colorString, ",");
      color qc = color(int(q[0]), int(q[1]), int(q[2])); // color for node, line      

      Pyramid pyramid = new Pyramid(support);
      pyramid.setColor(qc);

      // recursive call
      pushMatrix();    // Save the current state of transformation (i.e. where are we now)

      // rotation
      if (deep < 2) {
        rotate( (PI*2.0/siblings)*wide + deep*0.2 );
        rotate(masterRotation); // overall graph rotation
      }
      else {
        rotate( spread*(PI*0.5/siblings)*(wide-(siblings-1)*0.5) + deep*0.2 );
      }

      // display modes
      if (displayMode == 1) 
      {
        noFill();

        translate(0, nodeSpacing/pow(deep, 1.1)); // Move to the end of the branch        
        if (displayPyramids) pyramid.display();
      }

      if (displayMode == 2) 
      {
      }

      if (displayMode == 3) 
      {
      }

      if (displayMode == 4) 
      {

        translate(0, nodeSpacing/pow(deep, 1.1)); // Move to the end of the branch
        if (displayPyramids) pyramid.display();
      } 

      if (displayMode == 5) 
      {
      }

      if (displayMode == 6) 
      {

        translate(0, nodeSpacing/pow(deep, 1.1)); // Move to the end of the branch
        if (displayPyramids) pyramid.display();
      }   


      if (displayMode == 7) 
      {
        translate(0, nodeSpacing/pow(deep, 1.1)); // Move to the end of the branch
        if (displayPyramids) pyramid.display();
      }


      wide++;
      graphViz2(n, 0, deep+1, n.child.size(), currentRotation);     // Ok, now call myself to draw a new branch recursively

      popMatrix();
    }
  }
}

