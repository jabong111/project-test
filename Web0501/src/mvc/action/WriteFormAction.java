package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WriteFormAction implements CommandAction {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		int num=0,ref=1,re_step=0,re_level=0;		//초기값으로 저장
		try {
			if(request.getParameter("num") != null) {	//답글을 단다면 content.jsp에서 num,ref,re_level,re_step 값들이 넘어올것이다
				num = Integer.parseInt(request.getParameter("num"));	//게시글번호
				ref = Integer.parseInt(request.getParameter("ref"));	//게시글번호와 연결
				re_step = Integer.parseInt(request.getParameter("re_step"));	//순서
				re_level = Integer.parseInt(request.getParameter("re_level"));	
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		//영역에 저장
		request.setAttribute("num", new Integer(num) );
		request.setAttribute("ref", new Integer(ref) );
		request.setAttribute("re_step", new Integer(re_step) );
		request.setAttribute("re_level", new Integer(re_level) );
		return "/MVC/writeForm.jsp";
	}
}
