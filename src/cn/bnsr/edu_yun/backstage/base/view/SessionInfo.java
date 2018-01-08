package cn.bnsr.edu_yun.backstage.base.view;

/**
 * session模型
 * @author fangxiongwei
 * @date 2016年9月1日
 */
public class SessionInfo implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	private Long userId;// 用户ID
	private String userName;// 用户登录名称
	private String icon;//用户头像
	
	private String authNames;// 拥有的权限name集合
	private String authUrls;// 权限的url集合
	
	private String remote_ip;//远程
	private Integer level;//等级
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getAuthNames() {
		return authNames;
	}
	public void setAuthNames(String authNames) {
		this.authNames = authNames;
	}
	public String getAuthUrls() {
		return authUrls;
	}
	public void setAuthUrls(String authUrls) {
		this.authUrls = authUrls;
	}
	public String getRemote_ip() {
		return remote_ip;
	}
	public void setRemote_ip(String remote_ip) {
		this.remote_ip = remote_ip;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	

}
