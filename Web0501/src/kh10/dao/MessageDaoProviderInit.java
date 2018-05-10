package kh10.dao;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class MessageDaoProviderInit extends HttpServlet{	
	
	public void init(ServletConfig config) throws ServletException{
		String dbms = config.getInitParameter("dbms");	//xml에 의해 dbms는 자동적으로 oracle로 저장된다.
		if(dbms != null) {
			MessageDaoProvider.getInstance().setDbms(dbms);
		}
	}

}
