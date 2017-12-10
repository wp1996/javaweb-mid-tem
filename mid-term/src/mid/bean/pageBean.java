package mid.bean;

import java.sql.ResultSet;

public class pageBean {
	private int pagenum;
	private int start;
	private int end;
	private ResultSet rs;
	
	public int getPageAllNums() {
		return 0;
	}
	
	public ResultSet getBlogsByPage(int pageNum) {
		return rs;
	}
}
