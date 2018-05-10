package net.admin.goods.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminGoodsFrontController extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.processRequest(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.processRequest(request, response);
	}

	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestURI.substring(contextPath.length());
		ActionForward forward=null;
		Action action=null;
		
		if(command.equals("/GoodsAddAction.ag")){	//물품 등록액션
			action= new AdminGoodsAddAction();
			try {
				forward=action.execute(request, response);	//GoodsList.ag로 리다이렉트한다.
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/GoodsList.ag")){	//물품 리스트를 보여준다.
			action=new AdminGoodsListAction();	
			try {	//디비에서 리스트를 얻어와서 영역에 저장시키고 admin_goods_list.jsp로 포워드 시킨다.
				forward=action.execute(request, response);//
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/GoodsAdd.ag")){
			forward=new ActionForward();
			forward.setRedirect(false);	//물품을 등록하는 폼으로 이동한다.
			forward.setPath("./admingoods/admin_goods_write.jsp");
		}else if(command.equals("/GoodsDelete.ag")){
			action=new AdminGoodsDeleteAction();
			try {//GoodsList.ag로 리다이렉트
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/GoodsModify.ag")){
			action=new AdminGoodsModifyForm();	//수정폼에 필요한 필요한 데이터들을 처리
			try {	//admin_goods_modify.jsp로 포워드
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/GoodsModifyAction.ag")){
			action=new AdminGoodsModifyAction();
			try {//GoodsList.ag로 리다이렉트 한다.
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(forward.isRedirect()){			
			response.sendRedirect(forward.getPath());			
		}else{			
			RequestDispatcher dispatcher=
				request.getRequestDispatcher(forward.getPath());
			dispatcher.forward(request, response);			
		}
	}
}


















