package kh10.pds.service;

import java.sql.Connection;
import java.sql.SQLException;

import kh10.pds.dao.PdsItemDao;
import kh10.pds.model.AddRequest;
import kh10.pds.model.PdsItem;
import util.JdbcUtil;
import kh10.jdbc.connection.ConnectionProvider;

public class AddPdsItemService {
	private static AddPdsItemService instance = new AddPdsItemService();
	public static AddPdsItemService getInstance() {
		return instance;
	}
	private AddPdsItemService() {
	}
	
	public PdsItem add(AddRequest request) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			PdsItem pdsItem = request.toPdsItem();
			int id = PdsItemDao.getInstance().insert(conn, pdsItem);
			if(id==-1) { //ª¿‘¿Ã æ»µ∆¿∏∏È
				JdbcUtil.rollback(conn);
				throw new RuntimeException("DBª¿‘ æ»µ ");
			}
			pdsItem.setId(id);
			conn.commit();
			return pdsItem;
		}catch (SQLException e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		}finally {
			if(conn != null) {
				try {
					conn.setAutoCommit(true);
				}catch (SQLException e) {
				}
			}
			JdbcUtil.close(conn);
		}
	}
}
