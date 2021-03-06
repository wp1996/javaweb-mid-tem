package mid.bean;
import java.nio.channels.SelectableChannel;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.omg.CORBA.PRIVATE_MEMBER;
import org.omg.PortableServer.ID_ASSIGNMENT_POLICY_ID;
import mid.term.CommonDb;

public class commentBean {
	private int id; // blog_id
	private String comment;
	private String commenter_name;
	private String addtime;
	private int result;
	private ResultSet rs = null;
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public int saveComment() {
		this.addtime = df.format(new Date());
		String sql = "INSERT INTO comment (blog_id,comment,commenter_name,addtime) VALUES(?,?,?,?)";
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setInt(1, this.id);
			ps.setString(2, this.comment);
			ps.setString(3, this.commenter_name);
			ps.setString(4, this.addtime);
			result = ps.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public ResultSet getCommentsById() {
		String sql = "SELECT * FROM comment WHERE blog_id=? ORDER BY id DESC";
		try {
			PreparedStatement ps = CommonDb.executePreparedStatement(sql);
			ps.setInt(1, this.id);
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
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getCommenter_name() {
		return commenter_name;
	}
	public void setCommenter_name(String commenter_name) {
		this.commenter_name = commenter_name;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
}
