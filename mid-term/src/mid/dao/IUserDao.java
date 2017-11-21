package mid.dao;

import mid.bean.User;

public interface IUserDao {
	/**
	 * 根据用户名查找用户
	 * @return User对象
	 */
	public User getUserByName(String userName);
	
	/**
	 * 根据邮箱查找用户
	 * @return User对象
	 */
	public User getUserByEmail(String userEmail);
}
