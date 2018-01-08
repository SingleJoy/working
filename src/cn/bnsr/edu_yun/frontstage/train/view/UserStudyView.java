package cn.bnsr.edu_yun.frontstage.train.view;

import java.util.Date;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

public class UserStudyView extends PageBase {

	private String icon;
	private String studentName;
	private String remarks;
	private String id;//
	private String userId;//
	private String sourceId;
	private String sourceType;//来源类型：0-课程班级；1-培训班级
	private String learnId;//来源：   课程；培训
	private String addTime;//加入时间
	private String validityTime;//有效期至
	private String overTime;//剩余时间
	private String isAttent;//是否关注 0-是；1-否
	private String is_studyed;//是否学完：0-否，1-是
	private String is_direct;//是否直接加入：0-是；1-否(培训下的课程)
	private Double study_progress;//学习进度
	
	private int attentNum;//关注数
	private int fansNum;//粉丝数
	private int learnNum;//在学数
	private String profile;//签名简介
	private String realName;//真实姓名
	private String paging;//是否分页：0 不分页；1 分页
	
	private Integer tab;//(直接跳转：0，查询后跳转：1)/
	private Integer elite;//
	private String course_hour_id;//
	private String sort;
	private String q_sort;//
	private Integer look;//
	private Long questionId;//问题id
	
	private int viewType;//浏览类型 0-普通；1-已购买；2-未购买
	private int trainType;//培训类型 0-普通培训;1-培训阶段
	private Integer status;
	
	private int jumpType;//跳转类型 0-普通；1-社区；2-工作坊
	private Long jumpId;//跳转id
	
	private Date last_browse_time;//上一次浏览时间
	
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSourceId() {
		return sourceId;
	}
	public void setSourceId(String sourceId) {
		this.sourceId = sourceId;
	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public String getLearnId() {
		return learnId;
	}
	public void setLearnId(String learnId) {
		this.learnId = learnId;
	}
	public String getAddTime() {
		return addTime;
	}
	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}
	public String getValidityTime() {
		return validityTime;
	}
	public void setValidityTime(String validityTime) {
		this.validityTime = validityTime;
	}
	public String getOverTime() {
		return overTime;
	}
	public void setOverTime(String overTime) {
		this.overTime = overTime;
	}
	public String getIsAttent() {
		return isAttent;
	}
	public void setIsAttent(String isAttent) {
		this.isAttent = isAttent;
	}
	public String getIs_studyed() {
		return is_studyed;
	}
	public void setIs_studyed(String is_studyed) {
		this.is_studyed = is_studyed;
	}
	public Double getStudy_progress() {
		return study_progress;
	}
	public void setStudy_progress(Double study_progress) {
		this.study_progress = study_progress;
	}
	public int getAttentNum() {
		return attentNum;
	}
	public void setAttentNum(int attentNum) {
		this.attentNum = attentNum;
	}
	public int getFansNum() {
		return fansNum;
	}
	public void setFansNum(int fansNum) {
		this.fansNum = fansNum;
	}
	public int getLearnNum() {
		return learnNum;
	}
	public void setLearnNum(int learnNum) {
		this.learnNum = learnNum;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getPaging() {
		return paging;
	}
	public void setPaging(String paging) {
		this.paging = paging;
	}
	public Integer getTab() {
		return tab;
	}
	public void setTab(Integer tab) {
		this.tab = tab;
	}
	public Integer getElite() {
		return elite;
	}
	public void setElite(Integer elite) {
		this.elite = elite;
	}
	public String getCourse_hour_id() {
		return course_hour_id;
	}
	public void setCourse_hour_id(String course_hour_id) {
		this.course_hour_id = course_hour_id;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getQ_sort() {
		return q_sort;
	}
	public void setQ_sort(String q_sort) {
		this.q_sort = q_sort;
	}
	public Integer getLook() {
		return look;
	}
	public void setLook(Integer look) {
		this.look = look;
	}
	public Long getQuestionId() {
		return questionId;
	}
	public void setQuestionId(Long questionId) {
		this.questionId = questionId;
	}
	public String getIs_direct() {
		return is_direct;
	} 
	public void setIs_direct(String is_direct) {
		this.is_direct = is_direct;
	}
	public int getViewType() {
		return viewType;
	}
	public void setViewType(int viewType) {
		this.viewType = viewType;
	}
	public int getTrainType() {
		return trainType;
	}
	public void setTrainType(int trainType) {
		this.trainType = trainType;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public int getJumpType() {
		return jumpType;
	}
	public void setJumpType(int jumpType) {
		this.jumpType = jumpType;
	}
	public Long getJumpId() {
		return jumpId;
	}
	public void setJumpId(Long jumpId) {
		this.jumpId = jumpId;
	}
	public Date getLast_browse_time() {
		return last_browse_time;
	}
	public void setLast_browse_time(Date last_browse_time) {
		this.last_browse_time = last_browse_time;
	}
	
	
}
