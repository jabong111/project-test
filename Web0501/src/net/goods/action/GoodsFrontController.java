package net.goods.action;

import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.goods.action.GoodsDetailAction;
import net.goods.action.GoodsListAction;

public class GoodsFrontController extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		this.processRequest(request, response);

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		this.processRequest(request, response);
	}

	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		String requestURI = request.getRequestURI();
		String contextpath = request.getContextPath();
		String command = requestURI.substring(contextpath.length());
		
		ActionForward forward = null;
		Action action = null;
		
		if (command.equals("/Goods_Detail.go")) {	//상품 상세보기 페이지
			action = new GoodsDetailAction();	//슈퍼 인터페이스인 Action을 통해 GoodsDetailAction객체를 생성한다.
			try {	//제품의 상세페이지를 보여준다.
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}	//goods_detail.jsp를 포워드 시킨다.
		}
		else if (command.equals("/GoodsList.go")) {	//물품 리스트보여주는 페이지 관련한 데이터를 처리한다.
			action = new GoodsListAction();	//슈퍼인터페이스를 이용해서 GoodsListAction객체 생성한다.
			try {		
				forward = action.execute(request, response);	//포워드 시킨다.
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request
						.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}
}