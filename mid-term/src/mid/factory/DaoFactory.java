package mid.factory;

import mid.bean.blogBean;
import mid.dao.IUserDao;
import mid.dao.impl.UserDaoImpl;

public class DaoFactory {
	
	public static IUserDao getUserDaoInstance() {
		return new UserDaoImpl();
	}
	
	public static blogBean getblogBean() {
		return new blogBean();
	}
}