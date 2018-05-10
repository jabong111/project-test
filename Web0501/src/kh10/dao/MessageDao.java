package kh10.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import util.JdbcUtil;
import kh10.model.Message;
//dao는 dbbean과 같이 데이터베이스에 접근하여 값을 가져오고 넣고 하기위한 클래스  추상클래스를 이용하여 dao설정
public abstract class MessageDao {	
	public abstract int insert(Connection conn, Message message) throws SQLException;
	
	public Message select(Connection conn, int messageId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String sql = "select * from guestbook_message_jabong111 where message_id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, messageId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return makeMessageFromResultSet(rs);
			}else {
				return null;
			}
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	
	public Message makeMessageFromResultSet(ResultSet rs) throws SQLException{
		Message message = new Message();
		message.setId(rs.getInt("message_id"));
		message.setGuestName(rs.getString("guest_name"));
		message.setPassword(rs.getString("password"));
		message.setMessage(rs.getString("message"));
		return message;
	}
	
	//기존 DBBean클래스 DAO는 conn = getConnection()을 통해 메서드마다 connection을 설정해줬다.
	public int selectCount(Connection conn) throws SQLException{
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select count(*) from guestbook_message_jabong111");
			rs.next();
			return rs.getInt(1);
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}
	
	public abstract List<Message> selectList(Connection conn, int firstRow, int endRow) throws SQLException;
	
	public int delete(Connection conn, int messageId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "delete from guestbook_message_jabong111 where message_id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, messageId);
			return pstmt.executeUpdate();
			
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	

}






















