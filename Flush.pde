class Flush implements Command {
  Display display;
  
  Flush (Display d) {
    display = d;
  }
  
  void execute() {
    display.flushQueue();
  }
  
  public void execute(Display d, JSONData jd){
  }
}