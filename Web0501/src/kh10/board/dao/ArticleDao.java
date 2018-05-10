package kh10.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


import kh10.board.model.Article;
import kh10.board.model.CommentRequest;
import util.JdbcUtil;

/*
 * 
 * 
 * create table id_sequence66 (
	sequence_name varchar2(10) not null,
	next_value number not null,
	constraint sequence_name_pk66 primary key (sequence_name)
	);


	insert into id_sequence66 values ('article66', 0);	--article66���̺��� ����ְ�, �ʱⰪ�� 0���� �����.
 * 
 * create table article66 (
	article_id number not null,							--�Խñ��� �������ִ� ���̵�
	group_id number not null,							--�Խñ۰� �� �Խù��� �޸� �亯���� �����ش�.
	sequence_no char(16) not null,						--��������	��
	posting_date date not null,							--������� �ð�
	read_count number not null,							--��ȸ��
	writer_name varchar2(20) not null,					--�ۼ���
	password varchar2(10),								--��й�ȣ
	title varchar2(100),								--�Խñ� ����
	content varchar2(4000),								--����
	constraint article_id_pk66 primary key (article_id)	--��������(article_id �� �⺻Ű�� �ش�.)
	);
  
   create sequence article_id_seq66;					--�������� ������ش�
  
   CREATE INDEX  sequence_no_indx66 ON article66(sequence_no);	--article66���̺��� sequence_no�� �ε����� �����
 * 
 * 
 * 
 */





public class ArticleDao {
	private static ArticleDao instance = new ArticleDao();
	public static ArticleDao getInstance() {
		return instance;
	}
	private ArticleDao() {
	}								//�����ͺ��̽��� ���� �����ü� �ִ� DAO�� ArticleDao�� �ܺο��� �����ϱ�����
									//�̱��� ������ ������ش�.
	
	public int selectCount(Connection conn) throws SQLException{	//�Խ��ǿ� ��ϵ� ���� ������ �Ѹ�ִ��� �����´�.
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from article66";	//������
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			return rs.getInt(1);	//��񿡼� ������ ��Ʈ�������͸� ��ȯ�Ѵ�.
		}finally {
			JdbcUtil.close(stmt);
			JdbcUtil.close(rs);
		}
	}
	
	public List<Article> select(Connection conn, int firstRow, int endRow)	//firstRow~endRow ���� ��񿡼� �����͸� �����ͼ� ��̸���Ʈ�� �ְ� �̸� ��ȯ�Ѵ�.
				throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select article_id,group_id,sequence_no,posting_date,read_count," + 
				"writer_name,password,title from (select rownum rnum,article_id,group_id,sequence_no,posting_date,read_count," + 
				"writer_name,password,title from (select * from article66 m order by m.sequence_no desc) where rownum<=?) where rnum>=?";	//�������ѹ��� ū������ �����Ѵ�.
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			rs = pstmt.executeQuery();
			if(!rs.next()) {				//�����ͺ��̽��� ���� ������
				return Collections.emptyList();	//�󸮽�Ʈ�� ��ȯ
			}	
				//�����Ͱ� ������ �ڹٺ�ü�� �ӷ��� ����Ʈ�� �ְ� ��ȯ�Ѵ�.
			List<Article> articleList = new ArrayList<Article>();
			do {
				Article article = makeArticleFromResultSet(rs,false);	//��񿡼� �����°��� �ڹٺ� ����
				articleList.add(article);
			}while(rs.next());
			return articleList;
		}finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		
	}
	
	public int insert(Connection conn, Article article) throws SQLException{	//���� ���鿡�� �Է��ϰ� �ڹٺ� �����ѵ� �ڹٺ��� �޴´�.
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement("insert into article66 (article_id,group_id,"
					+ "sequence_no,posting_date,read_count,writer_name,password,title,content) "
					+ " values(article_id_seq66.nextval,?,?,?,0,?,?,?,?)");
			pstmt.setInt(1, article.getGroupId());
			pstmt.setString(2, article.getSequenceNumber());
			pstmt.setTimestamp(3, new Timestamp(article.getPostingDate().getTime()));
			pstmt.setString(4, article.getWriterName());
			pstmt.setString(5, article.getPassword());
			pstmt.setString(6, article.getTitle());
			pstmt.setString(7, article.getContent());
			
			int insertedCount = pstmt.executeUpdate();	//�����͸� ������ 1�̻� �ȵ����� 0�� ���.
			
			if(insertedCount >0) {						//�����Ͱ� ������
				stmt = conn.createStatement();			
				rs = stmt.executeQuery("select article_id_seq66.currval from dual");	//�������� ���簪 �ϳ��� �����´�.
				if(rs.next()) {
					return rs.getInt(1);
				}
			}
			return -1;
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
			JdbcUtil.close(pstmt);
		}
	}
	
	public int insertComment(Connection conn, CommentRequest commentRequest) throws SQLException{	//�ڸ�Ʈ �����͸� �����ϱ����� ��� commentRequest�� xx_form.jsp���Ͽ��� �ԷµȰ��� �ڹٺ� �����Ǿ� �Ѿ�´�.
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number = 0;
		
		try {
			pstmt = conn.prepareStatement("select max(comment_num) from comment66 where content_num=?");
			pstmt.setInt(1, commentRequest.getContent_num());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				number = rs.getInt(1)+1;
			}else {
				number = 1;
			}
			
			pstmt =conn.prepareStatement("insert into comment66(content_num,comment_num,commenter,commentt,password,reg_date) values(?,?,?,?,?,?)");
			pstmt.setInt(1, commentRequest.getContent_num());
			pstmt.setInt(2, number); //���� �־�ߵ� �ڸ�Ʈ ���� ������ �ڸ�Ʈ�Ѱ����� +1�� ���� ���ߵȴ�.
			pstmt.setString(3, commentRequest.getCommenter());
			pstmt.setString(4, commentRequest.getCommentt());
			pstmt.setString(5, commentRequest.getPasswd());
		}finally {
			JdbcUtil.close(pstmt);
		}
		
		return 0;
	}
	
	//getCommentCount	
	//getComments
	
	public Article makeArticleFromResultSet(ResultSet rs, boolean readCount) throws SQLException{
		Article article = new Article();
		article.setId(rs.getInt("article_id"));
		article.setGroupId(rs.getInt("group_id"));
		article.setSequenceNumber(rs.getString("sequence_no"));
		article.setPostingDate(rs.getTimestamp("posting_date"));
		article.setReadCount(rs.getInt("read_count"));
		article.setWriterName(rs.getString("writer_name"));
		article.setPassword(rs.getString("password"));
		article.setTitle(rs.getString("title"));
		if(readCount) {
			article.setContent(rs.getString("content"));
		}
		return article;
	}
	
	public Article selectById(Connection conn, int articleId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from article66 where article_id=?";	//���̵� �ش��ϴ� ���ϳ��� �����´�.
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, articleId);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				return null;
			}
			Article article = makeArticleFromResultSet(rs, true);
			return article;
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
	}
	
	public void increaseReadCount(Connection conn, int articleId) throws SQLException{
		PreparedStatement pstmt = null;
		String sql = "update article66 set read_count=read_count+1 where article_id = ?";	//read_count�� 1�ø���.
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, articleId);
			pstmt.executeUpdate();
		}finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	public String selectLastSequenceNumber(Connection conn,
			String searchMaxSeqNum, String searchMinSeqNum) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select min(sequence_no) from article66 where sequence_no < ? and sequence_no >= ?";	//sequence_no�� searchMaxSeqNum~searchMinSeqNum������ �ּ�sequence_no�� �����´�.
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchMaxSeqNum);
			pstmt.setString(2, searchMinSeqNum);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				return null;
			}
			return rs.getString(1);
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	public int update(Connection conn, Article article) throws SQLException{
		PreparedStatement pstmt = null;
		String sql = "update article66 set title=?,content=? where article_id=?";	//title,content�� �ٲ۴�
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getTitle());
			pstmt.setString(2, article.getContent());
			pstmt.setInt(3, article.getId());
			return pstmt.executeUpdate();
		}finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	public void delete(Connection conn, int articleId) throws SQLException{
		PreparedStatement pstmt = null;
		String sql = "delete from article66 where article_id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, articleId);
			pstmt.executeUpdate();
		}finally {
			JdbcUtil.close(pstmt);
		}
	}
	

}














































































