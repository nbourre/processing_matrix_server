class Resume implements Command {

  
  Resume () {
    
  }
  
  
  void execute(Device d,JSONData jd) {
    d.setPause(false);
  }
  

  
}