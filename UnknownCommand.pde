
class UnknownCommand implements Command {
  
  UnknownCommand () {
  }
  
  
  void execute() {
    println ("Unknown command!");
  }
  
  public void execute(Device d, JSONData jd){
    println ("Unknown command!");
    
    //d.displayMap.at.setText (jd.command);
  }
}