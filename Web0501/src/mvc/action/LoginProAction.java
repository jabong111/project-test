package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import soldesk.logon.LogonDBBean;

public class LoginProAction implements CommandAction {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		request.setCharacterEncoding("euc-kr");
		String id = request.getParameter("id");	//���̵�� ��й�ȣ�� �޴´�.
		String passwd = request.getParameter("passwd");
		
		LogonDBBean dbPro = LogonDBBean.getInstance();
		int check=dbPro.userCheck(id, passwd);	//�α��������� �´��� üũ�Ѵ�.
		
		request.setAttribute("check", new Integer(check));	//üũ�� ������ ����
		request.setAttribute("id", id);	//���̵� ������ ����
		
		return "/logon/loginPro.jsp";	
	}
}
