class Display {
  ArrayList <Matrix> matrices;
  Matrix mat;
  
  int currentMatIndex = 0;
  
  HashMap map;
  
  int displayInterval = 250;
  int displayAcc = 0;
  int previousTime = 0;
  
  int matWidth = 64;
  int matHeight = 64;
  
  boolean pause = false;
  
  Display() {
    
    background(50);
    fill (200);
    
    matrices = new ArrayList<Matrix>();
    
    mat = new Matrix(matWidth, matHeight);

  }  
  
  void run () {
     float delta = millis() - previousTime;
     previousTime = millis();
    
     update(delta);
     show();
  }
  
  void update(float deltaTime) {
    displayAcc += deltaTime;
    
    if (pause) return;
    
    if (matrices.isEmpty()) {
      displayInterval = mat.interval;
      if (displayAcc >= displayInterval) {
        // Gestion du temps
        displayAcc = 0;
        
        // Action
        mat.randomize();
      }
    } else {
      if (displayAcc >= displayInterval) {
        // Gestion du temps
        displayAcc = 0;
        displayInterval = matrices.get(currentMatIndex).interval;
        
        // Action
        currentMatIndex = currentMatIndex % matrices.size() + 1;
      }
    }
  }
  
  void show() {
    background(0);
    
    if (matrices.isEmpty()) {
      mat.display();
    } else {
      matrices.get(currentMatIndex).display();
    }    
  }
  
  void addMatrix(Matrix m) {
    matrices.add(m);
  }
  
  void removeMatrix(int index) {
    matrices.remove(index);
  }
  
  void flushQueue() {
    matrices.clear();
  }
  
  void clear () {
    mat.clear();
  }
  
  void setPause (boolean value) {
    this.pause = value;
  }
}