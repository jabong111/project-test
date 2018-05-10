package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import soldesk.logon.LogonDBBean;

public class LoginProAction implements CommandAction {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		request.setCharacterEncoding("euc-kr");
		String id = request.getParameter("id");	//아이디와 비밀번호를 받는다.
		String passwd = request.getParameter("passwd");
		
		LogonDBBean dbPro = LogonDBBean.getInstance();
		int check=dbPro.userCheck(id, passwd);	//로그인정보가 맞는지 체크한다.
		
		request.setAttribute("check", new Integer(check));	//체크를 영역에 저장
		request.setAttribute("id", id);	//아이디를 영역에 저장
		
		return "/logon/loginPro.jsp";	
	}
}
