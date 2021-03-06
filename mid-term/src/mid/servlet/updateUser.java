package mid.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.eclipse.jdt.internal.compiler.ast.IPolyExpression;

import mid.term.CommonDb;

/**
 * Servlet implementation class updateUser
 */
@WebServlet("/updateUser")
public class updateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateUser() {
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
		String user_name = request.getParameter("user_name");
		String user_email = request.getParameter("user_email");
		String user_psd = request.getParameter("user_psd");
		String up_user = request.getParameter("up_user");
		HttpSession session = request.getSession();
		int result = 0;
		String sql = "UPDATE user SET user_name=?, user_email=?, user_psd=? WHERE user_name=?";
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setString(1, user_name);
			ps.setString(2, user_email);
			ps.setString(3, user_psd);
			ps.setString(4, up_user);
			result = ps.executeUpdate();
			PrintWriter out = response.getWriter();
			if(result > 0) {
				session.setAttribute("user_name", user_name);
				out.write("true");
			}else {
				out.write("false");
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
