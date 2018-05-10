package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import soldesk.board.BoardDBBean; 

public class DeleteProAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		request.setCharacterEncoding("euc-kr");
		
		int num = Integer.parseInt(request.getParameter("num"));	//�Խñ۹�ȣ�޴´� (�������� �Ѿ��)
		String pageNum = request.getParameter("pageNum");	//��������ȣ�޴´�.(�ٹ������ �޴´�)
		String passwd = request.getParameter("passwd");	//��й�ȣ�޴´�	(��ǲ)
		
		BoardDBBean dbPro = BoardDBBean.getInstance();	
		int check = dbPro.deleteArticle(num, passwd);	//������ �Խñ۹�ȣ�� ��й�ȣ�� �޾Ƽ� ��й�ȣ�� �´��� üũ���� ����
		
		request.setAttribute("pageNum", new Integer(pageNum));	//��������ȣ ������ ����
		request.setAttribute("check", new Integer(check) );	//üũ������ ����
		
		return "/MVC/deletePro.jsp";
		
	}
}
