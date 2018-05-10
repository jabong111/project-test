package mar26;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;

/**
 * Servlet implementation class NowServelet
 */
public class NowServelet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/html; chrset=euc-kr");
		Date now = new Date();
		PrintWriter writer = response.getWriter();
		writer.println("<html>");
		writer.println("<head><title>현재 시간</title></head>");
		writer.println("<body>");
		writer.println(now.toString());
		writer.println("</body>");
		writer.println("</html>");
		writer.close();
		
	}
	
	

}
