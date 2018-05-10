package kh10.dao;

import kh10.dao.oracle.OracleMessageDao;;

//�̱��� Ÿ�� ��ü ������ �����.

public class MessageDaoProvider {	//� ��� ��������� �����ִ� Ŭ���� ����Ŭ���� ���̿���ť���������...
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
