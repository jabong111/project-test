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
	
	private Map commandHandlerMap = new java.util.HashMap();	//���� �����.
	
	public void init(ServletConfig config) throws ServletException{		//web.xml�� param-name(configFile2)�� �ش��ϴ� ����� �����ͼ�  configFile�� �����Ѵ�. �̴� ����ΰ� �ȴ�.
		String configFile = config.getInitParameter("configFile2");	//������Ƽ���� �����´�.
		Properties prop = new Properties();	//������Ƽ ��ü�� �����Ѵ�.
		FileInputStream fis = null;	//��Ʈ����ü����
		try {
			String configFilepath = config.getServletContext().getRealPath(configFile);		// /WEB-INF/commandHandlerURI.properties�� �����θ� ���Ѵ�.
			fis = new FileInputStream(configFilepath);			//�����ο� �ش��ϴ� ������ �о�´�.
			prop.load(fis);								//�о�� ������ �������ǿ� �ε��Ѵ�.
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
		Iterator keyIter = prop.keySet().iterator();		//������Ƽ�� Ű������ ���ͷ����Ͱ�ü�� �����.
		while(keyIter.hasNext()) {		
			String command = (String)keyIter.next();	//Ű���� ���� ex:/hello.do
			String handlerClassName = prop.getProperty(command);	//������� ex:mvc.command.HelloHandler
			try {
				Class handlerClass = Class.forName(handlerClassName);		//handlerClassName�� ���ڿ��̹Ƿ� Ŭ������ ������־���Ѵ�.
				Object handlerInstance = handlerClass.newInstance();		//Ű���� �ش��ϴ� ��ü�� ������ش�.
				commandHandlerMap.put(command, handlerInstance);			//Ű�� ��ü�� �ʿ� �ִ´�.
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
		String command = request.getRequestURI();		//��Ʈ�κ� �ڸ� �����ͼ� command�� �ִ´�. /Web0426/hello.do
		if(command.indexOf(request.getContextPath())==0) {	//request.getContextPath() ==>/Web0426
			command = command.substring(request.getContextPath().length());	// /hello.do�� �����´�
		}
		CommandHandler handler = (CommandHandler)commandHandlerMap.get(command);	// /hello.do��� Ű�� ����� �����ͼ�  �ش��ϴ� �ڵ鷯 ��ü�� �����Ѵ�.
		if(handler == null) {	
			handler = new NullHandler();	
		}
		String viewPage = null;	
		try {
			viewPage = handler.process(request, response);	//�ش��ϴ� �ڵ鷯�� ���μ����� �������� �������� �������� ���Ϲ޴´�.
		}catch (Throwable e) {
			throw new ServletException();
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);	//������ ��ü�� ���� �������Ұ��� �����ְ�
		dispatcher.forward(request, response);		//�������Ѵ�.
	}
}






































