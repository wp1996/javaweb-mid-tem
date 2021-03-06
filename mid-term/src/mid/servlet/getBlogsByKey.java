package mid.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;
import org.json.*;
import mid.bean.blogBean;
import mid.term.*;
import java.sql.*;

/**
 * Servlet implementation class getBlogsByKey
 */
@WebServlet("/getBlogsByKey")
public class getBlogsByKey extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ResultSet rs = null;
    blogBean blog = new blogBean();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getBlogsByKey() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String key = request.getParameter("key");
		rs = blog.getBlogsByKey(key);
		JSONObject jsonObject = new JSONObject();
		JSONObject json = new JSONObject();
		int i = 0;
		try {
			if (rs.first()) {
				do {
					json.put("title", rs.getString("title"));
					json.put("id", rs.getString("id"));
					json.put("author", rs.getString("author_name"));
					jsonObject.put(String.valueOf(i), json.toString());
					json.remove("title");
					json.remove("id");
					json.remove("author_name");
					i++;
				}while(rs.next());
			}
		}catch (SQLException | JSONException e) {
			e.printStackTrace();
		}
		PrintWriter out = response.getWriter();
		out.write(jsonObject.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
