package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import soldesk.board.BoardDBBean; 

public class DeleteProAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		request.setCharacterEncoding("euc-kr");
		
		int num = Integer.parseInt(request.getParameter("num"));	//게시글번호받는다 (히든으로 넘어옴)
		String pageNum = request.getParameter("pageNum");	//페이지번호받는다.(겟방식으로 받는다)
		String passwd = request.getParameter("passwd");	//비밀번호받는다	(인풋)
		
		BoardDBBean dbPro = BoardDBBean.getInstance();	
		int check = dbPro.deleteArticle(num, passwd);	//삭제할 게시글번호와 비밀번호를 받아서 비밀번호가 맞는지 체크한후 리턴
		
		request.setAttribute("pageNum", new Integer(pageNum));	//페이지번호 영역에 저장
		request.setAttribute("check", new Integer(check) );	//체크영역에 저장
		
		return "/MVC/deletePro.jsp";
		
	}
}
