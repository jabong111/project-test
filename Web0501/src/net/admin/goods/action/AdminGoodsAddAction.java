package net.admin.goods.action;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.admin.goods.db.*;

public class AdminGoodsAddAction implements Action {
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		ActionForward forward = new ActionForward();
		AdminGoodsDAO agoodsdao= new AdminGoodsDAO();
		GoodsBean agb = new GoodsBean();
		
		String realPath = "";
		String savePath = "upload";	
		int maxSize = 5 * 1024 * 1024;
		
		realPath = request.getRealPath(savePath); //upload의 절대경로를 가져온다.
		
		List savefiles=new ArrayList();	//저장할 파일들의 리스트를 만든다.
		
		try {

			MultipartRequest multi = null;	//객체 생성
			/*
			 * 파일을 저장할 디렉토리를 지정할 수 있으며, 업로드제한 용량을 설정할 수 있다.(바이트단위).
			 * 이때 업로드 제한 용량을 넘어서 업로드를 시도하면 IOException 발생된다.
			 * 또한 중복 파일 처리 인터페이스를 사용할 수 있다.
			 *  중복 파일 처리 인터페이스를사용할 수 있다.
			 */
			multi = new MultipartRequest(request, realPath, maxSize, "euc-kr",
					new DefaultFileRenamePolicy());	
			
			Enumeration files=multi.getFileNames();	//업로드된 파일들 이름을 Enumeration타입으로 반환한다.
			while(files.hasMoreElements()){	
				String name=(String)files.nextElement();	//이름들을 하나하나 name에 저장한다.
				if(files.hasMoreElements()){
					savefiles.add(multi.getFilesystemName(name)+",");
					//시스템의 파일 이름을 반환한다. 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
					//파일 이름들을 savefiles리스트에 저장한다.
					//끝에 ,를 붙여 스트링토크나이저를 사용하기위한 ,를 붙인다
				}else{
					savefiles.add(multi.getFilesystemName(name));	
					//마지막 파일에는 ,를 붙이지 않는다.
				}
			}
			
			StringBuffer fl=new StringBuffer();
			for(int i=0;i<savefiles.size();i++){
				fl.append(savefiles.get(i));	//savefiles에 문자열들을 하나로 합친다.
			}
			//이미지파일을 업로드 시키고
			//물품 정보들을 입력폼에서 입력한뒤 받아서 자바빈에 저장한다.
			agb.setGOODS_CATEGORY(multi.getParameter("goods_category"));	
			agb.setGOODS_NAME(multi.getParameter("goods_name"));
			agb.setGOODS_CONTENT(multi.getParameter("goods_content"));
			agb.setGOODS_SIZE(multi.getParameter("goods_size"));
			agb.setGOODS_COLOR(multi.getParameter("goods_color"));
			agb.setGOODS_AMOUNT(
					Integer.parseInt(multi.getParameter("goods_amount")));
			agb.setGOODS_PRICE(
					Integer.parseInt(multi.getParameter("goods_price")));
			agb.setGOODS_IMAGE(fl.toString());	//이미지 저장
			agb.setGOODS_BEST(
					Integer.parseInt(multi.getParameter("goods_best")));
			
			int result = agoodsdao.insertGoods(agb);	//디비에 넣는다.
			if (result <= 0){	//값이 안들어 갔으면
				return null;	//널 리턴
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		forward.setRedirect(true);
		forward.setPath("GoodsList.ag");
		return forward;
	}
}