class DataTable {
  int rowCount;
  int columnCount;

  String[][] data;

  DataTable(String filename) {
    String[] rows = loadStrings(filename);
    String[] columns = split(rows[1], ",");
    columnCount = columns.length;

    //rowName = new String[rows.length-1];
    data = new String[rows.length-1][]; // since my data is 1 column wide, I will have only 1 item in each location. If it was 2 columns wide, it would be an array of [rows.length-1] x [2 values]. ie, [0][0], [0][1] == (row 0, col 0), (row 0, col 1)

    // start reading at row 1, because the first row was only the query or headings for categories
    for (int i = 0; i < rows.length-1; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }

      // split the row into pieces
      String[] pieces = split(rows[i], ",");
      //println(pieces);
      // copy row "titles" into arrays (date in our case or category index)
      //rowName[rowCount] = pieces[0];      

      // copy data into the table starting at pieces[3]
      data[rowCount] = subset(pieces, 0);
      //println(data[rowCount]);

      // increment the number of valid rows found so far
      rowCount++;
    }
    // resize the 'data' array as necessary
    data = (String[][]) subset(data, 0, rowCount);
  }


  // returns the total row count
  int getRowCount() {
    return rowCount;
  }

  // returns the total column count
  int getColumnCount() {
    return columnCount;
  }  

  float getValue(int rowIndex, int col) {
    if ((rowIndex < 0) || (rowIndex >= data.length)) {
      throw new RuntimeException("There is no row " + rowIndex);
    }
    if ((col < 0) || (col >= data[rowIndex].length)) {
      throw new RuntimeException("Row " + rowIndex + " does not have a column " + col);
    }

    return float(data[rowIndex][col]);
  }

  String getStringValue(int rowIndex, int col) {
    if ((rowIndex < 0) || (rowIndex >= data.length)) {
      throw new RuntimeException("There is no row " + rowIndex);
    }
    if ((col < 0) || (col >= data[rowIndex].length)) {
      throw new RuntimeException("Row " + rowIndex + " does not have a column " + col);
    }

    return data[rowIndex][col];
  }  

  // max min for subset of column to depth
  float getColumnMin(int col, int depth) {
    float m = Float.MAX_VALUE;
    for (int i = 0; i < depth; i++) {
      if (float(data[i][col]) < m) {
        m = float(data[i][col]);
      }
    }
    return m;
  }

  float getColumnMax(int col, int depth) {
    float m = -Float.MAX_VALUE;
    for (int i = 0; i < depth; i++) {
      if (float(data[i][col]) > m) {
        m = float(data[i][col]);
      }
    }
    return m;
  }

  // max min for entire dataset column
  float getColumnMin(int col) {
    float m = Float.MAX_VALUE;
    for (int i = 0; i < rowCount; i++) {
      if (float(data[i][col]) < m) {
        m = float(data[i][col]);
      }
    }
    return m;
  }

  float getColumnMax(int col) {
    float m = -Float.MAX_VALUE;
    for (int i = 0; i < rowCount; i++) {
      if (float(data[i][col]) > m) {
        m = float(data[i][col]);
      }
    }
    return m;
  }
}

