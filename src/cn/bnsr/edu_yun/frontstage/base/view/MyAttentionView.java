package cn.bnsr.edu_yun.frontstage.base.view;

import java.util.Date;

public class MyAttentionView {
	private long id;
	private int count;//统计用
	private long userId;// 用户id
	private String realName;// 真实姓名
	private String img;// 头像路径
	private String titles;// 职称
	private int agreeCount;// 点赞数
	private long attentionId;//关注用户id
	private long myFans;//我的粉丝id
	private int support;//0—未点赞 1—已点赞
	private int teacher;//判断用户是否是老师 0—不是 1—是
	private String school;
	private Date attent_time;
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getTitles() {
		return titles;
	}
	public void setTitles(String titles) {
		this.titles = titles;
	}
	public int getAgreeCount() {
		return agreeCount;
	}
	public void setAgreeCount(int agreeCount) {
		this.agreeCount = agreeCount;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public long getAttentionId() {
		return attentionId;
	}
	public void setAttentionId(long attentionId) {
		this.attentionId = attentionId;
	}
	public long getMyFans() {
		return myFans;
	}
	public void setMyFans(long myFans) {
		this.myFans = myFans;
	}
	public int getSupport() {
		return support;
	}
	public void setSupport(int support) {
		this.support = support;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public int getTeacher() {
		return teacher;
	}
	public void setTeacher(int teacher) {
		this.teacher = teacher;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public Date getAttent_time() {
		return attent_time;
	}
	public void setAttent_time(Date attent_time) {
		this.attent_time = attent_time;
	}
	
	
	
	

	
	
	

}
