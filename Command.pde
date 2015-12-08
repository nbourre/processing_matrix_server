import java.util.Map;

interface Command {
    
    //public void execute();
    public void execute(Device d, JSONData jd);
}