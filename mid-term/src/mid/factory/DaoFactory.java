package mid.factory;

import mid.bean.User;
import mid.bean.blogBean;
import mid.dao.IUserDao;
import mid.dao.impl.UserDaoImpl;
import mid.term.pool;

public class DaoFactory {
	
	public static pool getPool() {
		return new pool();
	}
	
	public static IUserDao getUserDaoInstance() {
		return new UserDaoImpl();
	}
	
	public static blogBean getblogBean() {
		return new blogBean();
	}
	
	public static User getUser() {
		return new User();
	}
}
