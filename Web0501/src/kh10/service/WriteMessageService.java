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
		
	}	//싱글톤패턴 작업후
	
	public void write(Message message) throws ServiceException{
		Connection conn = null;
		try {
		//	MessageDao massageDao = MessageDaoProvider.getInstance().getMessageDao();//oracleDao가 반환되어서 
			conn = ConnectionProvider.getConnection();
			MessageDao messageDao = MessageDaoProvider.getInstance().getMessageDao();
			messageDao.insert(conn, message);	//디비에 삽입
		}catch (SQLException e) {
			throw new ServiceException("메시지 등록 실패: "+e.getMessage(),e);
		}finally {
			JdbcUtil.close(conn);
		}
	}

}
