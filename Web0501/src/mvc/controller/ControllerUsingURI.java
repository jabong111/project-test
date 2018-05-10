package mvc.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import mvc.command.NullHandler;

public class ControllerUsingURI extends HttpServlet{
	
	private Map commandHandlerMap = new java.util.HashMap();	//맵을 만든다.
	
	public void init(ServletConfig config) throws ServletException{		//web.xml의 param-name(configFile2)의 해당하는 밸류를 가져와서  configFile에 저장한다. 이는 상대경로가 된다.
		String configFile = config.getInitParameter("configFile2");	//프로퍼티값을 가져온다.
		Properties prop = new Properties();	//프로퍼티 객체를 생성한다.
		FileInputStream fis = null;	//스트림객체생성
		try {
			String configFilepath = config.getServletContext().getRealPath(configFile);		// /WEB-INF/commandHandlerURI.properties의 절대경로를 구한다.
			fis = new FileInputStream(configFilepath);			//절대경로에 해당하는 파일을 읽어온다.
			prop.load(fis);								//읽어온 파일을 프로터피에 로드한다.
		}catch (IOException e) {
			throw new ServletException();
		}finally {
			if(fis != null) {
				try {
					fis.close();
				}catch (IOException e) {
				}
			}
		}
		Iterator keyIter = prop.keySet().iterator();		//프로퍼티의 키값으로 이터레이터객체를 만든다.
		while(keyIter.hasNext()) {		
			String command = (String)keyIter.next();	//키값을 저장 ex:/hello.do
			String handlerClassName = prop.getProperty(command);	//밸류저장 ex:mvc.command.HelloHandler
			try {
				Class handlerClass = Class.forName(handlerClassName);		//handlerClassName은 문자열이므로 클래스로 만들어주어야한다.
				Object handlerInstance = handlerClass.newInstance();		//키값에 해당하는 객체를 만들어준다.
				commandHandlerMap.put(command, handlerInstance);			//키와 객체를 맵에 넣는다.
			}catch(ClassNotFoundException e) {
				throw new ServletException();
			}catch(InstantiationException e) {
				throw new ServletException();
			}catch(IllegalAccessException e) {
				throw new ServletException();
			}
		}
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		process(request,response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		process(request,response);
	}
	
	public void process(HttpServletRequest request,HttpServletResponse response) throws
	ServletException, IOException{
		//http://localhost:8080/Web0426/hello.do
		String command = request.getRequestURI();		//포트부분 뒤를 가져와서 command에 넣는다. /Web0426/hello.do
		if(command.indexOf(request.getContextPath())==0) {	//request.getContextPath() ==>/Web0426
			command = command.substring(request.getContextPath().length());	// /hello.do만 가져온다
		}
		CommandHandler handler = (CommandHandler)commandHandlerMap.get(command);	// /hello.do라는 키의 밸류를 가져와서  해당하는 핸들러 객체를 생성한다.
		if(handler == null) {	
			handler = new NullHandler();	
		}
		String viewPage = null;	
		try {
			viewPage = handler.process(request, response);	//해당하는 핸들러의 프로세스를 실행한후 포워딩할 페이지를 리턴받는다.
		}catch (Throwable e) {
			throw new ServletException();
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);	//디스패쳐 객체를 통해 포워딩할곳을 정해주고
		dispatcher.forward(request, response);		//포워딩한다.
	}
}






































