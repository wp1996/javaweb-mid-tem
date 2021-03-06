package mid.bean;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.jsp.tagext.TryCatchFinally;

import mid.term.CommonDb;

public class blogBean {
	private int id;
	private String title;
	private String content;
	private String author_name;
	private int access_count;
	private String savetime;
	private ResultSet rs = null;
	
	public ResultSet getBlogsByPage(int page) {
		int start = (page - 1) * 10;
		int len = 10;
		String sql = "SELECT * FROM blog ORDER BY id DESC LIMIT ?, ?";
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, len);
			rs = ps.executeQuery();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public ResultSet initBlog() {
		String sql = "SELECT * FROM blog LIMIT 0, 50";
		try {
			PreparedStatement PS = CommonDb.executePreparedStatement(sql);
			rs = PS.executeQuery();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
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
	
	public int setAccesscount(int count, int id) {
		String sql = "UPDATE blog SET access_count=? WHERE id=?";
		int result = 0;
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setInt(1, count);
			ps.setInt(2, id);
			result = ps.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		this.access_count = count;
		return result;
	}
	
	public ResultSet getAllBlogs() {
		String sql = "SELECT * FROM blog ORDER BY id DESC LIMIT 10";
		ResultSet rs = null;
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
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
