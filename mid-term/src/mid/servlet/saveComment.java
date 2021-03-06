package mid.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mid.bean.commentBean;

import org.json.JSONException;
import org.json.JSONObject;
import java.sql.*;
import mid.term.*;

/**
 * Servlet implementation class saveComment
 */
@WebServlet("/saveComment")
public class saveComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
	commentBean cBean = new commentBean();
	private ResultSet rs = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public saveComment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		cBean.setCommenter_name(request.getParameter("commenter_name"));
		cBean.setComment(request.getParameter("comment"));
		cBean.setId(Integer.parseInt(request.getParameter("blog_id")));
		if(cBean.saveComment() == 0) {
			response.sendRedirect("errorpage/service_error.jsp");
		}
		int num = 0;
		rs = cBean.getCommentsById();
		JSONObject jsonObject = new JSONObject();
		JSONObject json = new JSONObject();
		int i = 0;
		try {
			if(rs.first()) {
				do {
					json.put("commenter_name", rs.getString("commenter_name"));
					json.put("comment", rs.getString("comment"));
					json.put("addtime", rs.getString("addtime"));
					jsonObject.put(String.valueOf(i), json.toString());
					//json = null;
					json.remove("commenter_name");
					json.remove("comment");
					json.remove("addtime");
					i++;
				}while(rs.next());
			}
			PrintWriter writer = response.getWriter();
			writer.write(jsonObject.toString());
		} catch (SQLException | JSONException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
