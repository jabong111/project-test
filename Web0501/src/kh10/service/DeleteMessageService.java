package kh10.service;

import java.sql.*;

import kh10.dao.*;
import kh10.model.*;
import util.JdbcUtil;
import kh10.jdbc.connection.ConnectionProvider;

public class DeleteMessageService {
	
	private static DeleteMessageService instance = new DeleteMessageService();

	public static DeleteMessageService getInstance() {
		return instance;
	}
	
	private DeleteMessageService() {}	//jsp���� ����ϱ����ؼ� �̱��� ���� �۾��� �Ѵ�.
	
	public void deleteMessage(int messageId, String password) throws ServiceException, InvalidMessagePasswordException, MessageNotFoundException {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false); //Ʈ����� Ȱ��ȭ.
			
			MessageDao messageDao = MessageDaoProvider.getInstance().getMessageDao();
			Message message = messageDao.select(conn, messageId);
			if(message == null) {
				throw new MessageNotFoundException("�޽����� �����ϴ�:"+messageId);
			}
			
			if(!message.hasPassword()) {
				throw new InvalidMessagePasswordException();
			}
			if(!message.getPassword().equals(password)) {
				throw new InvalidMessagePasswordException();
			}
			messageDao.delete(conn, messageId);
			conn.commit();
		}catch (SQLException e) {
			JdbcUtil.rollback(conn);
			throw new ServiceException("���� ó�� �� ������ �߻��߽��ϴ�."+e.getMessage(),e);
		}catch (InvalidMessagePasswordException e) {
			JdbcUtil.rollback(conn);
			throw e;
		}catch (MessageNotFoundException e) {
			JdbcUtil.rollback(conn);
			throw e;
		}finally {
			if(conn!=null) {
				try {
					conn.setAutoCommit(false);
				}catch(SQLException e) {
				}
				JdbcUtil.close(conn);
			}
		}
	}
}
































