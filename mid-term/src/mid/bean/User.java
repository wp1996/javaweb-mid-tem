package mid.bean;

public class User {
	private String user_name;
	private String user_email;
	private String user_psd;
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
