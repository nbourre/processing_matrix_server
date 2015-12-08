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
//String ipAddress = "10.10.50.65";

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
  
  json.setString ("command", "pushData");
  c.write(json.toString() + "~");
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
    
    if (key == 's') {
      json.setString ("command", "pushData");
      c.write(json.toString() + "~");
    }
    
    if (key == 'q') {
      exit();
    }
    
    if (key == 'f') {
      json.setString ("command", "flush");
      c.write(json.toString() + "~");
    }
  }
}

void buildArray() {
  String data = "";
  int bpp = 3;
  
  for(int j = 0; j < matrixHeight; j++){
   int vStep = j * matrixWidth * 3;
   for(int i = 0; i < matrixWidth; i++){
     
     int R = int(float(i) / matrixWidth * 255); // Valeur entre 0 et 1
     int G = int(float(i * j) / maxIndex * 255) ; // Valeur entre 0 et 1
     int B = int(float(j) / matrixHeight * 255); // Valeur entre 0 et 1
     
     data += R + " "; // R
     data += G + " "; // G
     data += B + " "; // B
     /**
     if ( i == matrixWidth / 2) {
       data += 255 + " "; // R
       data += 255 + " "; // G
       data += 255 + " "; // B

     } else {
       data += 0 + " ";
       data += 0 + " ";
       data += 0 + " ";
     }
     
     */
   }   
  }
  
  json.setInt("bytePerPixel", bpp);
  json.setString("data",data);
  
  json.setInt ("cols", matrixWidth);
  json.setInt ("rows", matrixHeight);
  
  println ("Array built");
  println ("command : " + json.getString("command"));
  
  println ("Nb Elements = " + data.split(" ").length);
  
  //println (json.toString());
}