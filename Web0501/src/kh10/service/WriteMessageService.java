package kh10.service;

import java.sql.*;

import kh10.dao.*;
import kh10.model.*;
import util.JdbcUtil;
import kh10.jdbc.connection.ConnectionProvider;

public class WriteMessageService {
	private static WriteMessageService instance = new WriteMessageService();
	
	public static WriteMessageService getInstance() {
		return instance;
	}
	
	private WriteMessageService() {
		
	}	//�̱������� �۾���
	
	public void write(Message message) throws ServiceException{
		Connection conn = null;
		try {
		//	MessageDao massageDao = MessageDaoProvider.getInstance().getMessageDao();//oracleDao�� ��ȯ�Ǿ 
			conn = ConnectionProvider.getConnection();
			MessageDao messageDao = MessageDaoProvider.getInstance().getMessageDao();
			messageDao.insert(conn, message);	//��� ����
		}catch (SQLException e) {
			throw new ServiceException("�޽��� ��� ����: "+e.getMessage(),e);
		}finally {
			JdbcUtil.close(conn);
		}
	}

}
