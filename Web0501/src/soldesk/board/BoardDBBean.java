package soldesk.board;

import java.sql.*;
import javax.sql.*;

import javax.naming.*;
import java.util.*;

public class BoardDBBean {
	
	private static BoardDBBean instance = new BoardDBBean();
	
	public static BoardDBBean getInstance() {
		return instance;
	}
	
	private BoardDBBean() {
	}
	
	private Connection getConnection() throws Exception{
		String jtbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jtbcDriver);
	}
	
	public void insertArticle(BoardDataBean article) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = article.getNum();	
		int ref = article.getRef(); //1
		int re_step = article.getRe_step();	//화면에 보여줄 순서 내림차순이다 값이 큰값이 먼저 보여준다 제일 최근에 만든게 앞에 보여진다.
		int re_level = article.getRe_level();
		// ref= 메인글과 답변글을 묶어준다.
		// re_step=화면출력순서
		// re_level=메인글인지, 답변글인지를 구분해준다.  0,1
		int number=0;
		String sql = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(num) from board_jabong111");	//게시판 게시글 숫자를 받아온다 만약 10개였다.
			rs = pstmt.executeQuery();
			if(rs.next()) {
				number=rs.getInt(1)+1;	//기존의 값에서 1을 플러스	10개의 1을 더한 11개 집어넣어줄값이 생긴것이므로 하나더 올려준다. 16 =>17
			}else {
				number=1;	//아무것도 없으면  첫번쨰 게시글
			}
			//num =  17
			//ref = 1
			//re_step = 0 화면출력순서
			//re_level = 0  답글이면 1이되어야된다.
			if(num != 0) { //답글	   답글의 글 순서를 보여주기위해 기존의 re_step을 1올리고 
				sql = "update board_jabong111 set re_step=re_step+1 where ref=? and re_step>?";	//기존의 보이던걸 1올리고 1올리면 밑에 보이게 된다.
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);	//답글인지 새글인지 보여주는
				pstmt.setInt(2, re_step);	//화면에 보여줄순서
				pstmt.executeUpdate();
				re_step = re_step+1;
				re_level = re_level+1;
			}else { 	//새로운글은 num이 0이다.
				ref=number;	 //새로운글
				re_step=0;		
				re_level = 0;
			}
			
			sql="insert into board_jabong111(num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip) values(num_ji.nextval,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPasswd());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_step);
			pstmt.setInt(8, re_level);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null)	try {conn.close();} catch(Exception ex) {}
			if(pstmt != null)	try {pstmt.close();} catch(Exception ex) {}
			if(rs != null)	try {rs.close();} catch(Exception ex) {}
		}
	}
	
	public int getArticleCount() throws Exception{	//게시판의 써져있는 총글의 개수
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = "select count(*) from board_jabong111"; // 행의 갯수를 가져온다.
		int x=0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x=rs.getInt(1);	//첫번쨰 행의 값을 가져온다
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null)	try {conn.close();} catch(Exception ex) {}
			if(pstmt != null)	try {pstmt.close();} catch(Exception ex) {}
			if(rs != null)	try {rs.close();} catch(Exception ex) {}
		}
		return x;
	}
	
	//총글의 가져온다
	public int getArticleCount(int n, String search) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		String[] keyWord = {"writer", "subject","content"};
		String keyword = keyWord[n];
		
		try {
			sql = "select count(*) from board_jabong111 where "+keyword+" like '%"+search+"%' ";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null)	try {conn.close();} catch(Exception ex) {}
			if(pstmt != null)	try {pstmt.close();} catch(Exception ex) {}
			if(rs != null)	try {rs.close();} catch(Exception ex) {}
		}
		return count;
	}
	
	//검색한 기사를 가져온다.
	public List getArticles(int start, int end, int n, String search) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articles = null;
		String[] keyWork = {"writer", "subject","content"};
		String keyword = keyWork[n];
		String sql = "select num,writer,email,subject,passwd,reg_date,readcount,ref,re_step,re_level,content,ip,r from (select num,writer,email,subject,passwd,reg_date,readcount,ref,re_step,re_level,content,ip,rownum r from (select num,writer,email,subject,passwd,reg_date,readcount,ref,re_step,re_level,content,ip from board_jabong111 where "+keyword+" like '"+search+"%' order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r<=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				articles = new ArrayList();
				do {
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					articles.add(article);
				}while(rs.next());
			}
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null)	try {conn.close();} catch(Exception ex) {}
			if(pstmt != null)	try {pstmt.close();} catch(Exception ex) {}
			if(rs != null)	try {rs.close();} catch(Exception ex) {}
		}
		return articles;
	}
	
	public List getArticles(int start, int end) throws Exception{	////게시판 한페이지에 보여줄 글의 개수를 보여주기위한 메서드
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		List articleList = null;
		
		try {
			String sql =	"select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "
					+ "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r "
					+ "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount from board_jabong111 order by ref desc, re_step asc) "
					+ "order by ref desc, re_step asc) where r>=? and r <= ? ";	
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {//값이 존재하면
				articleList = new ArrayList(end);
				do {	//디비에서 값을 가져와서 디비빈에 저장하고 디비빈을 리스트에 넣는다.
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setIp(rs.getString("ip"));
					articleList.add(article);
				}while(rs.next());
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null)	try {conn.close();} catch(Exception ex) {}
			if(pstmt != null)	try {pstmt.close();} catch(Exception ex) {}
			if(rs != null)	try {rs.close();} catch(Exception ex) {}
		}
		return articleList;
	}
	
	public BoardDataBean getArticle(int num) throws Exception{	//상세보기 하나의 글을 가져와서 자세하게 보여주는 메서드
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		BoardDataBean article = null;
		try {
			String sql = "update board_jabong111 set readcount=readcount+1 where num=?";	//조회수를 올려준다.
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from board_jabong111 where num=?"; 
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new BoardDataBean();	//자바빈을 생성하고 디비에서 받아온 값을 저장한후 자바빈을 리턴한다.
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null)	try {conn.close();} catch(Exception ex) {}
			if(pstmt != null)	try {pstmt.close();} catch(Exception ex) {}
			if(rs != null)	try {rs.close();} catch(Exception ex) {}
		}
				
		return article;		
	}
	
	  //updateForm.jsp : 수정폼에 한줄의 데이터를 가져올때.
	public BoardDataBean updateGetArticle(int num) throws Exception{	//수정폼에 띄어주기위한 메서드
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		BoardDataBean article = null;
		try {
			String sql = "select * from board_jabong111 where num=?";
			conn=getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {	//하나의게시판글을 받아와서 수정폼에 준다.
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null)	try {conn.close();} catch(Exception ex) {}
			if(pstmt != null)	try {pstmt.close();} catch(Exception ex) {}
			if(rs != null)	try {rs.close();} catch(Exception ex) {}
		}
		return article;
	}
	
	public int updateArticle(BoardDataBean article) throws Exception{	//실제로 값을 수정하는 메서드 수정폼에서 값을 받아서 자바빈에 데이터를 저장하고 그 객체를 받는다.
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String dbpasswd="";
		int x=-1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from board_jabong111 where num=?");
			pstmt.setInt(1, article.getNum());	//수정폼에 해당하는 num값을 쿼리문에 넣는다.
			rs = pstmt.executeQuery();	
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(article.getPasswd())) {
					String sql = "update board_jabong111 set writer=?,email=?,subject=?,passwd=?,"
							+ "content=? where num=?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getPasswd());
					pstmt.setString(5, article.getContent());
					pstmt.setInt(6, article.getNum());
					pstmt.executeUpdate();
					x=1;
				}else{
					x=0;
				}
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null)	try {conn.close();} catch(Exception ex) {}
			if(pstmt != null)	try {pstmt.close();} catch(Exception ex) {}
			if(rs != null)	try {rs.close();} catch(Exception ex) {}
		}
		return x;
		
		
	}
	
	public int deleteArticle(int num, String passwd) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String dbpasswd="";
		int x=-1;
		
		try {
			String sql = "select passwd from board_jabong111 where num=?";
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)) {
					sql = "delete from board_jabong111 where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x=1;
				}else {
					x=0;
				}
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null)	try {conn.close();} catch(Exception ex) {}
			if(pstmt != null)	try {pstmt.close();} catch(Exception ex) {}
			if(rs != null)	try {rs.close();} catch(Exception ex) {}
		}
		return x;
		
	}
	//디비에서 코멘트 리스트를 받아와서 게시글아이디랑 패스워드가 맞으면 코멘트를 모두 삭제
	public int deleteComment(int num, String passwd) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList comments = null;
		String dbpass = "";
		int x=-1;
		try {
		
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null)	try {conn.close();} catch(Exception ex) {}
			if(pstmt != null)	try {pstmt.close();} catch(Exception ex) {}
			if(rs != null)	try {rs.close();} catch(Exception ex) {}
		}
		return x;
	}
	
	
	
	
	
	
	
	
	
	

}





































