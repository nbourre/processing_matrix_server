class Resume implements Command {
  Display d;
  
  Resume (Display d) {
    this.d = d;
  }
  
  
  void execute() {
    d.setPause(false);
  }
  
  public void execute(Display d, JSONData jd){
  }
}