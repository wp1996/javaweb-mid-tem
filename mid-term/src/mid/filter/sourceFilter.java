package mid.filter;

import java.awt.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class sourceFilter
 */
@WebFilter(
		urlPatterns = {"*.jsp", "*.xml"}
		)
public class sourceFilter implements Filter {

	private String[] access = new String[] {"/errorpage/nopermission.jsp", "/user/addUser.jsp", "/user/checkUser.jsp"};
    /**
     * Default constructor. 
     */
    public sourceFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)res;
		String url = request.getServletPath();
		if (url.contains("addBlogTest")) {
			PrintWriter out = response.getWriter();
			out.print("<html><script>window.open('"+ request.getContextPath() +"/errorpage/nopermission.jsp','_self')</script></html>");
			return;
		}
		for (String acc : access) {
			if (url.contains(acc)) {
				chain.doFilter(req, res);
				return;
			}
		}
		HttpSession session = request.getSession();
		String user = (String)(session.getAttribute("user_name"));
		if (user == null || "".equals(user)) {
			PrintWriter out = response.getWriter();
			out.print("<html><script>window.open('"+ request.getContextPath() +"/login.html','_self')</script></html>");
			return;
		}
		if (url.contains("xml")) {
			PrintWriter out = response.getWriter();
			out.print("<html><script>window.open('"+ request.getContextPath() +"/errorpage/nopermission.jsp','_self')</script></html>");
			return;
		}
		chain.doFilter(req, res);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
