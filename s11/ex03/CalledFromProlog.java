import java.io.*;

public class CalledFromProlog {
    // "Protocol" :    Request             Output
    //                 -------             ------
    //                 "square" \n int     int
    //                 "bye"               -

    public static void main(String[] args) throws IOException {
        BufferedReader kbd = new BufferedReader(new InputStreamReader(System.in));
        String line = kbd.readLine();

        while(!line.equals("bye")) {         // termination request
            if (line.equals("square")) {       // kind of request
                line = kbd.readLine();           // read arguments
                int x = Integer.parseInt(line);
                int y = square(x);               // compute
                System.out.println(y);           // write result
                System.out.flush();
            }
            line =  kbd.readLine();
        }
    }

    public static int square(int x) {
        return x*x;
    }

}