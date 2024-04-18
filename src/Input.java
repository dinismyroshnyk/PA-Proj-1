import java.util.Scanner;

public class Input {
    private static Scanner scanner;

    private static Scanner getScanner() {
        if (scanner == null) {
            scanner = new Scanner(System.in);
        }
        return scanner;
    }

    public static String readLine() {
        try {
            return getScanner().nextLine();
        } catch (Exception e) {
            System.out.println("Error reading input.");
            System.out.println("Exception: " + e);
            return null;
        }
    }

    public static char readChar() {
        try {
            return getScanner().next().charAt(0);
        } catch (Exception e) {
            System.out.println("Error reading input.");
            System.out.println("Exception: " + e);
            return '\0';
        }
    }

    public static boolean hasNextInt() {
        try {
            return getScanner().hasNextInt();
        } catch (Exception e) {
            System.out.println("Error reading input.");
            System.out.println("Exception: " + e);
            return false;
        }
    }

    public static void closeScanner() {
        if (scanner != null) {
            scanner.close();
            scanner = null;
        }
    }
}
