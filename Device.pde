/**
  Représente un périphérique physique tel un moniteur ou un téléphone.
*/

class Device {
  Map < String, Display > displayMap;
  Set listKeysDisplayMap; //lyne
  Iterator itDisplayMap; //lyne
  boolean on = false; // a voir pour ne pas ajouter de matrice sur off? ou ne pas tourner pour rien
  // un device peut avoir sa fenetre séparee en plusieurs display 
  String name; //lyne pour afficher sur ecran pour faire les commandes
  boolean pause;

  // Message pour afficher du texte à l'écran
  Message msg; // Message à afficher à l'écran
  int messageAcc = 0; // Variable pour afficher des messages.

  Device(String _name) {
    name = _name;
    
    
    msg = new Message ("Démarrage");
    msg.setVisibility(true);
    msg.displayLength = 5000;
    
    InitDisplayMap();
    pause = false;
    
    
  }

  void InitDisplayMap() {
    displayMap = new HashMap < String, Display > ();

    displayMap.put("0", new Display("0")); // attention , gerer les dimension a partir du device si plusieurs
  }
  
  void run(int deltaTime) {
    
    if (pause) return;
    
    displayMap.get("0").run(); // ne faire qu'un seul affichage par fenetre pour le depart // comment prendre le premier?
    
    displayMessage(deltaTime);
    
  }

  void pushData( JSONData jd) {
    displayMap.get(jd.display).pushData(jd); // try catch
    // displayMap.get("di1").pushData(jd); // pour tester 
  }
  
  
  void displayMessage (int deltaTime) {
    if (msg.getText() != "") {
      
      msg.update(deltaTime);
      msg.show();
    }
  }
  
  
  void showMessageText (String text) {
    msg.setText(text);
    msg.setVisibility(true);
  }
  
  void showMessageText (String text, int time) {
    msg.setDisplayLength (time);
    msg.setText(text);
    msg.setVisibility(true);
  }

  void flushQueue(JSONData jd) {
    displayMap.get(jd.display).flushQueue(); // try catch
  }

  void clear() {
    //mat.clear();
  }
  
  boolean getPause() {

    return pause;
  }
  
  void setPause(boolean value) {
    // Parcourir les clés et faire run pour tous device;
    listKeysDisplayMap = displayMap.keySet(); // Obtenir la liste des clés
    itDisplayMap = listKeysDisplayMap.iterator();
    while (itDisplayMap.hasNext()) {
      Object key = itDisplayMap.next(); //ajouter try catch
      displayMap.get(key).setPause(value);

    }
    pause = value;

  }
}
