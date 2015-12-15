
class Message {
  String text;
  
  int displayLength; // Durée pour afficher le message
  int displayAcc = 0;
  
  int alphaInterval = 50;
  int alphaAcc = 0;
  
  int alpha = 255;
  float alphaUpdate = 1f / (2000 / alphaInterval);
  
  boolean visible = false;
    
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
  }
  
  /**
  * @deltaTime : Différence de temps depuis le dernier appel
  */
  
  void update (int deltaTime) {

    
    if (!visible) {
      return;
    }
    
    displayAcc += deltaTime;
    alphaAcc += deltaTime;
    
    if (displayAcc >= displayLength) {
      displayAcc = 0;
      visible = false;
      alpha = 255;
    }
    
    if (alphaAcc >= alphaInterval) {
      alphaAcc = 0;
      alpha *= alphaUpdate;
    }    
  }
  
  void show () {
   if (!visible) return;
   
   if (this.text == "" || this.text == null) return;
   
   textSize (32);
   
   int txtWidth = int(textWidth(this.text));
   
   fill (200, 0, 0, alpha);
   text (this.text, width / 2 - txtWidth / 2, height / 2);
  }
}