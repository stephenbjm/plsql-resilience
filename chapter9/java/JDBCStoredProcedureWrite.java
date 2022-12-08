import oracle.jdbc.OracleResultSet;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class JDBCStoredProcedureWrite {

    public static void main(String[] args) {
        Connection connection = null;
        CallableStatement statement = null;

        String action_message = "Hello from Java";
        String code_location = "In Java";

        try {
            connection = DBConnection.getConnection();
            statement = connection.prepareCall("{call HR.LOGGINGPACKAGE.LOG_ACTION(?, ?)}");
            statement.setString("action_message", action_message);
            statement.setString("code_location", code_location);
            statement.executeUpdate();

            statement = connection.prepareCall("{call MAIN_CODE_PACKAGE.PROCESS_PROJECT_INVOKER(?)}");
            statement.setInt("project_id_in", 1);
            statement.executeUpdate();

            OracleResultSet rs = (OracleResultSet)
                    statement.executeQuery("select * from invoices");

            while(rs.next())
            {
                BigDecimal projectId = (BigDecimal) rs.getObject(1);
                System.out.println("projectId: " + projectId);
                String clientProjectId = (String) rs.getObject(2);
                System.out.println("clientProjectId: " + clientProjectId);
                BigDecimal hoursWorked = (BigDecimal) rs.getObject(3);
                System.out.println("hoursWorked: " + hoursWorked);
                BigDecimal employeeId = (BigDecimal) rs.getObject(4);
                System.out.println("employeeId: " + employeeId);
                BigDecimal payment = (BigDecimal) rs.getObject("payment");
                System.out.println("payment: " + payment);
            }

            System.out.println("Successful calls");
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
