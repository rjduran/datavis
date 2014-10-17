class DataTable {
  int rowCount;
  int columnCount;

  float[][] data;
  String[] yearNames;
  String[] monthNames;
  String[] dayNames;  


  DataTable(String filename) {
    String[] rows = loadStrings(filename);

    String[] columns = split(rows[1], "^^");
    columnCount = columns.length;

    yearNames = new String[rows.length-1];
    monthNames = new String[rows.length-1];
    dayNames = new String[rows.length-1];    

    data = new float[rows.length-1][]; // since my data is 1 column wide, I will have only 1 item in each location. If it was 2 columns wide, it would be an array of [rows.length-1] x [2 values]. ie, [0][0], [0][1] == (row 0, col 0), (row 0, col 1)

    // start reading at row 1, because the first row was only the query
    for (int i = 1; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }

      // split the row into pieces
      String[] pieces = split(rows[i], "^^");

      // copy row "titles" into arrays (date in our case)
      yearNames[rowCount] = pieces[0];
      monthNames[rowCount] = pieces[1];
      dayNames[rowCount] = pieces[2];      

      // copy data into the table starting at pieces[3]
      data[rowCount] = parseFloat(subset(pieces, 3));

      // increment the number of valid rows found so far
      rowCount++;
    }
    // resize the 'data' array as necessary
    data = (float[][]) subset(data, 0, rowCount);
  }


  // returns the total row count
  int getRowCount() {
    return rowCount;
  }


  // returns a specific year for a row index
  String getYear(int rowIndex) {
    return yearNames[rowIndex];
  }


  // returns the whole array of years
  String[] getYearNames() {
    return yearNames;
  }  


  // returns a specific month for a row index
  String getMonth(int rowIndex) {
    return monthNames[rowIndex];
  }


  // returns the whole array of month
  String[] getMonthNames() {
    return monthNames;
  }  


  // returns a specific day for a row index
  String getDay(int rowIndex) {
    return dayNames[rowIndex];
  }


  // returns the whole array of day
  String[] getDayNames() {
    return dayNames;
  }  


  int getRowIndex(String name) {
    for (int i = 0; i < rowCount; i++) {      
      if (monthNames[i].equals(name)) {
        return i;
      }
    }
    //println("No row named '" + name + "' was found");
    return -1;
  }
  
    int getYearRowIndex(String name) {
    for (int i = 0; i < rowCount; i++) {      
      if (yearNames[i].equals(name)) {
        return i;
      }
    }
    //println("No row named '" + name + "' was found");
    return -1;
  }

  // technically, this only returns the number of columns 
  // in the very first row (which will be most accurate)
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

    return data[rowIndex][col];
  }


  boolean isValid(int row, int col) {
    if (row < 0) return false;
    if (row >= rowCount) return false;
    //if (col >= columnCount) return false;
    if (col >= data[row].length) return false;
    if (col < 0) return false;
    return !Float.isNaN(data[row][col]);
  }


  float getColumnMin(int col) {
    float m = Float.MAX_VALUE;
    for (int i = 0; i < rowCount; i++) {
      if (!Float.isNaN(data[i][col])) {
        if (data[i][col] < m) {
          m = data[i][col];
        }
      }
    }
    return m;
  }


  float getColumnMax(int col) {
    float m = -Float.MAX_VALUE;
    for (int i = 0; i < rowCount; i++) {
      if (isValid(i, col)) {
        if (data[i][col] > m) {
          m = data[i][col];
        }
      }
    }
    return m;
  }


  float getRowMin(int row) {
    float m = Float.MAX_VALUE;
    for (int i = 3; i < columnCount; i++) {
      if (isValid(row, i)) {
        if (data[row][i] < m) {
          m = data[row][i];
        }
      }
    }
    return m;
  } 


  float getRowMax(int row) {
    float m = -Float.MAX_VALUE;
    for (int i = 3; i < columnCount; i++) {
      if (!Float.isNaN(data[row][i])) {
        if (data[row][i] > m) {
          m = data[row][i];
        }
      }
    }
    return m;
  }


  float getTableMin() {
    float m = Float.MAX_VALUE;
    for (int i = 0; i < rowCount; i++) {
      for (int j = 3; j < columnCount; j++) {
        if (isValid(i, j)) {
          if (data[i][j] < m) {
            m = data[i][j];
          }
        }
      }
    }
    return m;
  }


  float getTableMax() {
    float m = -Float.MAX_VALUE;
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {              
        if (isValid(i, j)) {
          if (data[i][j] > m) {
            m = data[i][j];
          }
        }
      }
    }
    return m;
  }
}

