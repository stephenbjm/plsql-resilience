import oracle.jdbc.OracleResultSet;

import java.math.BigDecimal;
import java.sql.*;
import java.util.Map;

public class JDBCStoredProcedureWrite {

/*    public void callPlSqlFunction() {
        Connection connection = null;
        ResultSet rs=null;
        CallableStatement stmt=null;
        Chellan_Rec rec = null;
        try{

            String sqlQuery = "{call get_chellan(?,?)}";

            //map plsql type to Java type
            Map m = connection.getTypeMap();
            m.put("schema_name.chellan_rec", Class.forName("some_java_package.Chellan_Rec"));//this maps the Java class to the Oracle custom type
            connection.setTypeMap(m);

            stmt=connection.prepareCall(sqlQuery);
            stmt.registerOutParameter(1, Types.STRUCT, "chellan_rec");
            stmt.setObject(2, fooNum);
            stmt.execute();

            rec = (Chellan_Rec)stmt.getObject(1);

        }catch(Exception e){
            //log the exception;
        }
    }*/

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
