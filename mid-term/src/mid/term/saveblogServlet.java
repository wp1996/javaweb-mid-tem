package mid.term;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.sql.*;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mid.term.CommonDb;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Servlet implementation class saveblogServlet
 */
@WebServlet(
		urlPatterns = { "/saveblogServlet" }, 
		initParams = { 
				@WebInitParam(name = "save", value = "blog", description = "save blog")
		})
public class saveblogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ServletConfig config = null;
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String time;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public saveblogServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init(ServletConfig config)throws ServletException {
    	super.init(config);
    	this.config = config;
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String type = request.getParameter("type");
		String title = request.getParameter("title");
//		PrintWriter writer = response.getWriter();
//		writer.write(title);
//		return;
		String content = request.getParameter("content");
		String authorname = request.getParameter("authorname");
		//String savetime = String.valueOf(System.currentTimeMillis()/1000);
		time = df.format(new Date());
		if (type.equals("1")) {
		String sql = "INSERT INTO blog(title,content,author_name,savetime) VALUES(?,?,?,?)";
		//response.setContentType("text/x-javascript; charset=utf-8"); 
		JSONObject json = new JSONObject();
		int result = 0;
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setString(1,title);
			ps.setString(2,content);
			ps.setString(3,authorname);
			ps.setString(4, time);
			//ps.setString(4, savetime);
			result = ps.executeUpdate();
			if (result > 0) {
				json.put("issave", "true");
			} else {
				json.put("issave", "false");
			}
			PrintWriter writer = response.getWriter();
			writer.write(json.toString());
		}catch (JSONException | SQLException e) {
			e.printStackTrace();
		}
		}else {
			int blog_id = Integer.parseInt(request.getParameter("blog_id"));
			String sql = "UPDATE blog SET title=?, content=?, savetime=? WHERE id=?";
			JSONObject json = new JSONObject();
			int result = 0;
			try {
				PreparedStatement ps = CommonDb.executePreparedStatement(sql);
				ps.setString(1,title);
				ps.setString(2,content);
				ps.setString(3, time);
				ps.setInt(4, blog_id);
				result = ps.executeUpdate();
				if (result > 0) {
					json.put("issave", "true");
				} else {
					json.put("issave", "false");
				}
				PrintWriter writer = response.getWriter();
				writer.write(json.toString());
			}catch (JSONException | SQLException e) {
				e.printStackTrace();
			}
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
