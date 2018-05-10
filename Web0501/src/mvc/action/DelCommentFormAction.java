package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * content.jsp ����������ư�� ������ pageNum,content_num,passwd,comment_num�� �������� ������
 * �̰����� �ڸ�Ʈ�� �����ϰ� ���ο����� �����������ش�.
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
