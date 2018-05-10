package net.goods.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GoodsDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public GoodsDAO(){	//커넥트풀 생성
		try{
			Context initCtx=new InitialContext();
			Context envCtx=(Context)initCtx.lookup("java:comp/env");
			DataSource ds=(DataSource)envCtx.lookup("jdbc/OracleDB");
			con=ds.getConnection();
		}catch(Exception ex){
			System.out.println("DB 접속 에러 : " + ex);
			return;
		}
	}
	
	public List item_List(String item, int page) {	//페이지에 데이터를 보여줄 메서드
		List itemList = new ArrayList();
		
		int startnum=page*12-11;	//1*12-11 
		int endnum=page*12;			//12    1~12개 까지 아이템을 가져온다.
		
		try {
			StringBuffer findQuery = new StringBuffer();	//버퍼를 생성하고
			
			findQuery.append("SELECT * FROM (SELECT GOODS_NUM,");	//
			findQuery.append("GOODS_CATEGORY, GOODS_NAME, ");
			findQuery.append("GOODS_CONTENT,GOODS_PRICE,GOODS_IMAGE,");
			findQuery.append("GOODS_BEST,GOODS_DATE, rownum r FROM ");
			findQuery.append("GOODS WHERE ");
			//select * from (select goods_num,goods_category,goods_name,goods_content,
			//goods_price,goods_image,goods_best,goods_date, rownum r from goods where 
			if (item.equals("new_item")) {	//데이터를 가져오는데 새로운 아이템이면
				findQuery.append("GOODS_DATE>=GOODS_DATE-7");//이걸 붙이고
			}else if (item.equals("hit_item")) { 	//인기많은 아이템이면
				findQuery.append("GOODS_BEST=1 ");	//베스트가 1인값으로부터 얻어오고
			}else{				//나머지는
				findQuery.append("GOODS_CATEGORY=? ");	//카테고리에 해당하는 값을 가져온다	
			}
			findQuery.append("ORDER BY GOODS_NUM DESC) ");	//최신옷부터 내림차순으로 정렬
			findQuery.append("WHERE r>=? AND r<=? ");		//startnum~endnum 개수만큼
			
			pstmt = con.prepareStatement(findQuery.toString(), 	
				ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY );	//pstmt객체 생성
			
			if (item.equals("new_item") || item.equals("hit_item")){	//item이 새로운 아이템이거나 
				pstmt.setInt(1, startnum);								//인기 아이템이면
				pstmt.setInt(2, endnum);					//쿼리문에 붙일숫자는 startnum,endnum?뿐이다
			}else {								//나머지  category,startnum,endnum를 넣어야된다.
				pstmt.setString(1, item);		
				pstmt.setInt(2, startnum);
				pstmt.setInt(3, endnum);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {			//디비에서 가져온게 존재한다면 디비에서 가져온 모든 자바빈을 리스트에 저장
				GoodsBean goodsbean = new GoodsBean();
				goodsbean.setGOODS_NUM(rs.getInt("GOODS_NUM"));
				goodsbean.setGOODS_CATEGORY(
						rs.getString("GOODS_CATEGORY"));
				goodsbean.setGOODS_NAME(rs.getString("GOODS_NAME"));
				goodsbean.setGOODS_PRICE(rs.getInt("GOODS_PRICE"));
				
				StringTokenizer st=new StringTokenizer(
						rs.getString("GOODS_IMAGE"),",");
				String firstImg=st.nextToken();					 					
				goodsbean.setGOODS_IMAGE(firstImg);				
				goodsbean.setGOODS_BEST(rs.getInt("GOODS_BEST"));
								
				itemList.add(goodsbean);
			} 		
				
			rs.close();			
			pstmt.close();
			
			return itemList;
		} catch(SQLException e) {
			e.printStackTrace(); 
		}

		return itemList;
	}
	
	public List item_List(String item, int page, String searchprice) {	//가격에 따른 리스트를 보여주기위한 메서드 
		List itemList=new ArrayList();							//item_List를 오버로딩해서
		int startnum=page*12-11;								//searchprice 인자만 전달해서 처리한다.
		int endnum=page*12;
		
		int firstprice=0;
		int secondprice=0;
		
		if(searchprice.equals("1~3")){	//goods_list.jsp에서 상품목록을 클릭하면 들어오는 값(1~3, 3~5,...)
			firstprice=1;	
			secondprice=29999;
		} else if (searchprice.equals("3~5")) {
			firstprice=30000;
			secondprice=49999;
		} else if (searchprice.equals("5~7")) {
			firstprice=50000;
			secondprice=69999;
		} else if (searchprice.equals("7~10")) {
			firstprice=70000;
			secondprice=99999;
		} else {
			firstprice=100000;
			secondprice=999999;
		}
		
		try {
			StringBuffer findQuery = new StringBuffer();	//리스트를 가져온다.
			
			findQuery.append("SELECT * FROM (SELECT GOODS_NUM, ");
			findQuery.append("GOODS_CATEGORY, GOODS_NAME, ");
			findQuery.append("GOODS_CONTENT,GOODS_PRICE,GOODS_IMAGE,");
			findQuery.append("GOODS_BEST, rownum r FROM GOODS WHERE ");
			if (item.equals("new_item")){
				findQuery.append("GOODS_DATE>=GOODS_DATE-7");
			}else if (item.equals("hit_item")) { 
				findQuery.append("GOODS_BEST=1 ");
			}else {
				findQuery.append("GOODS_CATEGORY=? ");
			}
			findQuery.append(" AND (GOODS_PRICE BETWEEN ? AND ? ) ");
			findQuery.append("ORDER BY GOODS_NUM DESC) ");
			findQuery.append("WHERE r>=? AND r<=? ");		
			
			pstmt = con.prepareStatement(findQuery.toString(), 
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY );
			
			if (item.equals("new_item") || item.equals("hit_item")) {	//새로운 아이템이거나, 인기아이템중에서 가격별로 리스트를 가져온다
				pstmt.setInt(1, firstprice);	//firstprice~secondprice 사이의 값들을 
				pstmt.setInt(2, secondprice);	//startnum~endnum만큼 가져온다.
				pstmt.setInt(3, startnum);
				pstmt.setInt(4, endnum);
			} else {
				pstmt.setString(1, item);	  //카테고리별로 
				pstmt.setInt(2, firstprice);  //firstprice~secondprice 사이의 값들을 
				pstmt.setInt(3, secondprice); //startnum~endnum만큼 가져온다.
				pstmt.setInt(4, startnum);
				pstmt.setInt(5, endnum);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {	//쿼리문에서 찾은 데이터가 존재하면
				GoodsBean goodsbean = new GoodsBean();	//자바빈에 데이터를 넣고
				goodsbean.setGOODS_NUM(rs.getInt("GOODS_NUM"));
				goodsbean.setGOODS_CATEGORY(
						rs.getString("GOODS_CATEGORY"));
				goodsbean.setGOODS_NAME(rs.getString("GOODS_NAME"));
				goodsbean.setGOODS_PRICE(rs.getInt("GOODS_PRICE"));
				
				StringTokenizer st=new StringTokenizer(
						rs.getString("GOODS_IMAGE"),",");	//4개의 이미지파일들을 ,로 쪼개고 
				String firstimg=st.nextToken();			//첫버너쨰값을 자바빈에 넣는다.
				
				goodsbean.setGOODS_IMAGE(firstimg);
				goodsbean.setGOODS_BEST(rs.getInt("GOODS_BEST"));
				
				itemList.add(goodsbean);
			} 		
			
			rs.close();			
			pstmt.close();
				
			return itemList;
		} catch(SQLException e){
			e.printStackTrace();
		}
			
		return itemList;
	}
	
	public GoodsBean findDetail(int goods_num, String item, 
			String price,String direction) {	//goods_num 제품 번호 
		GoodsBean goods=new GoodsBean();		//item 카테고리 정해주는거
		int firstprice=0;						//price가격
		int secondprice=0;						//direction 이전물품, 다음물품
		
		if(price.equals("1~3")) {	//가격대 정하기
			firstprice=1;
			secondprice=29999;
		} else if (price.equals("3~5")) {
			firstprice=30000;
			secondprice=49999;
			
		} else if (price.equals("5~7")) {
			firstprice=50000;
			secondprice=69999;
		} else if (price.equals("7~10")) {
			firstprice=70000;
			secondprice=99999;
		} else if (price.equals("10")){
			firstprice=100000;
			secondprice=999999;
		}
		
		StringBuffer dQuery = new StringBuffer();
		if(direction.equals("next")){	//다음 물품이면
			dQuery.append("SELECT GOODS_NUM,GOODS_CATEGORY,");
			dQuery.append("GOODS_IMAGE,GOODS_NAME FROM GOODS ");	//GOODS에서 ~~를 가져온다
			dQuery.append("WHERE GOODS_NUM>? AND ");		//GOODS_NUM가 들어온 GOODS_NUM보다 큰부분을
			if(item.equals("new_item")) {
				dQuery.append("GOODS_DATE>=GOODS_DATE-7");
			} else if (item.equals("hit_item")) {
				dQuery.append(" GOODS_BEST=1 ");
			} else {
				dQuery.append(" GOODS_CATEGORY=? ");	//카데고리를 정해준다		
			}
			if (!price.equals("no")) {	//price 값이 no가 아니면
				dQuery.append(" AND (GOODS_PRICE BETWEEN ? AND ? ) ");	// firstprice~secondprice 사이값을 가져온다.
			}
		}else if(direction.equals("prev")){	//이전 물품
			dQuery.append(
			"SELECT GOODS_NUM,GOODS_CATEGORY,GOODS_IMAGE,");
			dQuery.append(
			"GOODS_NAME FROM GOODS WHERE GOODS_NUM<? AND ");
			if(item.equals("new_item")) {
				dQuery.append("GOODS_DATE>=GOODS_DATE-7");
			} else if (item.equals("hit_item")) {
				dQuery.append(" GOODS_BEST=1 ");
			} else {
				dQuery.append(" GOODS_CATEGORY=? ");			
			}
			if (!price.equals("no")) {
				dQuery.append(" AND (GOODS_PRICE BETWEEN ? AND ? ) ");
			}
			dQuery.append("ORDER BY GOODS_NUM DESC ");
		}
		
		try {
			pstmt = con.prepareStatement(dQuery.toString(), 
				ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY );
			
			if (item.equals("new_item") || item.equals("hit_item")){
				if (price.equals("no")) {
					pstmt.setInt(1, goods_num);
				} else {
					pstmt.setInt(1, goods_num);
					pstmt.setInt(2, firstprice);
					pstmt.setInt(3, secondprice);
				}
			} else {
				if (price.equals("no")) {
					pstmt.setInt(1, goods_num);
					pstmt.setString(2, item);
				} else{
					pstmt.setInt(1, goods_num);
					pstmt.setString(2, item);
					pstmt.setInt(3, firstprice);
					pstmt.setInt(4, secondprice);
				}
			}
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				goods.setGOODS_NUM(rs.getInt("GOODS_NUM"));
				goods.setGOODS_CATEGORY(
						rs.getString("GOODS_CATEGORY"));
				goods.setGOODS_NAME(rs.getString("GOODS_NAME"));
				StringTokenizer st=new StringTokenizer(
						rs.getString("GOODS_IMAGE"),",");
				goods.setGOODS_IMAGE(st.nextToken());
			}
			
			rs.close();			
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return goods;	
	}
	
	public GoodsBean findDetailList(int goods_num, String item){	//상품 번호와, item을 인자로 받는다.
		GoodsBean goods=new GoodsBean();
		
		try {
			StringBuffer dQuery = new StringBuffer();
			dQuery.append("SELECT *");		
			dQuery.append(" FROM GOODS WHERE GOODS_NUM=?  AND ");
			
			if(item.equals("new_item")) {
				dQuery.append("GOODS_DATE>=GOODS_DATE-7");
			} else if (item.equals("hit_item")) {
				dQuery.append("GOODS_BEST=1 ");
			} else {
				dQuery.append("GOODS_CATEGORY=? ");	
			}
			
			pstmt = con.prepareStatement(dQuery.toString(), 
				ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY );
			if (item.equals("new_item") || item.equals("hit_item")){
				pstmt.setInt(1, goods_num);
			} else {
				pstmt.setInt(1, goods_num);
				pstmt.setString(2, item);	//카테고리에 맞는 
			}
			
			rs = pstmt.executeQuery();			
			
			if (rs.next()) {	
				goods.setGOODS_NUM(rs.getInt("GOODS_NUM"));
				goods.setGOODS_CATEGORY(
						rs.getString("GOODS_CATEGORY"));
				goods.setGOODS_NAME(rs.getString("GOODS_NAME"));
				goods.setGOODS_CONTENT(
						rs.getString("GOODS_CONTENT"));
				goods.setGOODS_SIZE(rs.getString("GOODS_SIZE"));
				goods.setGOODS_COLOR(rs.getString("GOODS_COLOR"));
				goods.setGOODS_AMOUNT(rs.getInt("GOODS_AMOUNT"));
				goods.setGOODS_PRICE(rs.getInt("GOODS_PRICE"));
				goods.setGOODS_IMAGE(rs.getString("GOODS_IMAGE"));
				goods.setGOODS_BEST(rs.getInt("GOODS_BEST"));					
			}
			
			rs.close();			
			pstmt.close();

			return goods;
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public int getCount(String item) {
		int count=0;
		
		StringBuffer findQuery = new StringBuffer();
		
		findQuery.append("SELECT COUNT(GOODS_NUM) FROM GOODS WHERE ");
		
		if (item.equals("new_item")) {
			findQuery.append("GOODS_DATE>=GOODS_DATE-7");
		} else if (item.equals("hit_item")) { 
			findQuery.append("GOODS_BEST=? ");
		}else {
			findQuery.append("GOODS_CATEGORY=?");
		}
		
		try{
			pstmt=con.prepareStatement(findQuery.toString());
			if (item.equals("new_item")){
			}else if (item.equals("hit_item")) {
				pstmt.setInt(1,1);
			}else{
				pstmt.setString(1, item);
			}
			
			rs=pstmt.executeQuery();
			rs.next();
			
			count=rs.getInt(1);
			
			rs.close();
			pstmt.close();
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return count;
	}
	
	public int getCount(String item, String searchprice) {
		int count=0;
		int firstprice=0;
		int secondprice=0;
		
		if(searchprice.equals("1~3")) {
			firstprice=1;
			secondprice=29999;
		} else if (searchprice.equals("3~5")) {
			firstprice=30000;
			secondprice=49999;
		} else if (searchprice.equals("5~7")) {
			firstprice=50000;
			secondprice=69999;
		} else if (searchprice.equals("7~10")) {
			firstprice=70000;
			secondprice=99999;
		} else {
			firstprice=100000;
			secondprice=999999;
		}
		
		StringBuffer findQuery = new StringBuffer();
		
		findQuery.append("SELECT COUNT(GOODS_NUM) FROM GOODS WHERE ");
		if (item.equals("new_item")) {
			findQuery.append("GOODS_DATE>=GOODS_DATE-7");
		} else if (item.equals("hit_item")) { 
			findQuery.append("GOODS_BEST=? ");
		}else {
			findQuery.append("GOODS_CATEGORY=?");
		}
		findQuery.append(" and (goods_price between ? and ?)");
		
		try
		{
			pstmt=con.prepareStatement(findQuery.toString());
			
			if(item.equals("new_item")){
				pstmt.setInt(1, firstprice);
				pstmt.setInt(2, secondprice);
			}else if (item.equals("hit_item")) {
				pstmt.setInt(1, 1);
				pstmt.setInt(2, firstprice);
				pstmt.setInt(3, secondprice);
			}else{
				pstmt.setString(1, item);
				pstmt.setInt(2, firstprice);
				pstmt.setInt(3, secondprice);
			}
			
			rs=pstmt.executeQuery();
			rs.next();
			count=rs.getInt(1);
			
			rs.close();
			pstmt.close();
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return count;
	}
}