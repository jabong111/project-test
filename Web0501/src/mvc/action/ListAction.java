package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Collections;
import java.util.List;

import soldesk.board.BoardDBBean;
import comment.CommentDBBean;

public class ListAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		String pageNum = request.getParameter("pageNum");	//페이징을 하기위해 list.jsp에서 보내주는 파라미터
		if(pageNum == null) {	//첫페이지면 pageNum=1
			pageNum = "1";
		}
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1)*pageSize+1;	//가져올거
		int endRow = currentPage*pageSize;		//가져올거
		int count = 0;	//리스트에서 사용하는 총게시글
		int number = 0;
		int searchn = 0;	//찾을 키워드
		String search = request.getParameter("search");	//찾을단어
		
		if(search != null) {
			searchn = Integer.parseInt(request.getParameter("searchn"));
		}
		
		List articleList = null;
		BoardDBBean dbPro = BoardDBBean.getInstance();	//디비에서 가져온다.
		if(search != null) {	//찾는게 있다면 찾는 키워드를 통해 찾고
			count = dbPro.getArticleCount(searchn, search);
		}else {		//찾는게 없다면 모든 리스트를 가져온다.
			count = dbPro.getArticleCount();
		}
		
		if(count>0) {	//글이 있다면
			if(search != null) {	//검색을 한다면
				articleList = dbPro.getArticles(startRow, endRow, searchn, search);
			}else {	//검색을 안한다면 모두 가져오고
				articleList = dbPro.getArticles(startRow, endRow);	//가져온다
			}
		}else {			//글이 없다면
			articleList = Collections.EMPTY_LIST;	//빈리스트를 만든다.
		}
		number=count-(currentPage-1)*pageSize;
	
		request.setAttribute("currentPage", new Integer(currentPage));
		request.setAttribute("startRow", new Integer(startRow) );
		request.setAttribute("endRow", new Integer(endRow));
		request.setAttribute("count", new Integer(count));
		request.setAttribute("pageSize", new Integer(pageSize) );
		request.setAttribute("number", new Integer(number) );
		request.setAttribute("articleList", articleList );	//영역에 저장
		
		return "/MVC/list.jsp";	//영역에 저장하고 포워딩할 주소를 리턴한다.
	}
}




















