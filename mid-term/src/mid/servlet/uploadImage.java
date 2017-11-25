package mid.servlet;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.*;
import java.io.File;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jspsmart.upload.*;
import com.oreilly.servlet.*;
import mid.bean.*;
import mid.term.CommonDb;

/**
 * Servlet implementation class uploadImage
 */
@WebServlet("/uploadImage")
public class uploadImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ServletConfig servletConfig;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    /**
     * @see HttpServlet#HttpServlet()
     */
    public uploadImage() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init(ServletConfig config)throws ServletException {
    	this.servletConfig = config;
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		out.print("<html><script>window.open('"+ request.getContextPath() +"/errorpage/request_error.jsp','_self')</script></html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		User user = new User();
		String user_name = session.getAttribute("user_name").toString();
		String sql = "UPDATE user SET image_url=? WHERE user_name=?";
		SmartUpload sUpload = new SmartUpload();
		try {
			sUpload.initialize(servletConfig, request, response);
		}catch(ServletException e) {
			e.printStackTrace();
		}
		try {
			sUpload.upload();
		}catch (ServletException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}catch (SmartUploadException e) {
			e.printStackTrace();
		}
		String time = sdf.format(new Date());
		com.jspsmart.upload.File file = sUpload.getFiles().getFile(0);
		String ext = file.getFileExt();
		String filename = user_name + "_" + time + "." + ext;
		try {
			File dltfile = new File(servletConfig.getServletContext().getRealPath("/") + user.getUrlByName(user_name).substring(3));
			dltfile.delete();
			file.saveAs("/upload/" + filename);
			user.setImage_url("../upload/" + filename);
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setString(1, ("../upload/" + filename));
			ps.setString(2, user_name);
			ps.executeUpdate();
			session.setAttribute("image_url", "../upload/" + filename);
			PrintWriter out = response.getWriter();
			out.write("../upload/" + filename);
		}catch (IOException e) {
			e.printStackTrace();
		}catch (SmartUploadException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
