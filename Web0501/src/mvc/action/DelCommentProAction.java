package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comment.CommentDBBean;

public class DelCommentProAction implements CommandAction {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		
		int num = Integer.parseInt(request.getParameter("num"));//content_num
		int commentNum = Integer.parseInt(request.getParameter("commentNum"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		String passwd = request.getParameter("passwd");	//password
		
		CommentDBBean cdbPro = CommentDBBean.getInstance();
		int check = cdbPro.deleteComment(num, passwd, commentNum);
		
		request.setAttribute("num", new Integer(num));
		request.setAttribute("pageNum", new Integer(pageNum));
		request.setAttribute("check", new Integer(check));
		
		
		return "/MVC/delCommentPro.jsp";
	}
}
