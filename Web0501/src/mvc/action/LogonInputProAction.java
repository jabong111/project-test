package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;

import soldesk.logon.LogonDataBean;
import soldesk.logon.LogonDBBean;

public class LogonInputProAction implements CommandAction {	//폼에서 넘어온 데이터를 저장한다.
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		
		request.setCharacterEncoding("euc-kr");	
		//inputForm.jsp에서 폼으로 받은 데이터들을 자바빈에 넣어서 디비에 저장시킨다.
		LogonDataBean member = new LogonDataBean();
		member.setId(request.getParameter("id"));
		member.setPasswd(request.getParameter("passwd"));
		member.setName(request.getParameter("name"));
		member.setJumin1(request.getParameter("jumin1"));
		member.setJumin2(request.getParameter("jumin2"));
		member.setEmail(request.getParameter("email"));
		member.setZipcode(request.getParameter("zipcode"));
		member.setAddress(request.getParameter("address"));
		member.setBlog(request.getParameter("blog"));
		member.setReg_date(new Timestamp(System.currentTimeMillis()));
		
		LogonDBBean dbPro = LogonDBBean.getInstance();
		dbPro.insertMember(member);
		
		return "/logon/inputPro.jsp";
	}
}
