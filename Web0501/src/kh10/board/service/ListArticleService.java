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
	
	public static final int COUNT_PER_PAGE = 10;	//�� �������� ������ ����
	
	public ArticleListModel getArticleList(int requestPageNumber) {	//���� �������� ���ڷ� �޾ƿ´�.
		if(requestPageNumber < 0) {
			throw new IllegalArgumentException("page number < 0 :"+requestPageNumber);
		}
		ArticleDao articleDao = ArticleDao.getInstance();	//���� �����Ҽ� �ִ� ��ü�� �����Ѵ�. �Խñ� ����Ʈ�� �޾ƿ��� ���ؼ���
		Connection conn = null;								//selectCount, select �޼��尡 �־�ߵȴ�.
		try {
			conn = ConnectionProvider.getConnection();		//Ŀ�ؼ�Ǯ�� �����Ѵ�.
			int totalArticleCount = articleDao.selectCount(conn);	//�Խñ��� �� ��ִ���
			
			if(totalArticleCount == 0) {
				return new ArticleListModel();
			}
			int totalPageCount = calculateTotalPageCount(totalArticleCount);	//����8���� ����ִٸ� calculateTotalPageCount
																				//��ȯ�� totalPageCount=1�̵ȴ�.
			int firstRow = (requestPageNumber - 1) * COUNT_PER_PAGE+1;	//1~10
			int endRow = firstRow+COUNT_PER_PAGE-1;
			if(endRow>totalArticleCount) {		//
				endRow = totalArticleCount;
			}
			List<Article> articleList = articleDao.select(conn, firstRow, endRow);	//firstRow~endRow���� �ҷ��ͼ� ����Ʈ�� �ִ´�.
			ArticleListModel articleListView = new ArticleListModel(articleList,requestPageNumber,totalPageCount,firstRow,endRow);
			//ArticleListModel�� �������� ���õ� �����͸� ��� �ִ´�.
			return articleListView;
		}catch(SQLException e) {
			throw new RuntimeException("DB���� �߻�:"+e.getMessage(),e);
		}finally {
			JdbcUtil.close(conn);
		}
	}
	
	private int calculateTotalPageCount(int totalArticleCount) {	//8���� ������
		if(totalArticleCount == 0) {
			return 0;
		}
		int pageCount = totalArticleCount/COUNT_PER_PAGE;	//8/10 = 0 //12/10 = 1
		if(totalArticleCount % COUNT_PER_PAGE > 0) {		//������ 8	//������ 2
			pageCount++;
		}
		return pageCount;	//1//2
	}

}


























