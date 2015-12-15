import processing.net.*;
import java.util.Map;
import java.util.Set; //lyne
import java.util.Iterator; //lyne

static final String UNKNOWN_COMMAND = "unknown";
static final String DEFAULT_DEVICE = "0";

Server server;

int port = 32999;

JSONData json;
String data;

byte[] values;

Map < String, Command > commandMap;
Map < String, Device > deviceMap; //lyne  plusieurs peripheriques possible
Set listKeysDeviceMap; //lyne
Iterator itDeviceMap; //lyne

int dataInterval = 50;
int dataAcc = 0;
int deltaTime = 0;
int previousTime = 0;

void setup() {
  //fullScreen();
  size(640, 480);

  server = new Server(this, port);

  initCommandMap();
  initDeviceMap();

}

void draw() {
  deltaTime = millis() - previousTime;
  previousTime = millis();

  Client client = server.available();

  if (client != null) {
    dataAcc += deltaTime;


    if (dataAcc >= dataInterval) {
      dataAcc = 0;

      data = client.readStringUntil('~'); // Le ~ permet d'indiquer au serveur la fin des données envoyé par le client

      if (data != null) {
        data = data.replaceAll("~", "");

        json = new JSONData(data);

        if (json.command != null) {
          println ("Nb elements : " + json.data.split (" ").length);
          // pourrait-on avoir un objet qui contient tout le jason sauf la string de départ pour passer à execute?
          Command cmd = commandMap.get(json.command);
          
          /* On capture la commande null ici */
          if (cmd == null) {
            cmd = commandMap.get(UNKNOWN_COMMAND);
          } 
          
          cmd.execute(deviceMap.get(json.device), json); //ajouter des try catch
            

        } else {
          println("unknown command : " + json.command);
        }

        data = null;
        client.clear();
      }
    }

  }


  // listKeysDeviceMap=deviceMap.keySet();  // Obtenir la liste des clés
  // itDeviceMap=listKeysDeviceMap.iterator();
  // Parcourir les clés et faire run pour tous device;
  //  while( itDeviceMap.hasNext())
  //  {
  //    Object key=  itDeviceMap.next(); //ajouter try catch
  //    DeviceMap.get(key);
  //   }

  deviceMap.get(DEFAULT_DEVICE).run(); // en placer un par défaut dans le jdson
}

//<>//
void initCommandMap() {
  commandMap = new HashMap < String, Command > (); //<>//
  //<>// //<>//
  commandMap.put("flush", new Flush());
  commandMap.put("pause", new Pause()); //<>// //<>//
  commandMap.put("resume", new Resume());
  commandMap.put("pushData", new PushData());
  commandMap.put(UNKNOWN_COMMAND, new UnknownCommand());
}


void initDeviceMap() {
  deviceMap = new HashMap < String, Device > ();

  deviceMap.put(DEFAULT_DEVICE, new Device(DEFAULT_DEVICE)); // attention , comment savoir si on peut en ajouter?
}



void keyPressed() {
  if (key == ' ') {
    deviceMap.get(DEFAULT_DEVICE).setPause(!(deviceMap.get(DEFAULT_DEVICE).getPause()));
    //display.pause = !display.pause;
  }

  if (key == 'p') {

     println ("pushdata : " );
    // JSON minimal
    JSONObject jsonObj = new JSONObject();
    jsonObj.setString("command", "pause");
    
    json = new JSONData(jsonObj.toString());
    

    // TEST DE LA COMMANDE
    // String jsonstring = "{pushdata } ";//" {""command"" : ""pushdata"", ""device"": ""d1"",""display"" : ""di1"", ""bytePerPixel"" : 1,""rows"": 57,""cols"" : 1, ""data"" : ""1 0 1 0 1 0 1 0 1 0 1 0"" }";
    //String jsonstring = " {""command"" : ""pushdata"", ""device"": ""d1"",""display"" : ""di1"", ""bytePerPixel"" : 1,""rows"": 57,""cols"" : 1, ""data"" : ""1 0 1 0 1 0 1 0 1 0 1 0"" }";
    //   json = new JSONData( jsonstring );
    // test 


    //    json.command="pushdata";
    //     json.device="d1";
    //    json.cols=1;
    //   json.rows=1;
    //    json.display="di1";
    //   json.data="1 0 1 0 0 0 1 1 1 ";

    //    if (json.command != null) {
    //     println("command : " + json.command);
            println ("pushdata : " + json.command );
        commandMap.get("pushdata").execute(  deviceMap.get(DEFAULT_DEVICE), json); //ajouter des try catch pour tests direct

    //   } else {
    //     println ("unknown command : " + json.command);
    //  }
  }
}



void serverEvent(Server s, Client c) {
  println("Nouveau client : " + c.ip());

}