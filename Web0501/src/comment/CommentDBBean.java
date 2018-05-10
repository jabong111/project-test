package comment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import comment.CommentDataBean;
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
	
	public void insertComment(CommentDataBean cdb) throws Exception{	//count는 코멘트개수
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into commentt66 values (?,?,?,?,?,?,?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cdb.getContent_num());
			pstmt.setString(2, cdb.getCommenter());
			pstmt.setString(3, cdb.getCommentt());
			pstmt.setString(4, cdb.getPasswd());
			pstmt.setTimestamp(5, cdb.getReg_date());
			pstmt.setString(6, cdb.getIp());
			pstmt.setInt(7, cdb.getComment_num());
			pstmt.executeUpdate();
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		
	}
	
	public ArrayList getComments(int con_num)	throws Exception{	//모든 코멘트들을 가져온다.
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList cm = null;
		try {
			conn = getConnection();
			String sql = "select content_num,commenter,commentt,reg_date,ip,comment_num,r "
					+ "from (select content_num,commenter,commentt,reg_date,ip,comment_num,rownum r "
					+ "from (select content_num,commenter,commentt,reg_date,ip,comment_num "
					+ "from commentt66 where content_num="+con_num+" order by reg_date desc) order by reg_date desc) ";
			pstmt = conn.prepareStatement(sql);
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
			String sql = "select count(*) from commentt66 where content_num = "+con_num+"";
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
	
	public void deleteComment(int content_num) throws Exception{	//게시글 지우면 코멘트 모두 지우기위해
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from commentt66 where content_num=?";
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
	
	public int deleteComment(int content_num, String passwd, int comment_num) throws Exception{	//코멘트 삭제
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		try {
			conn = getConnection();
			String sql = "select passwd from commentt66 where content_num=? and comment_num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, content_num);
			pstmt.setInt(2, comment_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)) {
					sql = "delete from commentt66 where comment_num=? and content_num=?";
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














































































































































