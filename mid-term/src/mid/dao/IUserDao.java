package mid.dao;

import mid.bean.User;

public interface IUserDao {
	/**
	 * �����û��������û�
	 * @return User����
	 */
	public User getUserByName(String userName);
	
	/**
	 * ������������û�
	 * @return User����
	 */
	public User getUserByEmail(String userEmail);
}
