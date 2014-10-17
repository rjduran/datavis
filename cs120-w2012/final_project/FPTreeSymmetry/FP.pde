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
    for (String item : ordered)
      print(item + ":" + support.get(item).intValue() + " ");
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
      float z = map(support, 0, 1000, rootDistance, 150);

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



      // mountains + roots shown
      if (displayMode == 1) 
      {        
        displayGrid = true;       
        // draw nodes and connections between them
        stroke(treeColor); 
        strokeWeight(0.5); 

        // use variance to separate node placement to make it easier to see in space
        if (varianceEnabled) 
        {
          varianceIntegrator[idx].target(variance[idx]);

          if (displayLines) line(0, 0, 0, 0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);
        } 
        else {
          varianceIntegrator[idx].target(0);
          if (displayLines) line(0, 0, 0, 0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);
        }
        translate(0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);

        // my position
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

        // Draw label
        pushMatrix();
        rotate(-PI/2);
        rotateX(-PI/2);

        pushMatrix();
        rotateY(-1.75); //experimental

        // Draw rectangle and label
        fill(0, 0, 100, alphaFade);
        float cw = textWidth(label);
        rectMode(CENTER);        
        rect(0, 0, cw, 28);

        // label
        fill(0, 0, 0, alphaFade);
        textAlign(CENTER, CENTER);
        textFont(font);
        textSize(20);  
        text(label, 0, 0, 2);
        popMatrix();
        popMatrix();
      }

      // only roots shown (with variance option)
      if (displayMode == 2) 
      {

        displayGrid = false;

        stroke(treeColor); 
        strokeWeight(0.5); 

        if (varianceEnabled) 
        {
          varianceIntegrator[idx].target(variance[idx]);

          if (displayLines) line(0, 0, 0, 0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);
        } 
        else {
          varianceIntegrator[idx].target(0);
          if (displayLines) line(0, 0, 0, 0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);
        }

        translate(0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);
        // my position
        float locpX = 0;
        float locpY = nodeSpacing/pow(deep, 1.1) * labelLen;
        float locpZ = -z+varianceIntegrator[idx].value;

        // peasy cam position
        float diffX = peasyCamPosition[0] - locpX;
        float diffY = peasyCamPosition[1] - locpY;
        float diffZ = peasyCamPosition[2] - locpZ;

        float sMag = sqrt((diffX*diffX) + (diffY*diffY) + (diffZ*diffZ));
        float alphaFade = map(sMag, 5500, 2500.0, 0, 100);       

        // Draw label
        pushMatrix();
        rotate(-PI/2);
        rotateX(-PI/2);

        pushMatrix();
        rotateY(-1.75); //experimental

        // Draw rectangle and label
        fill(0, 0, 100, alphaFade);
        float cw = textWidth(label);
        rectMode(CENTER);        
        rect(0, 0, cw+4, 22);

        // label
        fill(0, 0, 0, alphaFade);
        textAlign(CENTER, CENTER);
        textFont(font);
        textSize(20);  
        text(label, 0, 0, 1);
        popMatrix();
        popMatrix();
      }

      // flat nodes + connections
      if (displayMode == 3) 
      {
        displayGrid = true;

        stroke(treeColor); 
        strokeWeight(1);         

        if (displayLines) line(0, 0, 0, nodeSpacing/pow(deep, 1.1));  
        translate(0, nodeSpacing/pow(deep, 1.1)); 

        noStroke();
        fill(nodeColor);

        pushMatrix();
        translate(0, 0, 1); // move ellipse 1 above 0 to avoid artifacts
        ellipse(0, 0, sqrt(2*support), sqrt(2*support)); // draw node at end of branch
        popMatrix();
        
        // draw label  
        rotate(-PI/2);
        fill(0, 0, 100);
        textAlign(CENTER, CENTER);
        textFont(font);
        textSize(20*(pow(deep, 0.0075)));
        float sw = textWidth(label);  
        text(label, sw, 0, 1);
        //rotate(-PI*1.5);        
      }

      // flat lines + mountains + connections
      if (displayMode == 4) 
      {
        displayGrid = true;

        stroke(treeColor); 
        strokeWeight(1); 
        noFill();

        if (displayLines) line(0, 0, 0, nodeSpacing/pow(deep, 1.1));  // Draw the branch
        translate(0, nodeSpacing/pow(deep, 1.1)); // Move to the end of the branch

      }

      // root nodes + connections (with variance option)
      if (displayMode == 5) 
      {
        displayGrid = false;

        stroke(treeColor); 
        strokeWeight(1); 
        noFill();

        if (varianceEnabled) 
        {
          varianceIntegrator[idx].target(variance[idx]);

          if (displayLines) line(0, 0, 0, 0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);          
        } 
        else {
          varianceIntegrator[idx].target(0);
          if (displayLines) line(0, 0, 0, 0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);          
        }

        translate(0, nodeSpacing/pow(deep, 1.1) * labelLen, -z+varianceIntegrator[idx].value);       
        
        noStroke();
        fill(nodeColor);

        pushMatrix();
        translate(0, 0, 1); // move ellipse 1 above 0 to avoid artifacts
        rotateY(-PI/2);

        rotateX(abs(rotations[0]));        
        ellipse(0, 0, sqrt(2*support), sqrt(2*support)); // draw node at end of branch

        popMatrix();
      }            

      if (displayMode == 6) 
      {
        displayLines = true;
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
      Pyramid pyramid = new Pyramid(support);
      //float z = map(support, 0, 10000, 0, 1000);

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

      if (displayMode == 1) 
      {

        // draw nodes and connections between them
        //stroke(0, 0, 0, 100); 
        //strokeWeight(1); 
        noFill();

        translate(0, nodeSpacing/pow(deep, 1.1)); // Move to the end of the branch        
        if (displayPyramids) pyramid.display();

        //        // draw label  
        //        rotate(-PI/2);
        //        rotateX(-PI/2); // rotate vertically
        //        
        //        fill(0, 0, 100);
        //        textAlign(CENTER, CENTER);
        //        textFont(font);
        //        textSize(20);  
        //        text(support, 0, 0, 1);
        //        rotate(-PI*1.5);
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

        noStroke();
        fill(nodeColor);

        pushMatrix();
        translate(0, 0, 1); // move ellipse 1 above 0 to avoid artifacts
        ellipse(0, 0, sqrt(support), sqrt(support)); // draw node at end of branch
        popMatrix();
      } 

      if (displayMode == 5) 
      {
      }

      if (displayMode == 6) 
      {

        translate(0, nodeSpacing/pow(deep, 1.1)); // Move to the end of the branch
        if (displayPyramids) pyramid.display();

        // draw label  
//        rotate(-PI/2);
//        fill(0, 0, 100);
//        textAlign(CENTER, CENTER);
//        textFont(font);
//        textSize(20);  
//        text(support, 0, 0, 1);
//        rotate(-PI*1.5);
      }      

      wide++;
      graphViz2(n, 0, deep+1, n.child.size(), currentRotation);     // Ok, now call myself to draw a new branch recursively

      popMatrix();
    }
  }
}

