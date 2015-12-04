class Pause implements Command {
  Display d;
  
  Pause (Display d) {
    this.d = d;
  }
  
  
  void execute() {
    d.setPause(true);
  }
  
  public void execute(Display d, JSONData jd){
  }
}