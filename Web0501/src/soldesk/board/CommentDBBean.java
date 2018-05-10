package soldesk.board;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import soldesk.board.CommentDataBean;
import util.*;

public class CommentDBBean {
	
	private static CommentDBBean instance = new CommentDBBean();
	
	public static CommentDBBean getInstance() {
		return instance;
	}
	
	private CommentDBBean() {
		
	}
	
	private Connection  getConnection() throws Exception{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	
	public void insertComment(CommentDataBean cdb,int count) throws Exception{	//count�� �ڸ�Ʈ����
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = cdb.getComment_num();	//�ڸ�Ʈ�ѹ� �ڸ�Ʈ�� � �����ϴ���. 0
		int ref = cdb.getRef();	//� ����� ������� �����ϱ����� 		1
		int re_step = cdb.getRe_step();	//ȭ�鿡 ������ ����	 0
		int re_level = cdb.getRe_level();	//������� ��ۿ�������� �������ش�. 0
		
		
		// ref=���α۰� �亯���� �����ش�.
		// re_step=ȭ����¼���
		// re_level=���α�����, �亯�������� �������ش�.  0,1
		int number = 0;
		String sql = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(comment_num) from board_comment");//�� �ڸ�Ʈ�� ��ִ��� �޾ƿ´� 7
			rs = pstmt.executeQuery();
			if(rs.next()) {
				number = rs.getInt(1)+1;	//���ο� �ڸ�Ʈ��� ���̰� 7+1
			} else {
				number = 1;	//�ڸ�Ʈ�� �������� ù���� �ڸ�Ʈ
			}
			System.out.println("number: "+number); //4
			System.out.println("num: "+num); //4
			if(num != 0) {	//�ڸ�Ʈ�� �ϳ��� ����������
				sql = "update board_comment set re_step=re_step+1 where ref=? and re_step>?";
				//���� �ִ� �ڸ�Ʈ���ڸ�� ������ 1�ø���(������ ���������� ����) 
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step+1;
				re_level = re_level+1;	//
			}else {	//���ο� �ڸ�Ʈ��
				ref = count+1; //4
				re_step = 0;
				re_level = 0;
			}
    		sql = "insert into board_comment(content_num,commenter,commentt,passwd,reg_date,ip,comment_num,ref,re_step,re_level) values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cdb.getContent_num()); //cdb.getContent_num()
			pstmt.setString(2, cdb.getCommenter());
			pstmt.setString(3, cdb.getCommentt());
			pstmt.setString(4, cdb.getPasswd());
			pstmt.setTimestamp(5, cdb.getReg_date());
			pstmt.setString(6, cdb.getIp());
			pstmt.setInt(7,count+1);	//�ڸ�Ʈ �ѹ�
			pstmt.setInt(8, ref);
			pstmt.setInt(9, re_step);
			pstmt.setInt(10, re_level);
			pstmt.executeUpdate();
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	
	public ArrayList getComments(int con_num, int start, int end)	throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList cm = null;
		try {
			conn = getConnection();
			String sql = "select content_num,commenter,commentt,reg_date,ip,comment_num,ref,re_level,re_step,r "
					+ "from(select content_num,commenter,commentt,reg_date,ip,comment_num,ref,re_level,re_step,rownum r "
					+ "from (select content_num,commenter,commentt,reg_date,ip,comment_num,ref,re_level,re_step "
					+ "from board_comment where content_num="+con_num+" order by reg_date desc) order by reg_date desc) where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cm = new ArrayList<>();
				do {
					CommentDataBean cdb = new CommentDataBean();
					cdb.setComment_num(rs.getInt("comment_num"));
					cdb.setContent_num(rs.getInt("content_num"));
					cdb.setCommenter(rs.getString("commenter"));
					cdb.setCommentt(rs.getString("commentt"));
					cdb.setIp(rs.getString("ip"));
					cdb.setReg_date(rs.getTimestamp("reg_date"));
					cdb.setRef(rs.getInt("ref"));
					cdb.setRe_level(rs.getInt("re_level"));
					cdb.setRe_step(rs.getInt("re_step"));
					cm.add(cdb);
				}
				while(rs.next());
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return cm;
	}
	
	public int getCommentCount(int con_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			conn = getConnection();
			String sql = "select count(*) from board_comment where content_num = "+con_num+"";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return count;
	}
	
	public void deleteComment(int content_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from board_comment where content_num=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, content_num);
			pstmt.executeUpdate();
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		
	}
	
	public int deleteComment(int content_num, String passwd, int comment_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		try {
			conn = getConnection();
			String sql = "select passwd from board_comment where content_num=? and comment_num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, content_num);
			pstmt.setInt(2, comment_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)) {
					sql = "delete from board_comment where comment_num=? and content_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, comment_num);
					pstmt.setInt(2, content_num);
					pstmt.executeUpdate();
					x = 1;
				}else {
					x=0;
				}
			}
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return x;
	}
	

}














































































































































