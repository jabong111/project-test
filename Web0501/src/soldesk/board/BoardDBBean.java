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
		int re_step = article.getRe_step();	//ȭ�鿡 ������ ���� ���������̴� ���� ū���� ���� �����ش� ���� �ֱٿ� ����� �տ� ��������.
		int re_level = article.getRe_level();
		// ref= ���α۰� �亯���� �����ش�.
		// re_step=ȭ����¼���
		// re_level=���α�����, �亯�������� �������ش�.  0,1
		int number=0;
		String sql = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(num) from board_jabong111");	//�Խ��� �Խñ� ���ڸ� �޾ƿ´� ���� 10������.
			rs = pstmt.executeQuery();
			if(rs.next()) {
				number=rs.getInt(1)+1;	//������ ������ 1�� �÷���	10���� 1�� ���� 11�� ����־��ٰ��� ������̹Ƿ� �ϳ��� �÷��ش�. 16 =>17
			}else {
				number=1;	//�ƹ��͵� ������  ù���� �Խñ�
			}
			//num =  17
			//ref = 1
			//re_step = 0 ȭ����¼���
			//re_level = 0  ����̸� 1�̵Ǿ�ߵȴ�.
			if(num != 0) { //���	   ����� �� ������ �����ֱ����� ������ re_step�� 1�ø��� 
				sql = "update board_jabong111 set re_step=re_step+1 where ref=? and re_step>?";	//������ ���̴��� 1�ø��� 1�ø��� �ؿ� ���̰� �ȴ�.
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);	//������� �������� �����ִ�
				pstmt.setInt(2, re_step);	//ȭ�鿡 �����ټ���
				pstmt.executeUpdate();
				re_step = re_step+1;
				re_level = re_level+1;
			}else { 	//���ο���� num�� 0�̴�.
				ref=number;	 //���ο��
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
	
	public int getArticleCount() throws Exception{	//�Խ����� �����ִ� �ѱ��� ����
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = "select count(*) from board_jabong111"; // ���� ������ �����´�.
		int x=0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x=rs.getInt(1);	//ù���� ���� ���� �����´�
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
	
	//�ѱ��� �����´�
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
	
	//�˻��� ��縦 �����´�.
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
	
	public List getArticles(int start, int end) throws Exception{	////�Խ��� ���������� ������ ���� ������ �����ֱ����� �޼���
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
			if(rs.next()) {//���� �����ϸ�
				articleList = new ArrayList(end);
				do {	//��񿡼� ���� �����ͼ� ���� �����ϰ� ������ ����Ʈ�� �ִ´�.
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
	
	public BoardDataBean getArticle(int num) throws Exception{	//�󼼺��� �ϳ��� ���� �����ͼ� �ڼ��ϰ� �����ִ� �޼���
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		BoardDataBean article = null;
		try {
			String sql = "update board_jabong111 set readcount=readcount+1 where num=?";	//��ȸ���� �÷��ش�.
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from board_jabong111 where num=?"; 
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new BoardDataBean();	//�ڹٺ��� �����ϰ� ��񿡼� �޾ƿ� ���� �������� �ڹٺ��� �����Ѵ�.
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
	
	  //updateForm.jsp : �������� ������ �����͸� �����ö�.
	public BoardDataBean updateGetArticle(int num) throws Exception{	//�������� ����ֱ����� �޼���
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
			if(rs.next()) {	//�ϳ��ǰԽ��Ǳ��� �޾ƿͼ� �������� �ش�.
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
	
	public int updateArticle(BoardDataBean article) throws Exception{	//������ ���� �����ϴ� �޼��� ���������� ���� �޾Ƽ� �ڹٺ� �����͸� �����ϰ� �� ��ü�� �޴´�.
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String dbpasswd="";
		int x=-1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from board_jabong111 where num=?");
			pstmt.setInt(1, article.getNum());	//�������� �ش��ϴ� num���� �������� �ִ´�.
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
	//��񿡼� �ڸ�Ʈ ����Ʈ�� �޾ƿͼ� �Խñ۾��̵�� �н����尡 ������ �ڸ�Ʈ�� ��� ����
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





































