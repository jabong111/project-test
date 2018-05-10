package kh10.jdbc.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
//기존사용법 conn = getConnection();을 사용해서 계속 사용 
public class ConnectionProvider {	
	public static Connection getConnection() throws SQLException{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}

}
