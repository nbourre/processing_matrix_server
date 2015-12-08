
class Message {
  // Src : http://stackoverflow.com/questions/18571223/how-to-convert-java-string-into-byte
  // String string = new String(byte[] bytes, Charset charset);
  
  byte content[];
  String contentAsString;
  JSONObject json;
  
  String commandAsString;
  String values;  
  
  String keyData = "data";
  String keyCommand = "command";
      
  Message (byte bytes[]) {
    content = bytes;
    contentAsString = new String (content);
    json = JSONObject.parse(contentAsString); 
  }
  
  void parseContent() {
    commandAsString = json.hasKey(keyCommand) ? json.getString(keyCommand) : null;
    values = json.hasKey (keyData) ? json.getString(keyData) : null;
  }
  
  
 
  
}