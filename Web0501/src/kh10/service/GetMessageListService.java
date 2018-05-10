package kh10.service;

import java.sql.*;
import java.util.Collections;
import java.util.List;

import kh10.dao.MessageDao;
import kh10.dao.MessageDaoProvider;
import kh10.dao.oracle.OracleMessageDao;
import kh10.model.Message;
import kh10.model.MessageListView;
import util.JdbcUtil;
import kh10.jdbc.connection.ConnectionProvider;

public class GetMessageListService {	//�޽�������Ʈ�� �ҷ����� ���� 
	private static GetMessageListService instance = new GetMessageListService();
	
	public static GetMessageListService getInstance() {
		return instance;
	}
	
	private GetMessageListService() {}	//jsp�ڵ忡�� ��ü�� �����ϰ� ����ϱ����� �̱��� ������ ������ش�.
	
	private static final int MESSAGE_COUNT_PER_PAGE = 3;
	
	public MessageListView getMessageList(int pageNumber) throws ServiceException{	//������ �������� ����ִ� MessageListView�� ��ȯ�Ѵ�.
		Connection conn = null;	//dao�� �����ϱ����� Ŀ�ؼ��� �����ϰ� �޼ҵ带 �θ������� �Ķ���ͷ� �����ش�.
		int currentPageNumber = pageNumber;
		try {
			conn = ConnectionProvider.getConnection();	//conn = getConnection();�̷��� ����ϴ����� Ŭ������ ���� ����Ѵ�.
			MessageDao messageDao = MessageDaoProvider.getInstance().getMessageDao();	//private OracleMessageDao oracleDao = new OracleMessageDao();
							//����Ŭ��� ����ϴ� dao�� ���ڴ�. CRUD�� messageDao�� ���� ��� ����Ѵ�.															//oracleDao�� ��ȯ�Ѵ�.
			int messageTotalCount = messageDao.selectCount(conn);
			
			List<Message> messageList = null;
			int firstRow = 0;
			int endRow = 0;
			if(messageTotalCount > 0) {	//�޽����� �ϳ��� �����ϸ�
				firstRow = (pageNumber-1)*MESSAGE_COUNT_PER_PAGE+1;	//pageNumber�� 0�̸� firstRow�� 1
				endRow = firstRow + MESSAGE_COUNT_PER_PAGE-1; //endRow�� 3 �� 3���� �����ش�.
				messageList = messageDao.selectList(conn, firstRow, endRow);	//3���� �����´�.
				
			}else {
				currentPageNumber = 0;
				messageList = Collections.emptyList();
			}
			return new MessageListView(messageList, messageTotalCount, currentPageNumber, MESSAGE_COUNT_PER_PAGE, firstRow, endRow);	//��ȯ
		}catch(SQLException e) {
			throw new ServiceException("�޽��� ��� ���ϱ� ����:"+e.getMessage());
		}finally {
			JdbcUtil.close(conn);
		}
		
	}

}
