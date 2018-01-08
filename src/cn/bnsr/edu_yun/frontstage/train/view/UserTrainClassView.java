package cn.bnsr.edu_yun.frontstage.train.view;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;
/***
 * 用户培训班级视图
 * @author heliwei
 *
 */
public class UserTrainClassView extends PageBase{
	private Long id;
	private Long source_id;//培训id
	private Long user_id;//用户id
	private Long class_id;//班级id
	private Integer is_studyed;//是否学完：0-否，1-是
	private int is_required;//是否必修：0-是；1-否
	private Long course_id;//课程id
	private int source_type;//来源类型：0-培训；1-培训阶段
	private Long user_study_id;//用户学习id
	private int finish_hours_total;//完成课程学时数
	private int unfinish_hours_total;//未完成课程学时数
	private int hours_total;//课程学时数
	private int course_total;//已选课程数
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getSource_id() {
		return source_id;
	}

	public void setSource_id(Long source_id) {
		this.source_id = source_id;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public Long getClass_id() {
		return class_id;
	}

	public void setClass_id(Long class_id) {
		this.class_id = class_id;
	}

	public Integer getIs_studyed() {
		return is_studyed;
	}

	public void setIs_studyed(Integer is_studyed) {
		this.is_studyed = is_studyed;
	}

	public Long getCourse_id() {
		return course_id;
	}

	public void setCourse_id(Long course_id) {
		this.course_id = course_id;
	}

	public int getSource_type() {
		return source_type;
	}

	public void setSource_type(int source_type) {
		this.source_type = source_type;
	}

	public Long getUser_study_id() {
		return user_study_id;
	}

	public void setUser_study_id(Long user_study_id) {
		this.user_study_id = user_study_id;
	}

	public int getCourse_total() {
		return course_total;
	}

	public void setCourse_total(int course_total) {
		this.course_total = course_total;
	}

	public int getFinish_hours_total() {
		return finish_hours_total;
	}

	public void setFinish_hours_total(int finish_hours_total) {
		this.finish_hours_total = finish_hours_total;
	}

	public int getUnfinish_hours_total() {
		return unfinish_hours_total;
	}

	public void setUnfinish_hours_total(int unfinish_hours_total) {
		this.unfinish_hours_total = unfinish_hours_total;
	}

	public int getHours_total() {
		return hours_total;
	}

	public void setHours_total(int hours_total) {
		this.hours_total = hours_total;
	}

	public int getIs_required() {
		return is_required;
	}

	public void setIs_required(int is_required) {
		this.is_required = is_required;
	}

	
}
