class Matrix {
  int x;
  int y;
  int cols;
  int rows;
  
  int cellWidth;
  int cellHeight;
  
  int interval = 1000;
  
  ArrayList<ArrayList<Cell>> cells;
  
  int bytePerPixel = 1;
  
  Matrix (int nbRows, int nbColumns) {
    x = 0;
    y = 0;
    
    cols = nbColumns;
    rows = nbRows;
    
    cellWidth = width / cols;
    cellHeight = height / rows;
    
    
    
    init();
  }      
  
  Matrix (int nbRows, int nbColumns, int bpp) {
    x = 0;
    y = 0;
    
    cols = nbColumns;
    rows = nbRows;
    bytePerPixel = bpp;
    
    cellWidth = width / cols;
    cellHeight = height / rows;
    
    
    init();
  }
  
  void init() {
    
    cells = new ArrayList<ArrayList<Cell>>();
    
    for (int j = 0; j < rows; j++){
      // Instanciation des rangees
      cells.add (new ArrayList<Cell>());
      
      for (int i = 0; i < cols; i++) {
        Cell temp = new Cell(i * cellWidth, j * cellHeight, cellWidth, cellHeight);
        cells.get(j).add (temp);
      }
    }
    
    println ("rows : " + rows + " -- cols : " + cols);
  }
  
  void displayRow (int j) {
    ArrayList<Cell> row = cells.get(j);
    
    for (int i = 0; i < row.size(); i++) {
      Cell current = row.get(i);
      current.display();       
    }
  }
  
  void display () {
    for (int j = 0; j < cells.size(); j++) {
      displayRow(j);
    }
  }
  
  void randomize() {
    for (int j = 0; j < cells.size(); j++) {
      for (int i = 0; i < cells.get(j).size(); i++) {
        Cell current = cells.get(j).get(i);
        
        current.setFillColor(color (random(255), random(255), random(255)));
      }
    }
  }
  
  void setCellColor (int i, int j, color c) {
    cells.get(j).get(i).setFillColor(c);
  }
  
  
  // cette méthode est un test a enlever a la fin
  void updatetest (String data) {
   
           
    for (int j=0;j<7;j++)
       for (int i=0;i<7;i++)
         this.setCellColor(i, j, color (random(1)));
  }
  
   void updateLyne (String data) {
     String rawData[] = data.split(" ");
     
     
    for (int j = 0; j < rows; j++) {
      
      
      
      for (int i = 0; i < cols; i++) {
        
        
        
        if (bytePerPixel == 3) {
          
          this.setCellColor(i, j, color (parseInt(rawData [(cols*j+i)*3]), // R
                                         parseInt(rawData [(cols*j+i)*3 + 1]), // G
                                         parseInt(rawData [(cols*j+i)*3 + 2]))); // B
          
          i+=2;
                                         
                                        
        } else {
          
          this.setCellColor(i, j, color (parseInt(rawData [cols*j+i])));
        }
        
      }
    }
  }
    void update (String data) {
     String rawData[] = data.split(" ");
     
     int currentStep = 0; 
     int currentIndex = 0;
     
    for (int j = 0; j < rows; j++) {
      
      currentStep = j * cols* bytePerPixel;
      
      for (int i = 0; i < cols; i++) {
        
        currentIndex = currentStep + i;
        
        if (bytePerPixel == 3) {
          
          //this.setCellColor(i, j, color (0, 0, 0)); // B
          
          int R = int(rawData [currentIndex]);
          int G = int(rawData [currentIndex + 1]);
          int B = int(rawData [currentIndex + 2]);
          
          this.setCellColor(i, j, color (R, G, B));
          
          //print ("Index : " + currentIndex + " : " + R + " " + G + " " + B + "-");
                                         
                                        
        } else {
          
          this.setCellColor(i, j, color (parseInt(rawData [currentIndex])));
        }
        
      }
    }
  }
  
  void update (byte [] data) {
    int nbValues = data.length;
    
    if (nbValues >= cols * rows) {
      for (int j = 0; j < rows; j++) {
      
        for (int i = 0; i < cols; i++) {

          
          if (bytePerPixel == 3) {
            int r = data[j * cols + i++] & 0xFF;
            int g = data[j * cols + i++] & 0xFF;
            int b = data[j * cols + i] & 0xFF;
            
            this.setCellColor(i, j, color (r, g, b));
          } else {
            int currentIndex = j * cols + i;
            color c = data[currentIndex] & 0xFF;
            
            this.setCellColor(i, j, color (c));
          }
        }
      }
    }
  }
  
  void clear () {
    clear (color (0));
  }
  
  void clear (color c) {
    for (int j = 0; j < cells.size(); j++) {
      for (int i = 0; i < cells.get(j).size(); i++) {
        Cell current = cells.get(j).get(i);
        
        current.setFillColor(c);
      }
    }
  }
  
}