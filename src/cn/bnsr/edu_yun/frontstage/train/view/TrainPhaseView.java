package cn.bnsr.edu_yun.frontstage.train.view;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

/**
 * 培训阶段视图
 * @author fangxiongwei
 * @date 2017年3月21日
 */
public class TrainPhaseView extends PageBase{
	private Long id;
	private Long train_id;//培训id
	private int seq;//排序
	private String name;//阶段名称
	private int cycle;//周期(天)
	private String target;//目标
	private int hour_require;//学时要求
	
	private String ids;
	private String courseIds;//课程ids
	private String flag;//跳转方式 0-创建跳转，1-保存后跳转,2普通跳转
	private String sign;//标识哪个标签
	
	private int hours;//学时
	private String requiredIds;//必修课程id
	private String optionIds;//选修课程id
	private int requiredCount;//必修课总数
	private int requiredFinishCount;//必修课完成总数
	private int optionCount;//选修课总数
	private int requiredHours;//必修学时总数
	private int optionHours;//选修学时总数
	private int totleNum;//课程总数
	private int totalHourNum;//课时总数
	
	private List<CourseView> requiredCourse;//必修课程
	private List<CourseView> optionCourse;//选修课程
	private List<CourseView> unOptionCourse;//未选修课程
	private int optionCourseNum;//已选课时数
	private int is_studyed;//阶段是否学完：0-否，1-是
	private int finish_coursehour_total;//完成课时数
	private int unfinish_coursehour_total;//未完成课时数

	private List<CourseDataView> courseDataViewList;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getTrain_id() {
		return train_id;
	}
	public void setTrain_id(Long train_id) {
		this.train_id = train_id;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCycle() {
		return cycle;
	}
	public void setCycle(int cycle) {
		this.cycle = cycle;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public int getHour_require() {
		return hour_require;
	}
	public void setHour_require(int hour_require) {
		this.hour_require = hour_require;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getCourseIds() {
		return courseIds;
	}
	public void setCourseIds(String courseIds) {
		this.courseIds = courseIds;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public int getHours() {
		return hours;
	}
	public void setHours(int hours) {
		this.hours = hours;
	}
	public String getRequiredIds() {
		return requiredIds;
	}
	public void setRequiredIds(String requiredIds) {
		this.requiredIds = requiredIds;
	}
	public String getOptionIds() {
		return optionIds;
	}
	public void setOptionIds(String optionIds) {
		this.optionIds = optionIds;
	}
	public int getTotleNum() {
		return totleNum;
	}
	public void setTotleNum(int totleNum) {
		this.totleNum = totleNum;
	}
	public List<CourseView> getRequiredCourse() {
		return requiredCourse;
	}
	public void setRequiredCourse(List<CourseView> requiredCourse) {
		this.requiredCourse = requiredCourse;
	}
	public List<CourseView> getOptionCourse() {
		return optionCourse;
	}
	public void setOptionCourse(List<CourseView> optionCourse) {
		this.optionCourse = optionCourse;
	}
	public int getOptionCourseNum() {
		return optionCourseNum;
	}
	public void setOptionCourseNum(int optionCourseNum) {
		this.optionCourseNum = optionCourseNum;
	}
	public int getIs_studyed() {
		return is_studyed;
	}
	public void setIs_studyed(int is_studyed) {
		this.is_studyed = is_studyed;
	}
	public int getRequiredHours() {
		return requiredHours;
	}
	public void setRequiredHours(int requiredHours) {
		this.requiredHours = requiredHours;
	}
	public int getOptionHours() {
		return optionHours;
	}
	public void setOptionHours(int optionHours) {
		this.optionHours = optionHours;
	}
	public List<CourseView> getUnOptionCourse() {
		return unOptionCourse;
	}
	public void setUnOptionCourse(List<CourseView> unOptionCourse) {
		this.unOptionCourse = unOptionCourse;
	}
	public int getFinish_coursehour_total() {
		return finish_coursehour_total;
	}
	public void setFinish_coursehour_total(int finish_coursehour_total) {
		this.finish_coursehour_total = finish_coursehour_total;
	}
	public int getUnfinish_coursehour_total() {
		return unfinish_coursehour_total;
	}
	public void setUnfinish_coursehour_total(int unfinish_coursehour_total) {
		this.unfinish_coursehour_total = unfinish_coursehour_total;
	}
	public int getRequiredCount() {
		return requiredCount;
	}
	public void setRequiredCount(int requiredCount) {
		this.requiredCount = requiredCount;
	}
	public int getOptionCount() {
		return optionCount;
	}
	public void setOptionCount(int optionCount) {
		this.optionCount = optionCount;
	}
	public int getTotalHourNum() {
		return totalHourNum;
	}
	public void setTotalHourNum(int totalHourNum) {
		this.totalHourNum = totalHourNum;
	}
	public List<CourseDataView> getCourseDataViewList() {
		return courseDataViewList;
	}
	public void setCourseDataViewList(List<CourseDataView> courseDataViewList) {
		this.courseDataViewList = courseDataViewList;
	}
	public int getRequiredFinishCount() {
		return requiredFinishCount;
	}
	public void setRequiredFinishCount(int requiredFinishCount) {
		this.requiredFinishCount = requiredFinishCount;
	}
	
	
}
