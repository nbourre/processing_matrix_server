import processing.net.*;
import java.util.Map;

Display display;

Server server;

// TEST de commentaire

int port = 32999;

JSONData json; 
String data;

byte [] values;

Map <String, Command> commandMap;

int dataInterval = 50;
int dataAcc = 0;
int deltaTime = 0;
int previousTime = 0;

void setup() {
  //fullScreen();
  size (640, 480);

  server = new Server (this, port);
  
  display = new Display();
  
  initCommandMap();
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
        
        println (data);

        json = new JSONData(data);
        
        if (json.command != null) {
          println("command : " + json.command);
          commandMap.get(json.command).execute();
          
        } else {
          println ("unknown command : " + json.command);
        }
        
        data = null;
        client.clear();
      }
    }
  }
  
  display.run();
}

void initCommandMap () {
  commandMap = new HashMap<String, Command>(); //<>//
  
  commandMap.put("flush", new Flush(display));
  commandMap.put("pause", new Pause(display));
  commandMap.put("resume", new Resume(display));  
}

void keyPressed() {
  if (key == ' ') {
    display.pause = !display.pause;
  }
}

void serverEvent (Server s, Client c) {
  println ("Nouveau client : " + c.ip());

}