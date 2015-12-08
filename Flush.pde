class Flush implements Command {
 
  
  Flush () {
   
  }
  
  void execute( Device d, JSONData jd) {
   d.flushQueue(jd.display);
  }
  
  
}