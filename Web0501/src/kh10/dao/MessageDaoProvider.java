package kh10.dao;

import kh10.dao.oracle.OracleMessageDao;;

//싱글톤 타입 객체 생성을 만든다.

public class MessageDaoProvider {	//어떤 디비를 사용할지를 정해주는 클래스 오라클인지 마이에스큐엘인지등등...
	private static MessageDaoProvider instance = new MessageDaoProvider();
	
	public static MessageDaoProvider getInstance() {
		return instance;
	}
	
	private MessageDaoProvider() {
		
	}
	
	private OracleMessageDao oracleDao = new OracleMessageDao();
	
	private String dbms;
	
	void setDbms(String dbms) {
		this.dbms = dbms;
	}
	
	public MessageDao getMessageDao() {
		if("oracle".equals(dbms)) {
			return oracleDao;
		}
		return null;
	}

}
