package kh10.board.model;

import java.util.ArrayList;
import java.util.List;

public class ArticleListModel {
	private List<Article> articleList;	//게시글들을 모두 저장하는 리스트
	private int requestPage;			//현재페이지
	private int totalPageCount;			//총 페이지
	private int startRow;				//시작
	private int endRow;					//끝
	
	public ArticleListModel() {
		this(new ArrayList<Article>(),0,0,0,0);
	}

	public ArticleListModel(List<Article> articleList, int requestPage,int totalPageCount,int startRow,int endRow) {
		this.articleList = articleList;
		this.requestPage = requestPage;
		this.totalPageCount = totalPageCount;
		this.startRow = startRow;
		this.endRow = endRow;
	}		//생성자를 이용해 초기화
	
	
	//불러오는 get 메서드만 존재
	
	public boolean isHasArticle() {
		return !articleList.isEmpty();
	}
	
	public List<Article> getArticleList() {
		return articleList;
	}

	public int getRequestPage() {
		return requestPage;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public int getStartRow() {
		return startRow;
	}

	public int getEndRow() {
		return endRow;
	}

}
