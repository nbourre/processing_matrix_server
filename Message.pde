class Message { //<>//
  String text;
  
  int displayLength; // Durée pour afficher le message
  int displayAcc = 0;
  
  int alphaInterval = 50;
  int alphaAcc = 0;
  
  int alpha = 255;
  float alphaUpdate = 1f / (2000 / alphaInterval);
  
  boolean visible = false; // Indique si le message est visible
  boolean startFading = false; // Une fois que la durée d'affichage est dépassé. On débute le fondu.
  
  int backgroundPaddingX = 50; // Espace entre le texte et l'arrière-plan
  int backgroundPaddingY = 60; // Espace entre le texte et l'arrière-plan
  
    
  Message (String text) {
    this.text = text;
    
    this.displayLength = 5000; // 5 secondes
  }
  
  Message (String text, int displayLength) {
    this.text = text;
    this.displayLength = displayLength;
  }
  
  void setText (String text) {
    this.text = text;
  }
  
  String getText () {
    return this.text;
  }
  
  void setVisibility (boolean show) {
    this.visible = show;
    this.alpha = 255;
    
    println ("Setting visibility to : " + show);
  }
  
  void setDisplayLength (int displayLength) {
    this.displayLength = displayLength;
  }
  
  /**
  * @deltaTime : Différence de temps depuis le dernier appel
  */
  
  void update (int deltaTime) {
    
    
    if (!this.visible) {
      return;
    }
    
    displayAcc += deltaTime;
    alphaAcc += deltaTime;
    

    
    if (startFading) {
      
      if (alphaAcc >= alphaInterval) {
        alphaAcc = 0;
        
        if (alpha < 1) {
          this.visible = false;
          alpha = 255;
          startFading = false;        
        } else {
          alpha *= (1f - alphaUpdate);
           //<>//
        }
      }    
    } else {
        if (displayAcc >= displayLength) {
          displayAcc = 0;
          alpha = 255;
          startFading = true; 
        }
    }
  }
  
  void show () {
   if (!this.visible) {
     return;
   }
   
   if (this.text == "" || this.text == null) return;
   
   
   
   textSize (32);
   
   int txtWidth = int(textWidth(this.text));
   
   noStroke();
  
   
   // fond
   pushMatrix();
   
   // Arrière-plan
   translate (width / 2 - txtWidth / 2 - backgroundPaddingX, height / 2 - backgroundPaddingY);
   
   fill (50, alpha);
   rect (0, 0, txtWidth + 2 * backgroundPaddingX, 100, 7);
     
   // Texte
   translate (backgroundPaddingX, backgroundPaddingY);

   fill (200, 0, 0, alpha);
   text (this.text, 0, 0);
   
   popMatrix();
  }
}