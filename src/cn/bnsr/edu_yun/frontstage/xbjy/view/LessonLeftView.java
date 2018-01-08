package cn.bnsr.edu_yun.frontstage.xbjy.view;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.User;


public class LessonLeftView {


	private int userPlan;//计划环节权限
	private int userPrepare;//备课环节权限
	private int userClass;//上课环节权限
	private int userAssessment;//评课环节权限
	private int userIntrospection;//反思环节权限
	private int userIdentity;//用户在该课例中身份
	
	private  List<LessonUserTaskView> lessonUserPurviewList;
	private  List<LessonUserIdentityView> lessonUserList;
	private  User user;
	private int userInLesson;//登录用户是否为组员0为不是，1为是
	
	// 左侧列表全部任务完成状态
	private int plan101;
	private int plan102;
	private int plan103;
	private int prepare201;
	private int prepare202;
	private int prepare203;
	private int prepare204;
	private int class301;
	private int class302;
	private int class303;
	private int class304;
	private int assessment401;
	private int assessment402;
	private int assessment403;
	private int introspection501;
	private int introspection502;
	private int introspection503;
	
	public int getPlan102() {
		return plan102;
	}
	public void setPlan102(int plan102) {
		this.plan102 = plan102;
	}
	public int getPlan103() {
		return plan103;
	}
	public void setPlan103(int plan103) {
		this.plan103 = plan103;
	}
	public int getPrepare201() {
		return prepare201;
	}
	public void setPrepare201(int prepare201) {
		this.prepare201 = prepare201;
	}
	public int getPrepare202() {
		return prepare202;
	}
	public void setPrepare202(int prepare202) {
		this.prepare202 = prepare202;
	}
	public int getPrepare203() {
		return prepare203;
	}
	public void setPrepare203(int prepare203) {
		this.prepare203 = prepare203;
	}
	public int getPrepare204() {
		return prepare204;
	}
	public void setPrepare204(int prepare204) {
		this.prepare204 = prepare204;
	}
	public int getClass301() {
		return class301;
	}
	public void setClass301(int class301) {
		this.class301 = class301;
	}
	public int getClass302() {
		return class302;
	}
	public void setClass302(int class302) {
		this.class302 = class302;
	}
	public int getClass303() {
		return class303;
	}
	public void setClass303(int class303) {
		this.class303 = class303;
	}
	public int getClass304() {
		return class304;
	}
	public void setClass304(int class304) {
		this.class304 = class304;
	}
	public int getAssessment401() {
		return assessment401;
	}
	public void setAssessment401(int assessment401) {
		this.assessment401 = assessment401;
	}
	public int getAssessment402() {
		return assessment402;
	}
	public void setAssessment402(int assessment402) {
		this.assessment402 = assessment402;
	}
	public int getAssessment403() {
		return assessment403;
	}
	public void setAssessment403(int assessment403) {
		this.assessment403 = assessment403;
	}
	public int getIntrospection501() {
		return introspection501;
	}
	public void setIntrospection501(int introspection501) {
		this.introspection501 = introspection501;
	}
	public int getIntrospection502() {
		return introspection502;
	}
	public void setIntrospection502(int introspection502) {
		this.introspection502 = introspection502;
	}
	public int getIntrospection503() {
		return introspection503;
	}
	public void setIntrospection503(int introspection503) {
		this.introspection503 = introspection503;
	}
	public int getUserPlan() {
		return userPlan;
	}
	public void setUserPlan(int userPlan) {
		this.userPlan = userPlan;
	}
	public int getUserPrepare() {
		return userPrepare;
	}
	public void setUserPrepare(int userPrepare) {
		this.userPrepare = userPrepare;
	}
	public int getUserClass() {
		return userClass;
	}
	public void setUserClass(int userClass) {
		this.userClass = userClass;
	}
	public int getUserAssessment() {
		return userAssessment;
	}
	public void setUserAssessment(int userAssessment) {
		this.userAssessment = userAssessment;
	}
	public int getUserIntrospection() {
		return userIntrospection;
	}
	public void setUserIntrospection(int userIntrospection) {
		this.userIntrospection = userIntrospection;
	}
	public int getUserIdentity() {
		return userIdentity;
	}
	public void setUserIdentity(int userIdentity) {
		this.userIdentity = userIdentity;
	}
	/**
	 * @return the lessonUserPurviewList
	 */
	public List<LessonUserTaskView> getLessonUserPurviewList() {
		return lessonUserPurviewList;
	}
	/**
	 * @param lessonUserPurviewList the lessonUserPurviewList to set
	 */
	public void setLessonUserPurviewList(List<LessonUserTaskView> lessonUserPurviewList) {
		this.lessonUserPurviewList = lessonUserPurviewList;
	}
	/**
	 * @return the lessonUserList
	 */
	public List<LessonUserIdentityView> getLessonUserList() {
		return lessonUserList;
	}
	/**
	 * @param lessonUserList the lessonUserList to set
	 */
	public void setLessonUserList(List<LessonUserIdentityView> lessonUserList) {
		this.lessonUserList = lessonUserList;
	}
	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}
	/**
	 * @param user the user to set
	 */
	public void setUser(User user) {
		this.user = user;
	}
	/**
	 * @return the plan101
	 */
	public int getPlan101() {
		return plan101;
	}
	/**
	 * @param plan101 the plan101 to set
	 */
	public void setPlan101(int plan101) {
		this.plan101 = plan101;
	}
	/**
	 * @return the userInLesson
	 */
	public int getUserInLesson() {
		return userInLesson;
	}
	/**
	 * @param userInLesson the userInLesson to set
	 */
	public void setUserInLesson(int userInLesson) {
		this.userInLesson = userInLesson;
	}
	
}
