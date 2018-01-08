package cn.bnsr.edu_yun.frontstage.base.view;

/**
 * 用户详细信息视图
 * @author fangxiongwei
 * @date 2016年11月7日
 */
public class UserDetailView {
	private String userId;
	private String userName;
	private String phone;
	private String email;
	private String wealth;//财富
	private String score;//积分
	private String realName;//真实姓名
	private String remarks;//备注
	private String userType;//1-网站用户；2-网站管理用户；3-网站老师
	private String sex;//性别 0-女；1-男；2-未知
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWealth() {
		return wealth;
	}
	public void setWealth(String wealth) {
		this.wealth = wealth;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
}
