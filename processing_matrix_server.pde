import processing.net.*;
import java.util.Map;
import java.util.Set; //lyne
import java.util.Iterator; //lyne
//Display display;lyne

Server server;

// TEST de commentaire
// Commentaire #2 Nick
// Test lamyot
// Bixk 4

int port = 32999;

JSONData json; 
String data;

byte [] values;

Map <String, Command> commandMap;
Map <String, Device>  deviceMap;   //lyne  plusieurs peripheriques possible
Set listKeysDeviceMap;//lyne
Iterator itDeviceMap;//lyne

int dataInterval = 50;
int dataAcc = 0;
int deltaTime = 0;
int previousTime = 0;
  int cpt=1;//test
void setup() {
  //fullScreen();
  size (640, 480);

  server = new Server (this, port);
  
  //display = new Display();  lyne maintenant un map de device et le device va crer ses display
  
  initCommandMap();
  initDeviceMap();
 
}

void draw () {
  deltaTime = millis() - previousTime;
  previousTime = millis();
  
  Client client = server.available();
  
  if ( client != null) {
    dataAcc += deltaTime;
    
   
    if (dataAcc >= dataInterval) {
      dataAcc = 0;    
      
      //data = client.readString();
      data = client.readStringUntil('~');
      
      if (data != null) {
        data = data.replaceAll("~", "");
        // test
        
       
        println (data);

        json = new JSONData(data);
       
        if (json.command != null) {
          println("command : " + json.command);
            println ("pushdata : " + json.command + json.device);
            // pourrait-on avoir un objet qui contient tout le jason sauf la string de départ pour passer à execute?
          commandMap.get(json.command).execute(  deviceMap.get(json.device), json); //ajouter des try catch
          
        } else {
          println ("unknown command : " + json.command);
        }
        
        data = null;
        client.clear();
      }
    }
  }
  
 // display.run();
    // listKeysDeviceMap=deviceMap.keySet();  // Obtenir la liste des clés
    // itDeviceMap=listKeysDeviceMap.iterator();
        // Parcourir les clés et faire run pour tous device;
      //  while( itDeviceMap.hasNext())
      //  {
      //    Object key=  itDeviceMap.next(); //ajouter try catch
      //    DeviceMap.get(key);
     //   }
      
    deviceMap.get("d1").run();
}
 //<>//
void initCommandMap () {
  commandMap = new HashMap<String, Command>(); //<>//
  
  commandMap.put("flush", new Flush());
  commandMap.put("pause", new Pause());
  commandMap.put("resume", new Resume());  
  commandMap.put("pushdata", new PushData());  
}
void initDeviceMap () {
  deviceMap = new HashMap<String, Device>();
  
  deviceMap.put("d1", new Device("d1"));// attention , comment savoir si on peut en ajouter?
 
}
void keyPressed() {
  if (key == ' ') {
     deviceMap.get("d1").setPause(!( deviceMap.get("d1").getPause()));
    //display.pause = !display.pause;
  }
  
   if (key == 'p') {
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
    //        println ("pushdata : " + json.command + json.device);
     //     commandMap.get("pushdata").execute(  deviceMap.get("d1"), json); //ajouter des try catch pour tests direct
          
     //   } else {
     //     println ("unknown command : " + json.command);
      //  }
   }
}



void serverEvent (Server s, Client c) {
  println ("Nouveau client : " + c.ip());

}