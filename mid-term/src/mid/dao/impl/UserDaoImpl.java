package mid.dao.impl;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mid.bean.User;
import mid.dao.IUserDao;
import mid.term.CommonDb;

public class UserDaoImpl implements IUserDao {

	@Override
	public User getUserByName(String userName) {
		String sql = "SELECT * FROM user WHERE user_name=? LIMIT 1";
		User user = new User();
		PreparedStatement ps = CommonDb.executePreparedStatement(sql);
		try {
			ps.setString(1, userName);
			ResultSet rs = ps.executeQuery();
			if (rs.first()) {
				user.setUser_name(rs.getString("user_name"));
				user.setUser_email(rs.getString("user_email"));
				user.setUser_psd(rs.getString("user_psd"));
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public User getUserByEmail(String userEmail) {
		String sql = "SELECT * FROM user WHERE user_email=? LIMIT 1";
		User user = new User();
		PreparedStatement ps = CommonDb.executePreparedStatement(sql);
		try {
			ps.setString(1, userEmail);
			ResultSet rs = ps.executeQuery();
			if (rs.first()) {
				user.setUser_name(rs.getString("user_name"));
				user.setUser_email(rs.getString("user_email"));
				user.setUser_psd(rs.getString("user_psd"));
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

}
