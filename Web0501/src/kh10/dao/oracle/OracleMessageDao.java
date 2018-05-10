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

//MessageDao�� �߻� Ŭ�����μ� OracleMessageDaoŬ������ �̸� ��ӹް� �߻�޼������ �������ش�.
//����Ŭ������ ����Ҽ� �ִ� �������� �������ֱ� ���ؼ�.

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
																			//�� ��ӹ޾Ƽ� 
																		//����Ʈ�� ã�ƿ� ������͸� ���� �ְ� ������  ����Ʈ�� �����Ѵ�. 
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























