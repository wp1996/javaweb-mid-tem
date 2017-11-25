package mid.bean;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mid.term.CommonDb;

public class User {
	private String user_name;
	private String user_email;
	private String user_psd;
	private static String image_url;
	private ResultSet rs = null;
	
	public String getUrlByName(String user_name) {
		String sql = "SELECT * FROM user WHERE user_name=?";
		String url = "";
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setString(1, user_name);
			rs = ps.executeQuery();
			if(rs.first()) {
				url = rs.getString("image_url");
			}else {
				url = "≤È—Ø ß∞‹";
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return url;
	}
	
	public void initByName(String user_name) {
		String sql = "SELECT * FROM user WHERE user_name=?";
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setString(1, user_name);
			rs = ps.executeQuery();
			this.user_name = rs.getString("user_name");
			this.user_email = rs.getString("user_email");
			this.user_psd = rs.getString("user_psd");
			this.image_url = rs.getString("image_url");
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public String getImage_url() {
		return image_url;
	}

	public void setImage_url(String url) {
		image_url = url;
	}

	public User() {
		this.user_name = "";
		this.user_email = "";
		this.user_psd = "";
	}
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_psd() {
		return user_psd;
	}
	public void setUser_psd(String user_psd) {
		this.user_psd = user_psd;
	}
}
