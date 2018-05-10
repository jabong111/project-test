package net.admin.goods.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.goods.db.*;

public class AdminGoodsModifyAction implements Action {

	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("euc-kr");
		ActionForward forward=new ActionForward();
		AdminGoodsDAO agoodsdao= new AdminGoodsDAO();
		GoodsBean agb=new GoodsBean();
		//수정폼에서 입력받은 데이터 를 받고 자바빈에 저장한뒤
		agb.setGOODS_NUM(Integer.parseInt(request.getParameter("goods_num")));
		agb.setGOODS_CATEGORY(request.getParameter("goods_category"));
		agb.setGOODS_NAME(request.getParameter("goods_name"));
		agb.setGOODS_CONTENT(request.getParameter("goods_content"));
		agb.setGOODS_SIZE(request.getParameter("goods_size"));
		agb.setGOODS_COLOR(request.getParameter("goods_color"));
		agb.setGOODS_AMOUNT(Integer.parseInt(request.getParameter("goods_amount")));
		agb.setGOODS_PRICE(Integer.parseInt(request.getParameter("goods_price")));
		agb.setGOODS_BEST(Integer.parseInt(request.getParameter("goods_best")));
		
		//수정dao를 통해 수정한다.
		int result=agoodsdao.modifyGoods(agb);
		if(result<=0){
			System.out.println("수정실패");
			return null;
		}
		
		forward.setPath("./GoodsList.ag");
		forward.setRedirect(true);
		return forward;
	}
}