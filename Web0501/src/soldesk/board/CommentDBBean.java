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
	
	public void insertComment(CommentDataBean cdb,int count) throws Exception{	//count는 코멘트개수
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = cdb.getComment_num();	//코멘트넘버 코멘트가 몇개 증가하는지. 0
		int ref = cdb.getRef();	//어떤 댓글의 댓글인지 구분하기위해 		1
		int re_step = cdb.getRe_step();	//화면에 보여줄 순서	 0
		int re_level = cdb.getRe_level();	//댓글인지 댓글에댓글인지 구분해준다. 0
		
		
		// ref=메인글과 답변글을 묶어준다.
		// re_step=화면출력순서
		// re_level=메인글인지, 답변글인지를 구분해준다.  0,1
		int number = 0;
		String sql = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(comment_num) from board_comment");//총 코멘트가 몇개있는지 받아온다 7
			rs = pstmt.executeQuery();
			if(rs.next()) {
				number = rs.getInt(1)+1;	//새로운 코멘트라면 붙이고 7+1
			} else {
				number = 1;	//코멘트가 없었으면 첫번쨰 코멘트
			}
			System.out.println("number: "+number); //4
			System.out.println("num: "+num); //4
			if(num != 0) {	//코멘트가 하나라도 존재했으면
				sql = "update board_comment set re_step=re_step+1 where ref=? and re_step>?";
				//기존 있던 코멘트의코멘드 스텝을 1올린다(밑으로 내려보내기 위해) 
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step+1;
				re_level = re_level+1;	//
			}else {	//새로운 코멘트면
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
			pstmt.setInt(7,count+1);	//코멘트 넘버
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














































































































































