public class Main {

  /**
   * Runs the scanner on input files.
   *
   * This is a standalone scanner, it will print any unmatched
   * text to System.out unchanged.
   *
   * @param argv   the command line, contains the filenames to run
   *               the scanner on.
   */
  public static void main(String argv[]) {
    if (argv.length == 0) {
      System.out.println("Usage : java PCATScanner <inputfile(s)>");
      exit -1;
    }

    int firstFilePos = 0;
    String encodingName = "UTF-8";
    try {
          java.nio.charset.Charset.forName(encodingName); // Side-effect: is encodingName valid?
        }
        catch (Exception e) {
          System.out.println("Invalid encoding '" + encodingName + "'");
          return;
        }

        for (int i = firstFilePos; i < argv.length; i++) {
          PCATScanner scanner = null;
          try {
            java.io.FileInputStream stream = new java.io.FileInputStream(argv[i]);
            java.io.Reader reader = new java.io.InputStreamReader(stream, encodingName);
            scanner = new PCATScanner(reader);
            while ( !scanner.zzAtEOF ) scanner.next_token();
          }
          catch (java.io.FileNotFoundException e) {
            System.out.println("File not found : \""+argv[i]+"\"");
          }
          catch (java.io.IOException e) {
            System.out.println("IO error scanning file \""+argv[i]+"\"");
            System.out.println(e);
          }
          catch (Exception e) {
            System.out.println("Unexpected exception:");
            e.printStackTrace();
          }
        }
      }
    }

  }
