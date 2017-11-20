package mid.bean;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mid.term.CommonDb;

public class blogBean {
	private int id;
	private String title;
	private String content;
	private String author_name;
	private int access_count;
	private String savetime;
	private ResultSet rs = null;
	
	public ResultSet getBlogs(String author_name) {
		String sql = "SELECT * FROM blog WHERE author_name=? ORDER BY id DESC";
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setString(1, author_name);
			rs = ps.executeQuery();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public ResultSet getBlogById(int id) {
		String sql = "SELECT * FROM blog WHERE id=?";
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public ResultSet getBlogsByKey(String key) {
		String sql = "SELECT * FROM blog WHERE title LIKE ? ORDER BY id DESC";
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setString(1, '%' + key + '%');
			rs = ps.executeQuery();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getAuthor_name() {
		return author_name;
	}
	public void setAuthor_name(String author_name) {
		this.author_name = author_name;
	}
	
	public int getAccess_count() {
		return access_count;
	}
	public void setAccess_count(int access_count) {
		this.access_count = access_count;
	}
	
	public String getSavetime() {
		return savetime;
	}
	public void setSavetime(String savetime) {
		this.savetime = savetime;
	}
}
