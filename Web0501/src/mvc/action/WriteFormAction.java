package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WriteFormAction implements CommandAction {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		int num=0,ref=1,re_step=0,re_level=0;		//�ʱⰪ���� ����
		try {
			if(request.getParameter("num") != null) {	//����� �ܴٸ� content.jsp���� num,ref,re_level,re_step ������ �Ѿ�ð��̴�
				num = Integer.parseInt(request.getParameter("num"));	//�Խñ۹�ȣ
				ref = Integer.parseInt(request.getParameter("ref"));	//�Խñ۹�ȣ�� ����
				re_step = Integer.parseInt(request.getParameter("re_step"));	//����
				re_level = Integer.parseInt(request.getParameter("re_level"));	
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		//������ ����
		request.setAttribute("num", new Integer(num) );
		request.setAttribute("ref", new Integer(ref) );
		request.setAttribute("re_step", new Integer(re_step) );
		request.setAttribute("re_level", new Integer(re_level) );
		return "/MVC/writeForm.jsp";
	}
}
