package kh10.board.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import kh10.board.dao.ArticleDao;
import kh10.board.model.Article;
import kh10.board.model.ArticleListModel;
import util.JdbcUtil;
import kh10.jdbc.connection.ConnectionProvider;

public class ListArticleService {
	private static ListArticleService instance = new ListArticleService();
	public static ListArticleService getInstance() {
		return instance;
	}
	private ListArticleService() {
	}
	
	public static final int COUNT_PER_PAGE = 10;	//한 페이지에 보여줄 개수
	
	public ArticleListModel getArticleList(int requestPageNumber) {	//현재 페이지를 인자로 받아온다.
		if(requestPageNumber < 0) {
			throw new IllegalArgumentException("page number < 0 :"+requestPageNumber);
		}
		ArticleDao articleDao = ArticleDao.getInstance();	//디비와 연결할수 있는 객체를 생성한다. 게시글 리스트를 받아오기 위해서는
		Connection conn = null;								//selectCount, select 메서드가 있어야된다.
		try {
			conn = ConnectionProvider.getConnection();		//커넥션풀에 연결한다.
			int totalArticleCount = articleDao.selectCount(conn);	//게시글이 총 몇개있는지
			
			if(totalArticleCount == 0) {
				return new ArticleListModel();
			}
			int totalPageCount = calculateTotalPageCount(totalArticleCount);	//만약8개가 들어있다면 calculateTotalPageCount
																				//반환후 totalPageCount=1이된다.
			int firstRow = (requestPageNumber - 1) * COUNT_PER_PAGE+1;	//1~10
			int endRow = firstRow+COUNT_PER_PAGE-1;
			if(endRow>totalArticleCount) {		//
				endRow = totalArticleCount;
			}
			List<Article> articleList = articleDao.select(conn, firstRow, endRow);	//firstRow~endRow글을 불러와서 리스트에 넣는다.
			ArticleListModel articleListView = new ArticleListModel(articleList,requestPageNumber,totalPageCount,firstRow,endRow);
			//ArticleListModel에 페이지와 관련된 데이터를 모두 넣는다.
			return articleListView;
		}catch(SQLException e) {
			throw new RuntimeException("DB에러 발생:"+e.getMessage(),e);
		}finally {
			JdbcUtil.close(conn);
		}
	}
	
	private int calculateTotalPageCount(int totalArticleCount) {	//8개가 들어오고
		if(totalArticleCount == 0) {
			return 0;
		}
		int pageCount = totalArticleCount/COUNT_PER_PAGE;	//8/10 = 0 //12/10 = 1
		if(totalArticleCount % COUNT_PER_PAGE > 0) {		//나머지 8	//나머지 2
			pageCount++;
		}
		return pageCount;	//1//2
	}

}


























