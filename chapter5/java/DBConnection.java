import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_DRIVER_CLASS = "oracle.jdbc.driver.OracleDriver";
    private static final String DB_USERNAME = "HR";
    private static final String DB_PASSWORD = "hrpass";

    public static Connection getConnection() {
        Connection connectionn = null;
        try {
            // Load the Driver Class
            Class.forName(DB_DRIVER_CLASS);

            // Create the connection
            connectionn = DriverManager.getConnection(
                    // Connect to Oracle using a SID
                    "jdbc:oracle:thin:@localhost:1521:OraDoc", DB_USERNAME, DB_PASSWORD);
            // Connect to Oracle using a service name
//                    "jdbc:oracle:thin:@localhost:1521/ORCLCDB.localdomain", DB_USERNAME, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connectionn;
    }
}
