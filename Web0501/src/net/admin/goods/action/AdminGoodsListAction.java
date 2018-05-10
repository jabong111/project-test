package net.admin.goods.action;

import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.goods.db.*;

/*
 * 리스트를 디비에서 받아오고 
 */

public class AdminGoodsListAction implements Action {	//관리자 페이지에 등록된 물품리스트를 보여준다.
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) {
		AdminGoodsDAO agoodsdao=new AdminGoodsDAO();	
		GoodsBean agb=new GoodsBean();
		
		ActionForward forward=new ActionForward();
		
		Collection list=(Collection)agoodsdao.getGoodsList();
		
		request.setAttribute("list",list);	//디비에서 물품 리스트를 얻어와서 영역에 저장한다.
		
		forward.setRedirect(false);
		forward.setPath("./admingoods/admin_goods_list.jsp");
		return forward;
	}
}