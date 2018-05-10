package kh10.image;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.JdbcUtil;

public class Sequencer {
	
	public synchronized static int nextId(Connection conn, String tableName)
	throws SQLException {
		PreparedStatement pstmtSelect = null;
		ResultSet rsSelect = null;
		
		PreparedStatement pstmtUpdate = null;
		
		try {
			pstmtSelect = conn.prepareStatement("select message_id from id_sequences66 where table_name = ?");
			pstmtSelect.setString(1, tableName);
			
			rsSelect = pstmtSelect.executeQuery();
			
			if(rsSelect.next()) {
				int id = rsSelect.getInt(1);
				id++;
				
				pstmtUpdate = conn.prepareStatement("update id_sequences66 set message_id = ? where table_name= ?");
				pstmtUpdate.setInt(1, id);
				pstmtUpdate.setString(2, tableName);
				pstmtUpdate.executeQuery();
				return id;
			}else {
				pstmtUpdate = conn.prepareStatement("insert into id_sequences66 values (?, ?)");
				pstmtUpdate.setString(1, tableName);
				pstmtUpdate.setInt(2, 1);
				pstmtUpdate.executeQuery();
				
				return 1;
			}
		} finally {
			JdbcUtil.close(rsSelect);
			JdbcUtil.close(pstmtSelect);
			JdbcUtil.close(pstmtUpdate);
		}
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
