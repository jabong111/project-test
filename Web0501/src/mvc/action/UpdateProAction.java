package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import soldesk.board.BoardDataBean;
import soldesk.board.BoardDBBean;

public class UpdateProAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		request.setCharacterEncoding("euc-kr");
		//폼으로부터 받은 데이터를 수정한다. 
		String pageNum = request.getParameter("pageNum");	//페이지번호
		
		BoardDataBean article = new BoardDataBean();	//수정할 자바빈
		article.setNum(Integer.parseInt(request.getParameter("num")));	//게시글번호
		article.setWriter(request.getParameter("writer"));	
		article.setEmail(request.getParameter("email"));
		article.setSubject(request.getParameter("subject"));
		article.setContent(request.getParameter("content"));
		article.setPasswd(request.getParameter("passwd"));
		
		BoardDBBean dbPro = BoardDBBean.getInstance();
		int check = dbPro.updateArticle(article);	//보낸 비빌번호랑 비교해서 체크한다.
		
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("check", new Integer(check));
		
		return "/MVC/updatePro.jsp";
	}
}
