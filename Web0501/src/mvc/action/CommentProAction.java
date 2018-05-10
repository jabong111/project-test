package mvc.action;
/*
 * ��� �־���� �÷�
 * content_num	�Խñ� ��ȣ
 * comment_num	�ڸ�Ʈ ��ȣ
 * commenter	�ۼ���
 * commentt		����
 * password		��й�ȣ
 * reg_date		��¥
 * 
 */
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Timestamp;
import comment.CommentDataBean;
import comment.CommentDBBean;

public class CommentProAction implements CommandAction{	//Ŀ��Ʈ ���ο��� ��� ����ִ´�. �׸��� �����Ѵ�.
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		
		request.setCharacterEncoding("euc-kr");
		
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		int num = Integer.parseInt(request.getParameter("num"));
		
		CommentDataBean cdb = new CommentDataBean();
		cdb.setContent_num(Integer.parseInt(request.getParameter("num")));
		cdb.setComment_num(Integer.parseInt(request.getParameter("comment_num")));
		cdb.setCommenter(request.getParameter("commenter"));
		cdb.setCommentt(request.getParameter("commentt"));
		cdb.setPasswd(request.getParameter("passwd"));
		cdb.setReg_date(new Timestamp(System.currentTimeMillis()));
		cdb.setIp(request.getRemoteAddr());
		
		CommentDBBean cdbPro = CommentDBBean.getInstance();
		cdbPro.insertComment(cdb);
		
		request.setAttribute("num", new Integer(num));
		request.setAttribute("pageNum", new Integer(pageNum));
		
		return "/MVC/commentPro.jsp";	//��� �ְ� �󼼺����������� ���ư���.
	}
}





























