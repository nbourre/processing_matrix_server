class Pause implements Command {
  
  
  Pause () {
 
  }
  
  
  void execute(Device d, JSONData jd) {
    d.setPause(true);
  }
  
  
}