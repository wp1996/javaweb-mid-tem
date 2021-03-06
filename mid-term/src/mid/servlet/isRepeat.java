package mid.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

import mid.bean.User;
import mid.dao.impl.UserDaoImpl;
import mid.factory.DaoFactory;
import net.sf.json.JSONException;

/**
 * Servlet implementation class isRepeat
 */
@WebServlet("/isRepeat")
public class isRepeat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public isRepeat() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		out.print("<html><script>window.open('"+ request.getContextPath() +"/errorpage/request_error.jsp','_self')</script></html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		UserDaoImpl userDaoImpl = (UserDaoImpl) DaoFactory.getUserDaoInstance();
		JSONObject json = new JSONObject();
		try {
			if (userDaoImpl.getUserByName(username).getUser_name().equals("")) {
				json.put("rename", "false");
			}else {
				json.put("rename", "true");
			}
			if (userDaoImpl.getUserByEmail(email).getUser_email().equals("")) {
				json.put("reemail", "false");
			}else {
				json.put("reemail", "true");
			}
		} catch (org.json.JSONException e) {
			e.printStackTrace();
		}
		PrintWriter out = response.getWriter();
		out.print(json.toString());
	}

}
