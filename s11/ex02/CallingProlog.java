import java.io.*;

public class CallingProlog {
    static BufferedReader fromProlog;
    static PrintWriter    toProlog;

    static String INTERP_NAME = "gprolog";
    static String FILE_NAME = "square";

    public static void main (String [] args) throws IOException {
        CallingProlog.startProlog();
        System.out.println("------------------------");
        System.out.println(CallingProlog.square(3));
        System.out.println("------------------------");
        System.out.println(CallingProlog.square(6));
        System.out.println("------------------------");
        CallingProlog.closeProlog();
    }

    static int square(int n) throws IOException {
        System.out.println("Calling square of " + n);

        String cmd = "square(" + n + ", M).";

        CallingProlog.send(cmd);

        System.out.println("Reading response...");

        String line = fromProlog.readLine();

        while (!line.startsWith("M = ")) {
            line = fromProlog.readLine();
        }

        System.out.print("Got response: ");

        int res = Integer.parseInt(line.substring(4));

        return res;
    }

    public static void send(String s) throws IOException {
        CallingProlog.toProlog.println(s);
        CallingProlog.toProlog.flush();
    }

    public static void startProlog() throws IOException {
        System.out.println("Starting...");

        String [] args = {CallingProlog.INTERP_NAME};
        ProcessBuilder pb = new ProcessBuilder(args);
        pb.environment().put("LINEDIT","gui=no");

        Process prcss = null;
        try {
            prcss = pb.start();
        } catch (IOException e) {
            System.out.println("Could not run gprolog: ");
            e.printStackTrace();
        }

        CallingProlog.fromProlog = new BufferedReader(
            new InputStreamReader(prcss.getInputStream())
        );
        
        CallingProlog.toProlog = new PrintWriter(prcss.getOutputStream());

        CallingProlog.send("[" + CallingProlog.FILE_NAME + "].");
    }

    static void closeProlog() throws IOException {
        System.out.println("Stopping...");

        CallingProlog.send("halt.");

        System.out.println("Done.");
    }
}