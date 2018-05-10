package kh10.dao.oracle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import kh10.dao.MessageDao;
import kh10.model.Message;
import util.JdbcUtil;

//MessageDao는 추상 클래스로서 OracleMessageDao클래스는 이를 상속받고 추상메서드들을 정의해준다.
//오라클에서만 사용할수 있는 쿼리문을 설정해주기 위해서.

public class OracleMessageDao extends MessageDao{
	public  int insert(Connection conn, Message message) throws SQLException{
		PreparedStatement pstmt = null;
		String sql = "insert into guestbook_message_jabong111(message_id, guest_name, password,message)"
				+ " values(message_id_seq_jabong111.nextval,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, message.getGuestName());
			pstmt.setString(2, message.getPassword());
			pstmt.setString(3, message.getMessage());
			return pstmt.executeUpdate();
		}finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	
	public List<Message> selectList(Connection conn, int firstRow, int endRow) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Message> messageList = null;
		String sql = "select message_id, guest_name, password, message from ( "
				+ "select rownum rnum, message_id, guest_name, password, message from ("
				+ " select * from guestbook_message_jabong111 m order by m.message_id desc"
				+ " ) where rownum <= ?"
				+ ") where rnum >= ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				messageList = new ArrayList<Message>();
				do {
					messageList.add(super.makeMessageFromResultSet(rs));	//MessageDao
																			//를 상속받아서 
																		//셀렉트로 찾아온 디비데이터를 디비빈에 넣고 디비빈을  리스트에 저장한다. 
				}while(rs.next());
				return messageList;
			}else {
				return Collections.emptyList();
			}
		}finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
	}

}























