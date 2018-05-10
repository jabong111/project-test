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


	insert into id_sequence66 values ('article66', 0);	--article66테이블을 집어넣고, 초기값을 0으로 만든다.
 * 
 * create table article66 (
	article_id number not null,							--게시글을 구별해주는 아이디
	group_id number not null,							--게시글과 그 게시물에 달린 답변글을 묶어준다.
	sequence_no char(16) not null,						--시퀀스넘	버
	posting_date date not null,							--만들어진 시간
	read_count number not null,							--조회수
	writer_name varchar2(20) not null,					--작성자
	password varchar2(10),								--비밀번호
	title varchar2(100),								--게시글 제목
	content varchar2(4000),								--내용
	constraint article_id_pk66 primary key (article_id)	--제약조건(article_id 를 기본키로 준다.)
	);
  
   create sequence article_id_seq66;					--시퀀스를 만들어준다
  
   CREATE INDEX  sequence_no_indx66 ON article66(sequence_no);	--article66테이블에서 sequence_no를 인덱스로 만든다
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
	}								//데이터베이스의 값을 가져올수 있는 DAO인 ArticleDao를 외부에서 접근하기위해
									//싱글톤 패턴을 만들어준다.
	
	public int selectCount(Connection conn) throws SQLException{	//게시판에 등록된 글의 개수가 총몇개있는지 가져온다.
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from article66";	//쿼리문
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			return rs.getInt(1);	//디비에서 가져온 인트형데이터를 반환한다.
		}finally {
			JdbcUtil.close(stmt);
			JdbcUtil.close(rs);
		}
	}
	
	public List<Article> select(Connection conn, int firstRow, int endRow)	//firstRow~endRow 까지 디비에서 데이터를 가져와서 어레이리스트에 넣고 이를 반환한다.
				throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select article_id,group_id,sequence_no,posting_date,read_count," + 
				"writer_name,password,title from (select rownum rnum,article_id,group_id,sequence_no,posting_date,read_count," + 
				"writer_name,password,title from (select * from article66 m order by m.sequence_no desc) where rownum<=?) where rnum>=?";	//시퀀스넘버를 큰수부터 정력한다.
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			rs = pstmt.executeQuery();
			if(!rs.next()) {				//데이터베이스에 값이 없으면
				return Collections.emptyList();	//빈리스트를 반환
			}	
				//데이터가 있으면 자바빈객체를 머레이 리스트에 넣고 반환한다.
			List<Article> articleList = new ArrayList<Article>();
			do {
				Article article = makeArticleFromResultSet(rs,false);	//디비에서 꺼내온값을 자바빈에 저장
				articleList.add(article);
			}while(rs.next());
			return articleList;
		}finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		
	}
	
	public int insert(Connection conn, Article article) throws SQLException{	//여러 폼들에서 입력하고 자바빈에 저장한된 자바빈을 받는다.
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
			
			int insertedCount = pstmt.executeUpdate();	//데이터를 넣으면 1이상 안들어가지면 0이 뜬다.
			
			if(insertedCount >0) {						//데이터가 들어가지면
				stmt = conn.createStatement();			
				rs = stmt.executeQuery("select article_id_seq66.currval from dual");	//시퀀스의 현재값 하나를 가져온다.
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
	
	public int insertComment(Connection conn, CommentRequest commentRequest) throws SQLException{	//코멘트 데이터를 삽입하기위해 사용 commentRequest는 xx_form.jsp파일에서 입력된값이 자바빈에 저정되어 넘어온다.
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
			pstmt.setInt(2, number); //새로 넣어야될 코멘트 값은 이전에 코멘트넘값에서 +1한 값이 들어가야된다.
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
		String sql = "select * from article66 where article_id=?";	//아이디에 해당하는 행하나를 가져온다.
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
		String sql = "update article66 set read_count=read_count+1 where article_id = ?";	//read_count를 1올린다.
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
		String sql = "select min(sequence_no) from article66 where sequence_no < ? and sequence_no >= ?";	//sequence_no의 searchMaxSeqNum~searchMinSeqNum사이의 최소sequence_no를 가져온다.
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
		String sql = "update article66 set title=?,content=? where article_id=?";	//title,content를 바꾼다
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














































































