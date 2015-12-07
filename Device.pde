class Device {
  Map < String, Display > displayMap;
  Set listKeysDisplayMap; //lyne
  Iterator itDisplayMap; //lyne
  boolean on = false; // a voir pour ne pas ajouter de matrice sur off? ou ne pas tourner pour rien
  // un device peut avoir sa fenetre séparee en plusieurs display 
  String name; //lyne pour afficher sur ecran pour faire les commandes
  boolean pause;


  Device(String _name) {
    name = _name;
    InitDisplayMap();
    pause = false;

  }

  void InitDisplayMap() {
    displayMap = new HashMap < String, Display > ();

    displayMap.put("di1", new Display("di1")); // attention , gerer les dimension a partir du device si plusieurs
  }
  
  void run() {
    if (pause) return;
    displayMap.get("di1").run(); // ne faire qu'un seul affichage par fenetre pour le depart // comment orendre le premier?
  }

  void pushData(String display, JSONData jd) {
    displayMap.get(display).pushData(jd); // try catch
    // displayMap.get("di1").pushData(jd); // pour tester 
  }





  void flushQueue(String display) {
    displayMap.get(display).flushQueue(); // try catch
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