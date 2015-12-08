class PushData implements Command {
  Display d;
  
  PushData () {
    
  }
  
  // TODO : Comment pousser de la données
  
  
  public void execute(Device d, JSONData jd){
                 
            println ("pushdata : " + jd.command + jd.device);
          d.pushData(jd.display,jd); }
}