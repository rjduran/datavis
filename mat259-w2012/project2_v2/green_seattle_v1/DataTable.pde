class DataTable {
  int rowCount;
  int columnCount;

  String[][] data;
  String[] rowName; 


  DataTable(String filename) {
    String[] rows = loadStrings(filename);
    String[] columns = split(rows[1], ",");
    columnCount = columns.length;

    rowName = new String[rows.length-1];
    data = new String[rows.length-1][]; // since my data is 1 column wide, I will have only 1 item in each location. If it was 2 columns wide, it would be an array of [rows.length-1] x [2 values]. ie, [0][0], [0][1] == (row 0, col 0), (row 0, col 1)

    // start reading at row 1, because the first row was only the query or headings for categories
    for (int i = 1; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }

      // split the row into pieces
      String[] pieces = split(rows[i], ",");
      //println(pieces);
      // copy row "titles" into arrays (date in our case or category index)
      rowName[rowCount] = pieces[0];      

      // copy data into the table starting at pieces[3]
      data[rowCount] = subset(pieces, 1);
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


  String getRowName(int rowIndex) {
    return rowName[rowIndex];
  }


  // returns the whole array of years
  String[] getRowNames() {
    return rowName;
  }  


  int getRowIndex(String s) {
    for (int i = 0; i < rowCount; i++) {      
      if (rowName[i].equals(s)) {
        return i;
      }
    }
    //println("No row named '" + name + "' was found");
    return -1;
  }

  // get start index for month m
  int getRowIndexForMonth(int m) {
    for (int i = 0; i < rowCount; i++) {
      String subStr = rowName[i].substring(5, 7);
      if (int(subStr) == m) {
        return i;
      }
    }
    return -1;
  }

  // returns the total number of entries for month m
  int getNEntriesForMonth(int m) {
    int count = 0;
    for (int i = 0; i < rowCount; i++) {
      String subStr = rowName[i].substring(5, 7);
      if (int(subStr) == m) {
        count++;
      }
    }
    return count;
  }  




  String getValue(int rowIndex, int col) {
    if ((rowIndex < 0) || (rowIndex >= data.length)) {
      throw new RuntimeException("There is no row " + rowIndex);
    }
    if ((col < 0) || (col >= data[rowIndex].length)) {
      throw new RuntimeException("Row " + rowIndex + " does not have a column " + col);
    }

    return data[rowIndex][col];
  }


//  boolean isValid(int row, int col) {
//    if (row < 0) return false;
//    if (row >= rowCount) return false;
//    //if (col >= columnCount) return false;
//    if (col >= data[row].length) return false;
//    if (col < 0) return false;
//    return !Float.isNaN(data[row][col]);
//  }


  //  float getColumnMin(int col) {
  //    float m = Float.MAX_VALUE;
  //    for (int i = 0; i < rowCount; i++) {
  //      if (!Float.isNaN(data[i][col])) {
  //        if (data[i][col] < m) {
  //          m = data[i][col];
  //        }
  //      }
  //    }
  //    return m;
  //  }
  //
  //
  //  float getColumnMax(int col) {
  //    float m = -Float.MAX_VALUE;
  //    for (int i = 0; i < rowCount; i++) {
  //      if (isValid(i, col)) {
  //        if (data[i][col] > m) {
  //          m = data[i][col];
  //        }
  //      }
  //    }
  //    return m;
  //  }
  //
  //
  //  float getRowMin(int row) {
  //    float m = Float.MAX_VALUE;
  //    for (int i = 3; i < columnCount; i++) {
  //      if (isValid(row, i)) {
  //        if (data[row][i] < m) {
  //          m = data[row][i];
  //        }
  //      }
  //    }
  //    return m;
  //  } 
  //
  //
  //  float getRowMax(int row) {
  //    float m = -Float.MAX_VALUE;
  //    for (int i = 3; i < columnCount; i++) {
  //      if (!Float.isNaN(data[row][i])) {
  //        if (data[row][i] > m) {
  //          m = data[row][i];
  //        }
  //      }
  //    }
  //    return m;
  //  }
  //
  //
  //  float getTableMin() {
  //    float m = Float.MAX_VALUE;
  //    for (int i = 0; i < rowCount; i++) {
  //      for (int j = 3; j < columnCount; j++) {
  //        if (isValid(i, j)) {
  //          if (data[i][j] < m) {
  //            m = data[i][j];
  //          }
  //        }
  //      }
  //    }
  //    return m;
  //  }
  //
  //
  //  float getTableMax() {
  //    float m = -Float.MAX_VALUE;
  //    for (int i = 0; i < rowCount; i++) {
  //      for (int j = 0; j < columnCount; j++) {              
  //        if (isValid(i, j)) {
  //          if (data[i][j] > m) {
  //            m = data[i][j];
  //          }
  //        }
  //      }
  //    }
  //    return m;
  //  }
}

