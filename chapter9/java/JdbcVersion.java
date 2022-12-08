import oracle.jdbc.datasource.impl.OracleDataSource;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;

class JDBCVersion
{
    public static void main (String args[]) throws SQLException
    {
        OracleDataSource oracleDataSource = new OracleDataSource();
        oracleDataSource.setURL("jdbc:oracle:thin:@localhost:1521:OraDoc");
        oracleDataSource.setUser("HR");
        oracleDataSource.setPassword("hrpass");
        Connection connection = oracleDataSource.getConnection();

        // Create Oracle DatabaseMetaData object
        DatabaseMetaData metaData = connection.getMetaData();

        // gets driver info:
        System.out.println("JDBC driver version: " + metaData.getDriverVersion());
        System.out.println("Driver name: " + metaData.getDriverName());
        System.out.println("Database Product Name: " + metaData.getDatabaseProductName());
        System.out.println("Database Major Version: " + metaData.getDatabaseMajorVersion());
        System.out.println("Database Minor Version: " + metaData.getDatabaseMinorVersion());
        System.out.println("allProceduresAreCallable: " + metaData.allProceduresAreCallable());
    }
}
