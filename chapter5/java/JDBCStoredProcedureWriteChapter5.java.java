import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class JDBCStoredProcedureWriteChapter5 {

    public static void main(String[] args) {
            Connection connection = null;
            CallableStatement statement = null;
            String action_message = "Hello from Java";
            String code_location = "In Java";
            try {
                connection = DBConnection.getConnection();
                statement = connection.prepareCall("{call PACKAGE1.LOG_ACTION(?, ?)}");
                statement.setString("action_message", action_message);
                statement.setString("code_location", code_location);
                statement.executeUpdate();
                System.out.println("Successful call");
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (!statement.isClosed()) {
                        statement.close();
                    }
                    if (!connection.isClosed()) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
}
