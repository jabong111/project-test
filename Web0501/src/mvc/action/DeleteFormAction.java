package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteFormAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		//게시글번호와 페이지번호가 넘어온다.
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		request.setAttribute("num", new Integer(num));	//영역에 저장
		request.setAttribute("pageNum", new Integer(pageNum));
		
		return "/MVC/deleteForm.jsp";
		
	}
}
