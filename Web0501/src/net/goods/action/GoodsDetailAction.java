package net.goods.action;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.goods.db.*;

public class GoodsDetailAction implements Action {
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) {
		ActionForward forward = new ActionForward();
		GoodsDAO goodsdao = new GoodsDAO();
		
		List imgList = new ArrayList();		//이미지 리스트 만들고
		int gr_goods_num = 0;			//이전 상품 다음상품 등을 화면에 띄어주기 위한 자바빈 생성
		GoodsBean isnextpage = null;		
		GoodsBean isprevpage = null;
		GoodsBean itemArray = null;
		GoodsBean next_Bean = null;
		GoodsBean prev_Bean = null;
		String item = null;				
		String price = "no";		

		gr_goods_num = Integer.parseInt(
				request.getParameter("gr_goods_num"));	
		item = request.getParameter("item");	
		
		int nextpage = 0;
		int prevpage = 0;
		
		if (request.getParameter("price") != null &&
			!request.getParameter("price").equals("")){	//price값이 넘어왔다면
			price = request.getParameter("price");	
		}
		if (request.getParameter("search")!= null){		//찾으려는 값이 넘어왔다면
			if (request.getParameter("search").equals("next")) {	//search값이 next면
				next_Bean = goodsdao.findDetail(
						gr_goods_num, item, price,"next");	
				nextpage = next_Bean.getGOODS_NUM();
				itemArray = goodsdao.findDetailList(nextpage, item);	//상세보기 데이터 가져오기
				isnextpage = goodsdao.findDetail(
						nextpage, item, price,"next");
				isprevpage = goodsdao.findDetail(
						nextpage, item, price,"prev");
			}else if (request.getParameter("search").equals("prev")){
				prev_Bean = goodsdao.findDetail(
						gr_goods_num, item,price,"prev");
				prevpage = prev_Bean.getGOODS_NUM();
				itemArray = goodsdao.findDetailList(prevpage, item);
				isnextpage = goodsdao.findDetail(
						prevpage, item, price,"next");
				isprevpage = goodsdao.findDetail(
						prevpage, item, price,"prev");
			}
		}else {	//찾을 값이 없다면
			itemArray = goodsdao.findDetailList(gr_goods_num, item);
			
			if (request.getParameter("isitem").equals("new")) {
				item = "new_item";
			}else if (request.getParameter("isitem").equals("hit")) {
				item = "hit_item";
			}
			
			isnextpage = goodsdao.findDetail(
					gr_goods_num, item, price,"next");
			isprevpage = goodsdao.findDetail(
					gr_goods_num, item, price,"prev");
		}
		
		String images = itemArray.getGOODS_IMAGE();
		StringTokenizer st = new StringTokenizer(images, ",");
		while (st.hasMoreTokens()) {
			imgList.add(st.nextToken());	//이미지 4개를 리스트에 넣는다.
		}
		
		String mainImage = (String) imgList.get(1);	//첫번쨰 이미지를 메인이미지로 만들고
		List contentImage = new ArrayList();	//상세이미지리스트를 생성
		for (int i = 2; i < imgList.size(); i++) {	//2,3,4이미지를 contentImage리스트에 넣는다.
			contentImage.add(imgList.get(i));
		}
		
		//영역에 저장한다.
		request.setAttribute("itemArray", itemArray);
		request.setAttribute("item", item);
		request.setAttribute("mainImage", mainImage);
		request.setAttribute("contentImage", contentImage);
		request.setAttribute("prevpage", isprevpage);
		request.setAttribute("nextpage", isnextpage);
		request.setAttribute("price", price);
		
		forward.setRedirect(false);
		forward.setPath("./goods/goods_detail.jsp");
		return forward;
	}
}