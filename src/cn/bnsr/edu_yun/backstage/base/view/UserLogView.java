package cn.bnsr.edu_yun.backstage.base.view;

public class UserLogView extends PageBase {
	
	private Long id;
	
	private Long user_id;
	
	private String username;
	
	private String phone;
	
	private String create_time;
	
	private String sys_name;
	
	private String do_from;
	
	private String login_ip;
	
	private String login_address;
	
	private String timeStart;
	
	private String timeEnd;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public String getLogin_ip() {
		return login_ip;
	}

	public void setLogin_ip(String login_ip) {
		this.login_ip = login_ip;
	}

	public String getLogin_address() {
		return login_address;
	}

	public void setLogin_address(String login_address) {
		this.login_address = login_address;
	}

	public String getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(String timeStart) {
		this.timeStart = timeStart;
	}

	public String getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(String timeEnd) {
		this.timeEnd = timeEnd;
	}

	public String getSys_name() {
		return sys_name;
	}

	public void setSys_name(String sys_name) {
		this.sys_name = sys_name;
	}

	public String getDo_from() {
		return do_from;
	}

	public void setDo_from(String do_from) {
		this.do_from = do_from;
	}
	

}
