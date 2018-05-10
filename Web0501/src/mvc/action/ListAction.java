package mvc.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Collections;
import java.util.List;

import soldesk.board.BoardDBBean;
import comment.CommentDBBean;

public class ListAction implements CommandAction{
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws
	 Throwable{
		String pageNum = request.getParameter("pageNum");	//����¡�� �ϱ����� list.jsp���� �����ִ� �Ķ����
		if(pageNum == null) {	//ù�������� pageNum=1
			pageNum = "1";
		}
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1)*pageSize+1;	//�����ð�
		int endRow = currentPage*pageSize;		//�����ð�
		int count = 0;	//����Ʈ���� ����ϴ� �ѰԽñ�
		int number = 0;
		int searchn = 0;	//ã�� Ű����
		String search = request.getParameter("search");	//ã���ܾ�
		
		if(search != null) {
			searchn = Integer.parseInt(request.getParameter("searchn"));
		}
		
		List articleList = null;
		BoardDBBean dbPro = BoardDBBean.getInstance();	//��񿡼� �����´�.
		if(search != null) {	//ã�°� �ִٸ� ã�� Ű���带 ���� ã��
			count = dbPro.getArticleCount(searchn, search);
		}else {		//ã�°� ���ٸ� ��� ����Ʈ�� �����´�.
			count = dbPro.getArticleCount();
		}
		
		if(count>0) {	//���� �ִٸ�
			if(search != null) {	//�˻��� �Ѵٸ�
				articleList = dbPro.getArticles(startRow, endRow, searchn, search);
			}else {	//�˻��� ���Ѵٸ� ��� ��������
				articleList = dbPro.getArticles(startRow, endRow);	//�����´�
			}
		}else {			//���� ���ٸ�
			articleList = Collections.EMPTY_LIST;	//�󸮽�Ʈ�� �����.
		}
		number=count-(currentPage-1)*pageSize;
	
		request.setAttribute("currentPage", new Integer(currentPage));
		request.setAttribute("startRow", new Integer(startRow) );
		request.setAttribute("endRow", new Integer(endRow));
		request.setAttribute("count", new Integer(count));
		request.setAttribute("pageSize", new Integer(pageSize) );
		request.setAttribute("number", new Integer(number) );
		request.setAttribute("articleList", articleList );	//������ ����
		
		return "/MVC/list.jsp";	//������ �����ϰ� �������� �ּҸ� �����Ѵ�.
	}
}




















