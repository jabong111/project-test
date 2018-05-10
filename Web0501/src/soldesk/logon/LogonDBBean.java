package soldesk.logon;

import java.sql.*;
import java.util.Vector;
import java.util.concurrent.ExecutionException;
import java.util.Vector;
import java.util.ArrayList;
import java.util.List;

import com.sun.org.apache.bcel.internal.generic.GETFIELD;

public class LogonDBBean {
	private static LogonDBBean instance = new LogonDBBean();	//��ü ���� ����ƽ ������ �ö󰣴�.
	
	public static LogonDBBean getInstance() {
		return instance; //����ƽ�� �ö� ��ü�� �����Ѵ�.
	}
	
	private LogonDBBean() {	//�����̺��̹Ƿ� �ܺο��� ��ü ���� ���Ѵ�.
		
	}
	
	private Connection getConnection() throws Exception{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	
	public void insertMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into member_jabong111(id,passwd,name,jumin1,jumin2,email,blog,reg_date,zipcode,address)"
				+ " values(?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getJumin1());
			pstmt.setString(5, member.getJumin2());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getBlog());
			pstmt.setTimestamp(8, member.getReg_date());
			pstmt.setString(9, member.getZipcode());
			pstmt.setString(10, member.getAddress());
			pstmt.executeUpdate();
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
		}
	}
	
	public Vector zipcodeRead(String area3) throws Exception
	{ //������ �޾ƿͼ� �������� �˻��ϴ� �������� �ۼ��ѵ� �̶� ������ ��� �ּҵ��� ���Ϳ� ����ְ� ���͸� ��ȯ�Ѵ�.
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector vecList = new Vector();
		String sql = "select * from zipcode where area3 like '"+area3+"%'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {//��񿡼� ������ �����͸� �ڹٺ� �Է��ѵ� �ڹٺ�ü�� ���Ϳ� ����ִ´�.
				ZipcodeBean zipcode = new ZipcodeBean();
				zipcode.setZipcode(rs.getString("zipcode"));
				zipcode.setArea1(rs.getString("area1"));
				zipcode.setArea2(rs.getString("area2"));
				zipcode.setArea3(rs.getString("area3"));
				zipcode.setArea4(rs.getString("area4"));
				vecList.addElement(zipcode);
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		return vecList;
	}
	
	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select passwd from member_jabong111 where id=?";
		String dbpasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)) {
					x = 1;
				}else {
					x = 0; //not match password
				}
			}else {
				x = -1;
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		return x;
	}
	
	public int confirmId(String id) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select id from member_jabong111 where id=?";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) { //���̵� �����ϸ�
				x = 1;
			}else{ //���̵� �������� ������
				x = -1;
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			
		}
		return x;
	}
	
	public int getMemberCount() throws Exception{	//ȸ�� ����Ʈ�� �� �ο����� �̾ƿ´�.
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet	rs = null;
		String sql = "select count(*) from member_jabong111";
		int count = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			
		}
		
		return count;
	}
	
	public List getMembers(int start, int end) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List memberList = null;
		String sql = "select id,passwd,name,jumin1,jumin2,email,blog,reg_date,zipcode,address,r from (select id,passwd,name,jumin1,jumin2,email,blog,reg_date,zipcode,address,rownum r from (select id,passwd,name,jumin1,jumin2,email,blog,reg_date,zipcode,address from member_jabong111 order by name asc, id asc) order by name asc, id asc) where r >= ? and r<=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				memberList = new ArrayList();
				do {
					LogonDataBean member = new LogonDataBean();
					member.setId(rs.getString("id"));
					member.setPasswd(rs.getString("passwd"));
					member.setName(rs.getString("name"));
					member.setJumin1(rs.getString("jumin1"));
					member.setJumin2(rs.getString("jumin2"));
					member.setEmail(rs.getString("email"));
					member.setBlog(rs.getString("blog"));
					member.setReg_date(rs.getTimestamp("reg_date"));
					member.setZipcode(rs.getString("zipcode"));
					member.setAddress(rs.getString("address"));
					memberList.add(member);
				}while(rs.next());
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		return memberList;
	}
	
	public LogonDataBean getMember(String id) throws Exception{ //ȸ���� ������ �����ٶ�
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from member_jabong111 where id=?";
		LogonDataBean member = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new LogonDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setJumin1(rs.getString("jumin1"));
				member.setJumin2(rs.getString("jumin2"));
				member.setEmail(rs.getString("email"));
				member.setBlog(rs.getString("blog"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress(rs.getString("address"));
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			
		}
		return member;
	}
	
	//�޾ƿ� �ڹٺ� ��ü�� �̿��ؼ� �����Ѵ�.
	public void updateMember(LogonDataBean member) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update member_jabong111 set passwd=?, name=?,email=?,blog=?,zipcode=?,address=? where id=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getBlog());
			pstmt.setString(5, member.getZipcode());
			pstmt.setString(6, member.getAddress());
			pstmt.setString(7, member.getId());
			pstmt.executeUpdate();
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			//if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
	}
	
	public int deleteMember(String id, String passwd) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select passwd from member_jabong111 where id=?";
		String dbPasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbPasswd = rs.getString("passwd");
				if(dbPasswd.equals(passwd)) {
					 sql = "delete from member_jabong111 where id=?";
					 pstmt = conn.prepareStatement(sql);
					 pstmt.setString(1, id);
					 pstmt.executeUpdate();
					 x = 1;
				}else { //���Ʋ��
					 x = 0;
				}
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		return x;
	}
	
	public String findId(String name, String jumin1, String jumin2) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select id from member_jabong111 where name=? and jumin1=? and jumin2=?";
		String findid = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, jumin1);
			pstmt.setString(3, jumin2);
			rs = pstmt.executeQuery(); //id���� ���´�.
			if(rs.next()) {
				findid = rs.getString("id");
			}else{
				findid="�ش� ������ ���̵� �����ϴ�.";
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		return findid;
	}
	
	public String findPass(String id, String name, String jumin1, String jumin2) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select passwd from member_jabong111 where id=? and name=? and jumin1=? and jumin2=?";
		String findpass = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, jumin1);
			pstmt.setString(4, jumin2);
			rs = pstmt.executeQuery(); //id���� ���´�.
			if(rs.next()) {	//���� �����ϸ�
				findpass=rs.getString("passwd");
			}else{
				findpass="�ش� ������ ��й�ȣ�� �����ϴ�.";
			}
		}catch(SQLException ex) {
			ex.printStackTrace();
		}finally {
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
		}
		return findpass;
	}
	
}




























































































































































































































































































