package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import soldesk.board.BoardDataBean;
import soldesk.board.BoardDBBean;

public class UpdateFormAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		
		int num = Integer.parseInt(request.getParameter("num"));	//content.jsp���� �޾ƿ� �Խñ� ��ȣ
		String pageNum = request.getParameter("pageNum");	//content.jsp���� �޾ƿ� ������ ��ȣ
		
		BoardDBBean dbPro = BoardDBBean.getInstance();	//dao��ü ����
		BoardDataBean article = dbPro.updateGetArticle(num);//������Ʈ���� ������ �����͸� ��񿡼� �����´�.
		
		request.setAttribute("pageNum", pageNum );	//������ ��ȣ ������ ����
		request.setAttribute("article", article );	//��� ������ ����
		
		return 	"/MVC/updateForm.jsp"; 
	}
}
