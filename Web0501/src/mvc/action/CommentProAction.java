package mvc.action;
/*
 * 디비에 넣어야할 컬럼
 * content_num	게시글 번호
 * comment_num	코멘트 번호
 * commenter	작성자
 * commentt		내용
 * password		비밀번호
 * reg_date		날짜
 * 
 */
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Timestamp;
import comment.CommentDataBean;
import comment.CommentDBBean;

public class CommentProAction implements CommandAction{	//커멘트 프로에서 디비에 집어넣는다. 그리고 리턴한다.
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
		
		return "/MVC/commentPro.jsp";	//디비에 넣고 상세보기페이지로 돌아간다.
	}
}





























