package mid.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.jspsmart.upload.Request;

import mid.bean.blogBean;
import mid.factory.*;

/**
 * Servlet implementation class getPageBlogs
 */
@WebServlet("/getPageBlogs")
public class getPageBlogs extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getPageBlogs() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		out.println("<html><script>window.open('" + request.getContextPath() + "/erroepage/request_error.jsp" + "','_self')</script></html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		int page = Integer.valueOf(request.getParameter("page"));
		blogBean blog = DaoFactory.getblogBean();
		ResultSet rs = blog.getBlogsByPage(page);
		JSONObject jsonObject = new JSONObject();
		JSONObject json = new JSONObject();
		int i = 1;
		try {
			if(!rs.first()) {
				json.put("isnull", "true");
				PrintWriter out = response.getWriter();
				out.print(json.toString());
				return;
			}
			do {
				jsonObject.put("id", rs.getString("id"));
				jsonObject.put("author_name", rs.getString("author_name"));
				jsonObject.put("access_count", rs.getString("access_count"));
				jsonObject.put("title", rs.getString("title"));
				json.put(String.valueOf(i), jsonObject.toString());
				jsonObject.remove("id");
				jsonObject.remove("author_name");
				jsonObject.remove("access_count");
				jsonObject.remove("title");
				i++;
			}while(rs.next());
			json.put("isnull", "false");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PrintWriter out = response.getWriter();
		out.print(json.toString());
	}

}
