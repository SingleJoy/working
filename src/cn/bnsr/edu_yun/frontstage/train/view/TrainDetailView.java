package cn.bnsr.edu_yun.frontstage.train.view;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

/**
 * 培训展示视图
 * @author fangxiongwei
 * @date 2017年1月18日
 */
public class TrainDetailView extends PageBase{
	
	private String courseId;//课程id
	private String courseName;//课程名称
	private List<String> courseIds;//课程ids
	private Long questionId;//问题id
	private int viewType;//浏览类型 0-普通；1-已购买；2-未购买
	
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public List<String> getCourseIds() {
		return courseIds;
	}
	public void setCourseIds(List<String> courseIds) {
		this.courseIds = courseIds;
	}
	public Long getQuestionId() {
		return questionId;
	}
	public void setQuestionId(Long questionId) {
		this.questionId = questionId;
	}
	public int getViewType() {
		return viewType;
	}
	public void setViewType(int viewType) {
		this.viewType = viewType;
	}
}
