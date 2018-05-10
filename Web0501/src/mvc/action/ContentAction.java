package mvc.action;

/*
*	��ۿ� �ʿ��� num,ref,re_level,re_step���� �ʱ�ȭ�ϴ� �κ��� �ʿ��ϴ�.
*	
*
*/
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comment.CommentDBBean;
import comment.CommentDataBean;
import soldesk.board.BoardDataBean;
import soldesk.board.BoardDBBean;

import java.util.ArrayList;
import java.util.List;

public class ContentAction implements CommandAction{	//����Ʈ �κп� ����� �߰��ؾߵȴ�.
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		int num = Integer.parseInt(request.getParameter("num"));	//�Խñ� ��ȣ
		String pageNum = request.getParameter("pageNum");	//��������ȣ
		int count = 0;	//�ڸ�Ʈ�� ������ ������ ����
		int ref;
		int re_step;
		int re_level;
		
		List<CommentDataBean> commentList = new ArrayList<CommentDataBean>();
		
		CommentDBBean cdbPro = CommentDBBean.getInstance();
		count = cdbPro.getCommentCount(num);	//comment count�� �޾ƿ´�.
		commentList = cdbPro.getComments(num);
		BoardDBBean dbPro = BoardDBBean.getInstance();	
		BoardDataBean article = dbPro.getArticle(num);	//�Խñ� ��ȣ�� �´� �Խñ� �ϳ� ��������
		
		request.setAttribute("num", new Integer(num) );	//�Խñ۹�ȣ ������ ����
		request.setAttribute("pageNum", pageNum );	//������ ��ȣ ������ ����
		request.setAttribute("article", article );	//��񿡰� ������ �Խñ��� ������ ����
		request.setAttribute("count", count);
		request.setAttribute("commentList", commentList);
		return "/MVC/content.jsp";
	}

}
