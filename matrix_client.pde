import processing.net.*;

Client c;

int matrixWidth = 64;
int matrixHeight = 64;

int maxIndex = matrixWidth * matrixHeight;

byte values[];

JSONObject json;

String jsonString = "";


int messageInterval = 50;
int messageAcc = 0;

int previousTime = 0;
int deltaTime = 0;

String ipAddress = "127.0.0.1";
//String ipAddress = "192.168.0.200";

int port = 32999;

boolean pause = false;
boolean sent = false;

void setup() { 
  size(450, 255);
  background(204);
  stroke(0);
  frameRate(30);
  c = new Client(this, ipAddress, port);
  
  values = new byte[matrixHeight * matrixWidth];
  json = new JSONObject();
  
  json.setString("command", "resume");
  
  buildArray();
  
}

void draw(){
  deltaTime = millis() - previousTime;
  previousTime = millis();
  
  messageAcc += deltaTime;
  
}

void keyPressed() {
  println ("keyPressed"); //<>//
  if (messageAcc >= messageInterval) {
    messageAcc = 0;
    
    if (key == 'p' || key == 'P') {
      pause = !pause;
      println ("Pause = " + pause);
      if (pause)
        json.setString("command", "pause");
      else
        json.setString("command", "resume");
      
      if (c.active()) {
        println ("command : " + json.getString("command"));
        c.write(json.toString() + "~");
      }    
    }
    
    if (key == 'r') {
      println ("Running client");
      c.run();
    }
    
    if (key == 'q') {
      exit();
    }
  }
}

void buildArray() {
  String data = "";
  for(int j = 0; j < matrixHeight; j++){
   int vStep = j * matrixWidth;
   for(int i = 0; i < matrixWidth; i++){
     float value = float(vStep + i) / maxIndex; // Valeur entre 0 et 1
     
     if ( i == matrixWidth / 2) {
       data += 255 + " ";
       data += 255 + " ";
       data += 255 + " ";
     } else {
       data += 0 + " ";
       data += 0 + " ";
       data += 0 + " ";
     }
   }   
  }
  
  json.setInt("bytePerPixel",3);
  json.setString("data",data);
  
  
  println ("Array built");
  println (json.getString("command"));
  
  
  //println (json.toString());
}