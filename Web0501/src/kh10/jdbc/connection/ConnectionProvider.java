package kh10.jdbc.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
//�������� conn = getConnection();�� ����ؼ� ��� ��� 
public class ConnectionProvider {	
	public static Connection getConnection() throws SQLException{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}

}
