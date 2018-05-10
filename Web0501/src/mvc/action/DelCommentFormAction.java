package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * content.jsp 에서삭제버튼을 누르면 pageNum,content_num,passwd,comment_num을 이쪽으로 보내고
 * 이곳에서 코멘트를 삭제하고 프로에서는 포워딩만해준다.
 */
public class DelCommentFormAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		
		int num = Integer.parseInt(request.getParameter("num"));	//content_num
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		int commentNum = Integer.parseInt(request.getParameter("commentNum"));//comment_num
				
		request.setAttribute("num", num);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("commentNum", commentNum);
		
		return "/MVC/delCommentForm.jsp";
		
	}

}
