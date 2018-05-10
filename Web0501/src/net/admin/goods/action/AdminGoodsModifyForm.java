package net.admin.goods.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.admin.goods.db.*;

public class AdminGoodsModifyForm implements Action {
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) {
		ActionForward forward=new ActionForward();
		
		AdminGoodsDAO agoodsdao=new AdminGoodsDAO();
		GoodsBean agb=new GoodsBean();
		
		String num=request.getParameter("goods_num");	//물품번호를 리스트에서 받아온다.
		
		agb=agoodsdao.getGoods(Integer.parseInt(num));	//물품번호에 해당하는 물품하나 디비에서 가져온다
		
		request.setAttribute("agb", agb);	//영역에 저장
		
		forward.setPath("./admingoods/admin_goods_modify.jsp");
		forward.setRedirect(false);
		return forward;
	}
}