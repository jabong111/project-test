package net.goods.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.goods.db.*;

public class GoodsListAction implements Action{
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response){
		ActionForward forward=new ActionForward();
		GoodsDAO goodsdao=new GoodsDAO();
		
		List itemList=null;
		String item=null;
		String price="";
		int count=1;
		int page=1;
		if(request.getParameter("page")!=null){
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		item=request.getParameter("item");	//카테고리
		
		if (request.getParameter("searchprice")==null || 
				request.getParameter("searchprice").equals("")) {//searchprice가 
			itemList= goodsdao.item_List(item,page);		//넘어오지 않으면 해당 개수만큼 리스트를 디비에서 가져온다.
			count=goodsdao.getCount(item);			//물품 개수를 가져온다.
		} else {		//searchprice가 인자로 넘어왔다면
			price=request.getParameter("searchprice");	//price를 저장하고
			itemList= goodsdao.item_List(item,page,price);	//값에 해당하는 item_List를 가져온다.
			count=goodsdao.getCount(item, price); //물품 개수를 가져온다.
		}
		
		int pageSize=12;	//한페이지에 보여줄 개수
		int pageCount=count/pageSize+(count % pageSize==0?0:1);
		int startPage=(int)((page-1)/10)*10+1;
		int endPage=startPage+10-1;
		if (endPage>pageCount) endPage=pageCount;
		
		//영역에 저장
		request.setAttribute("itemList", itemList);
		request.setAttribute("category", item);
		request.setAttribute("count", count);
		request.setAttribute("price", price);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		forward.setRedirect(false);
		forward.setPath("./goods/goods_list.jsp");
		return forward;
	}
}