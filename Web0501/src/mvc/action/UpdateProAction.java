package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import soldesk.board.BoardDataBean;
import soldesk.board.BoardDBBean;

public class UpdateProAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		request.setCharacterEncoding("euc-kr");
		//�����κ��� ���� �����͸� �����Ѵ�. 
		String pageNum = request.getParameter("pageNum");	//��������ȣ
		
		BoardDataBean article = new BoardDataBean();	//������ �ڹٺ�
		article.setNum(Integer.parseInt(request.getParameter("num")));	//�Խñ۹�ȣ
		article.setWriter(request.getParameter("writer"));	
		article.setEmail(request.getParameter("email"));
		article.setSubject(request.getParameter("subject"));
		article.setContent(request.getParameter("content"));
		article.setPasswd(request.getParameter("passwd"));
		
		BoardDBBean dbPro = BoardDBBean.getInstance();
		int check = dbPro.updateArticle(article);	//���� �����ȣ�� ���ؼ� üũ�Ѵ�.
		
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("check", new Integer(check));
		
		return "/MVC/updatePro.jsp";
	}
}
