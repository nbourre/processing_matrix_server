import java.util.Map;
import java.util.Stack;


class JSONData {
  String jsonString;
  JSONObject json;
  
  String command;
  String args[];
  String data;
  int bytePerPixel;
  int rows;
  int cols;
  String device;
  String display;
  
  JSONData (String js) {
    this.jsonString = js;
    
    this.json = JSONObject.parse(js);
    
    interpret();
  }
  
  void interpret () {
    
    args = json.hasKey("command") ? json.getString("command").split(" ") : null;
    
    command = args != null ? args[0] : null;

    
   //lyne
    device = json.hasKey ("device") ? json.getString("device") : "0";
    display = json.hasKey ("display") ? json.getString("display") : "0";

    data = json.hasKey ("data") ? json.getString("data") : null;
    
    bytePerPixel = json.hasKey ("bytePerPixel") ? json.getInt("bytePerPixel") : 1;
    
    rows = json.hasKey ("rows") ? json.getInt("rows") : 0;
    cols = json.hasKey ("cols") ? json.getInt("cols") : 0;
    
    if (data != null)
      println (data.toString());
  }  
  
  JSONObject getJSONObject () {
    return json;
  }
}