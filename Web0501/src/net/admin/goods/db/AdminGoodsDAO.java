package net.admin.goods.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminGoodsDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public AdminGoodsDAO(){
		try{
			Context initCtx=new InitialContext();
			   Context envCtx=(Context)initCtx.lookup("java:comp/env");
			   DataSource ds=(DataSource)envCtx.lookup("jdbc/OracleDB");
			   con=ds.getConnection();
		}catch(Exception ex){
			System.out.println("DB 접근 에러 : " + ex);
			return;
		}
	}
	
	public List getGoodsList() {		//물품 리스트를 받아온다
		List goodslist = new ArrayList();
		try {
			String sql="select * from goods order by goods_num";	//goods_num 오름차순으로 정렬
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				GoodsBean agb = new GoodsBean();	//자바빈생성하고	데이터를 저장한뒤에
				agb.setGOODS_NUM(rs.getInt("goods_num"));	
				agb.setGOODS_CATEGORY(rs.getString("goods_category"));
				agb.setGOODS_NAME(rs.getString("goods_name"));
				agb.setGOODS_CONTENT(rs.getString("goods_content"));
				agb.setGOODS_SIZE(rs.getString("goods_size"));
				agb.setGOODS_COLOR(rs.getString("goods_color"));
				agb.setGOODS_AMOUNT(rs.getInt("goods_amount"));
				agb.setGOODS_PRICE(rs.getInt("goods_price"));
				agb.setGOODS_IMAGE(rs.getString("goods_image"));
				agb.setGOODS_BEST(rs.getInt("goods_best"));
				agb.setGOODS_DATE(rs.getString("goods_date"));
				goodslist.add(agb);	//리스트를 저장한다.
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return goodslist;	//리스트를 리턴
	}
	
	public GoodsBean getGoods(int num) {	//물품 하나를 가져온다.
		try {
			String sql="select * from goods where goods_num=?";	//선택받은 데이터 물품 하나를 가져온다.
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			rs=pstmt.executeQuery();
			rs.next();
			
			GoodsBean agb=new GoodsBean();			//자바빈 하나 만들고
			agb.setGOODS_NUM(rs.getInt("goods_num"));
			agb.setGOODS_CATEGORY(rs.getString("goods_category"));
			agb.setGOODS_NAME(rs.getString("goods_name"));
			agb.setGOODS_CONTENT(rs.getString("goods_content"));
			agb.setGOODS_SIZE(rs.getString("goods_size"));
			agb.setGOODS_COLOR(rs.getString("goods_color"));
			agb.setGOODS_AMOUNT(rs.getInt("goods_amount"));
			agb.setGOODS_PRICE(rs.getInt("goods_price"));
			agb.setGOODS_IMAGE(rs.getString("goods_image"));
			agb.setGOODS_BEST(rs.getInt("goods_best"));
			
			return agb;			//자바빈하나를 리턴
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	public int insertGoods(GoodsBean agb) {			//관리자가 물품을 등록한다
		int result = 0;
		int num=0;
		
		String sql="select max(goods_num) from goods";	//들어간 데이터의 최대값을 가져온다.
		
		try {
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			rs.next();
			num=rs.getInt(1)+1;				//최대값에서 하나를 더해서 새로운 물품을 등록한다.
			
			sql="insert into goods values "+
			"(?,?,?,?,?,?,?,?,?,?,sysdate)";	
			//받아온 자바빈으로 디비에 값을 넣는다.
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, agb.getGOODS_CATEGORY());
			pstmt.setString(3, agb.getGOODS_NAME());
			pstmt.setString(4, agb.getGOODS_CONTENT());
			pstmt.setString(5, agb.getGOODS_SIZE());
			pstmt.setString(6, agb.getGOODS_COLOR());
			pstmt.setInt(7, agb.getGOODS_AMOUNT());
			pstmt.setInt(8, agb.getGOODS_PRICE());
			pstmt.setString(9, agb.getGOODS_IMAGE());
			pstmt.setInt(10, agb.getGOODS_BEST());
			result = pstmt.executeUpdate();
			
			return result;	//값을 넣으면 1이상값 안넣어지면 0
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}
	
	public int deleteGoods(GoodsBean agb){	//물품을 지울때 쓴다.
		int result = 0;					
		
		try {
			String sql="delete from goods where goods_num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, agb.getGOODS_NUM());	//지울려고하는 물품의 자바빈 객체를 모두 보내서 바로 지워버린다. 관리자기 떄문에 비번상관없이 바로 지울수 있다.
			
			result = pstmt.executeUpdate();
			
			return result;
		} catch (Exception e) {
			e.getStackTrace();
		}
		return 0;
	}
	
	public int modifyGoods(GoodsBean agb) {		//물품 정보 수정
		int result = 0;
		
		try {
			String sql="update goods set "+				//관리자이기 때문에 바로 수정할 수 있다.
			"goods_category=?, goods_name=?, goods_price=? ,"+	
			"goods_color=? ,goods_amount=? ,goods_size=? ,"+
			"goods_content=?,goods_best=? where goods_num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, agb.getGOODS_CATEGORY());
			pstmt.setString(2, agb.getGOODS_NAME());
			pstmt.setInt(3, agb.getGOODS_PRICE());
			pstmt.setString(4, agb.getGOODS_COLOR());
			pstmt.setInt(5, agb.getGOODS_AMOUNT());
			pstmt.setString(6, agb.getGOODS_SIZE());
			pstmt.setString(7, agb.getGOODS_CONTENT());
			pstmt.setInt(8, agb.getGOODS_BEST());
			pstmt.setInt(9, agb.getGOODS_NUM());
			result = pstmt.executeUpdate();
			
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}