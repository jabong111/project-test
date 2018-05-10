package mvc.action;

/*
*	댓글에 필요한 num,ref,re_level,re_step등을 초기화하는 부분이 필요하다.
*	
*
*/
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comment.CommentDBBean;
import comment.CommentDataBean;
import soldesk.board.BoardDataBean;
import soldesk.board.BoardDBBean;

import java.util.ArrayList;
import java.util.List;

public class ContentAction implements CommandAction{	//컨텐트 부분에 댓글을 추가해야된다.
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		int num = Integer.parseInt(request.getParameter("num"));	//게시글 번호
		String pageNum = request.getParameter("pageNum");	//페이지번호
		int count = 0;	//코멘트의 갯수를 가져올 변수
		int ref;
		int re_step;
		int re_level;
		
		List<CommentDataBean> commentList = new ArrayList<CommentDataBean>();
		
		CommentDBBean cdbPro = CommentDBBean.getInstance();
		count = cdbPro.getCommentCount(num);	//comment count를 받아온다.
		commentList = cdbPro.getComments(num);
		BoardDBBean dbPro = BoardDBBean.getInstance();	
		BoardDataBean article = dbPro.getArticle(num);	//게시글 번호에 맞는 게시글 하나 가져오기
		
		request.setAttribute("num", new Integer(num) );	//게시글번호 영역에 저장
		request.setAttribute("pageNum", pageNum );	//페이지 번호 영역에 저장
		request.setAttribute("article", article );	//디비에거 가져온 게시글을 영역에 저장
		request.setAttribute("count", count);
		request.setAttribute("commentList", commentList);
		return "/MVC/content.jsp";
	}

}
