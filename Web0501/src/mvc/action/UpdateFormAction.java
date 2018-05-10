package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import soldesk.board.BoardDataBean;
import soldesk.board.BoardDBBean;

public class UpdateFormAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		
		int num = Integer.parseInt(request.getParameter("num"));	//content.jsp에서 받아온 게시글 번호
		String pageNum = request.getParameter("pageNum");	//content.jsp에서 받아온 페이지 번호
		
		BoardDBBean dbPro = BoardDBBean.getInstance();	//dao객체 생성
		BoardDataBean article = dbPro.updateGetArticle(num);//업데이트폼에 보여줄 데이터를 디비에서 가져온다.
		
		request.setAttribute("pageNum", pageNum );	//페이지 번호 영역에 저장
		request.setAttribute("article", article );	//기사 영역에 저장
		
		return 	"/MVC/updateForm.jsp"; 
	}
}
