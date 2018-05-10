package kh10.pds.service;

import java.sql.Connection;
import java.sql.SQLException;

import kh10.pds.dao.PdsItemDao;
import kh10.pds.model.PdsItem;
import util.JdbcUtil;
import kh10.jdbc.connection.ConnectionProvider;

public class GetPdsItemService {
	private static GetPdsItemService instance = new GetPdsItemService();
	public static GetPdsItemService getInstance() {
		return instance;
	}
	private GetPdsItemService() {
	}
	
	public PdsItem getPdsItem(int id)	throws PdsItemNotFoundException{
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			PdsItem pdsItem = PdsItemDao.getInstance().selectById(conn, id);
			if(pdsItem == null) {
				throw new PdsItemNotFoundException("�������� �ʽ��ϴ�:"+id);
			}
			return pdsItem;
		}catch(SQLException e) {
			throw new RuntimeException("DB ó�� ���� �߻�:"+e.getMessage(),e);
		}finally {
			JdbcUtil.close(conn);
		}
	}
	

}