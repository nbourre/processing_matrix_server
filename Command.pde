import java.util.Map;

interface Command {
    
    public void execute();
    public void execute(Display d, JSONData jd);
}