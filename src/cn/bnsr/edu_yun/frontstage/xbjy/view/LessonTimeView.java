package cn.bnsr.edu_yun.frontstage.xbjy.view;

import java.util.Date;

public class LessonTimeView {

	
	private long id;
	private long lesson_id;
	private Date plan_sta;//计划环节开始时间
	private Date plan_end;//计划环节结束时间
	private Date prepare_sta;//备课环节开始时间
	private Date prepare_end;//备课环节结束时间
	private Date class_sta;//上课环节开始时间
	private Date class_end;//上课环节结束时间
	private Date assessment_sta;//评课环节开始时间
	private Date assessment_end;//评课环节结束时间
	private Date introspection_sta;//反思环节开始时间
	private Date introspection_end;//反思环节结束时间
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getLesson_id() {
		return lesson_id;
	}
	public void setLesson_id(long lesson_id) {
		this.lesson_id = lesson_id;
	}
	public Date getPlan_sta() {
		return plan_sta;
	}
	public void setPlan_sta(Date plan_sta) {
		this.plan_sta = plan_sta;
	}
	public Date getPlan_end() {
		return plan_end;
	}
	public void setPlan_end(Date plan_end) {
		this.plan_end = plan_end;
	}
	public Date getprepare_sta() {
		return prepare_sta;
	}
	public void setprepare_sta(Date prepare_sta) {
		this.prepare_sta = prepare_sta;
	}
	public Date getprepare_end() {
		return prepare_end;
	}
	public void setprepare_end(Date prepare_end) {
		this.prepare_end = prepare_end;
	}
	public Date getClass_sta() {
		return class_sta;
	}
	public void setClass_sta(Date class_sta) {
		this.class_sta = class_sta;
	}
	public Date getClass_end() {
		return class_end;
	}
	public void setClass_end(Date class_end) {
		this.class_end = class_end;
	}
	public Date getAssessment_sta() {
		return assessment_sta;
	}
	public void setAssessment_sta(Date assessment_sta) {
		this.assessment_sta = assessment_sta;
	}
	public Date getAssessment_end() {
		return assessment_end;
	}
	public void setAssessment_end(Date assessment_end) {
		this.assessment_end = assessment_end;
	}
	public Date getIntrospection_sta() {
		return introspection_sta;
	}
	public void setIntrospection_sta(Date introspection_sta) {
		this.introspection_sta = introspection_sta;
	}
	public Date getIntrospection_end() {
		return introspection_end;
	}
	public void setIntrospection_end(Date introspection_end) {
		this.introspection_end = introspection_end;
	}
	
}
