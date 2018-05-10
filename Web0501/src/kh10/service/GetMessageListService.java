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

public class GetMessageListService {	//메시지리스트를 불러오는 서비스 
	private static GetMessageListService instance = new GetMessageListService();
	
	public static GetMessageListService getInstance() {
		return instance;
	}
	
	private GetMessageListService() {}	//jsp코드에서 객체를 생성하고 사용하기위해 싱글톤 패턴을 만들어준다.
	
	private static final int MESSAGE_COUNT_PER_PAGE = 3;
	
	public MessageListView getMessageList(int pageNumber) throws ServiceException{	//페이지 정보들이 담겨있는 MessageListView를 반환한다.
		Connection conn = null;	//dao에 접근하기위해 커넥션을 생성하고 메소드를 부를때마다 파라미터로 보내준다.
		int currentPageNumber = pageNumber;
		try {
			conn = ConnectionProvider.getConnection();	//conn = getConnection();이렇게 사용하던것을 클래스로 빼서 사용한다.
			MessageDao messageDao = MessageDaoProvider.getInstance().getMessageDao();	//private OracleMessageDao oracleDao = new OracleMessageDao();
							//오라클디비를 사용하는 dao를 쓰겠다. CRUD는 messageDao를 통해 모두 사용한다.															//oracleDao를 반환한다.
			int messageTotalCount = messageDao.selectCount(conn);
			
			List<Message> messageList = null;
			int firstRow = 0;
			int endRow = 0;
			if(messageTotalCount > 0) {	//메시지가 하나라도 존재하면
				firstRow = (pageNumber-1)*MESSAGE_COUNT_PER_PAGE+1;	//pageNumber가 0이면 firstRow는 1
				endRow = firstRow + MESSAGE_COUNT_PER_PAGE-1; //endRow는 3 총 3개만 보여준다.
				messageList = messageDao.selectList(conn, firstRow, endRow);	//3개를 가져온다.
				
			}else {
				currentPageNumber = 0;
				messageList = Collections.emptyList();
			}
			return new MessageListView(messageList, messageTotalCount, currentPageNumber, MESSAGE_COUNT_PER_PAGE, firstRow, endRow);	//반환
		}catch(SQLException e) {
			throw new ServiceException("메시지 목록 구하기 실패:"+e.getMessage());
		}finally {
			JdbcUtil.close(conn);
		}
		
	}

}
