package cn.bnsr.edu_yun.frontstage.train.view;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

/**
 * 我的收藏
 * @author fangxiongwei
 * @date 2017年3月2日
 */
public class UserCollectView extends PageBase{
	private Long id;
	private String title;//标题
	private String img;//图片
	private Double price;//价格
	private int studentNum;//学员数
	private int appraiseNum;//评价数
	private int appraiseScore;//评分
	private Long userId;
	private int source_type;//0-课程；1-班级
	private String userName;
	private String school;
	private String titles;//职称
	private String true_name;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public int getStudentNum() {
		return studentNum;
	}
	public void setStudentNum(int studentNum) {
		this.studentNum = studentNum;
	}
	public int getAppraiseNum() {
		return appraiseNum;
	}
	public void setAppraiseNum(int appraiseNum) {
		this.appraiseNum = appraiseNum;
	}
	public int getAppraiseScore() {
		return appraiseScore;
	}
	public void setAppraiseScore(int appraiseScore) {
		this.appraiseScore = appraiseScore;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public int getSource_type() {
		return source_type;
	}
	public void setSource_type(int source_type) {
		this.source_type = source_type;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getTrue_name() {
		return true_name;
	}
	public void setTrue_name(String true_name) {
		this.true_name = true_name;
	}
	public String getTitles() {
		return titles;
	}
	public void setTitles(String titles) {
		this.titles = titles;
	}
	
	
	
}
