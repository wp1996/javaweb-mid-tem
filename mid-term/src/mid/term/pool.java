package mid.term;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.jdbc.pool.*;

public class pool {
	protected static Statement s = null;
	protected static ResultSet rs = null;
	protected static Connection conn = null;
	public static synchronized Connection getConnection() {
		try {
			Context context = new InitialContext();
			context = (Context)context.lookup("java:comp/env");
			DataSource ds = (DataSource)context.lookup("dbpool");
			conn = ds.getConnection();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
