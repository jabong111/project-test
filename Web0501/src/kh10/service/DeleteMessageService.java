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
	
	private DeleteMessageService() {}	//jsp에서 사용하기위해서 싱글톤 패턴 작업을 한다.
	
	public void deleteMessage(int messageId, String password) throws ServiceException, InvalidMessagePasswordException, MessageNotFoundException {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false); //트랜잭션 활성화.
			
			MessageDao messageDao = MessageDaoProvider.getInstance().getMessageDao();
			Message message = messageDao.select(conn, messageId);
			if(message == null) {
				throw new MessageNotFoundException("메시지가 없습니다:"+messageId);
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
			throw new ServiceException("삭제 처리 중 에러가 발생했습니다."+e.getMessage(),e);
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
































