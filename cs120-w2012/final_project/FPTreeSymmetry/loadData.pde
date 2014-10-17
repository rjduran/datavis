
void loadData()
{
  float startTime = millis();
  
  calculate();
  //fp.graphViz(filename + "_fptree.dot");
  float endTime = millis();
  
  println("tree built in " + (endTime - startTime)/1000 + " sec");
}

void calculate() 
{
  String transaction[] = loadStrings(filename);
  println("QUERY: " + transaction[0] + "\n");
    
  for (int i=1; i < transaction.length; i++) 
  {
    transaction[i] = transaction[i].toLowerCase();    
    transaction[i] = transaction[i].replace(' ', ',');
    String temp = transaction[i];
    //println(temp);
  }  
  
  nTransactions = transaction.length;
  
  fp.make(clean(transaction), minimumSupport);
}

// this is like grep/sort/uniq in one function
//
String[] clean(String[] transaction) 
{
  HashSet<String> ignore = new HashSet<String>(); 
  for (String s : ignoreString)

  ignore.add(s);

  LinkedList<String> output = new LinkedList<String>();
  for (String t : transaction) 
  {
    HashSet<String> hash = new HashSet<String>();
    for (String s : split(t, ","))
      if (! ignore.contains(s))
        hash.add(s);
    output.add(join(hash.toArray(new String[0]), ","));
  }
  return output.toArray(new String[0]);
}



