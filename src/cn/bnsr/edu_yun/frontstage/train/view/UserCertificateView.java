package cn.bnsr.edu_yun.frontstage.train.view;

import java.util.Date;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

public class UserCertificateView extends PageBase {

	private Long user_study_id;
	private Long user_id;
	private String course_name;
	private String classes;
	private double score;
	private Date complete_time;
	private Long cert_id;
	private String cert_name;
	private Integer source_type;//课程：0，培训：1
	private Long course_id;
	
	private Long train_id;
	private Integer train_type;//培训类型：0-普通培训；1-阶段培训
	private Integer required_ratio;//必修课比例
	private Integer option_ratio;//选修课比例
	private Integer is_required;//培训课程 是否必修：0-是；1-否
	
	public Long getUser_study_id() {
		return user_study_id;
	}
	public void setUser_study_id(Long user_study_id) {
		this.user_study_id = user_study_id;
	}
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
	public String getClasses() {
		return classes;
	}
	public void setClasses(String classes) {
		this.classes = classes;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public Date getComplete_time() {
		return complete_time;
	}
	public void setComplete_time(Date complete_time) {
		this.complete_time = complete_time;
	}
	public Long getCert_id() {
		return cert_id;
	}
	public void setCert_id(Long cert_id) {
		this.cert_id = cert_id;
	}
	public String getCert_name() {
		return cert_name;
	}
	public void setCert_name(String cert_name) {
		this.cert_name = cert_name;
	}
	public Integer getSource_type() {
		return source_type;
	}
	public void setSource_type(Integer source_type) {
		this.source_type = source_type;
	}
	public Long getCourse_id() {
		return course_id;
	}
	public void setCourse_id(Long course_id) {
		this.course_id = course_id;
	}
	public Long getTrain_id() {
		return train_id;
	}
	public void setTrain_id(Long train_id) {
		this.train_id = train_id;
	}
	public Integer getTrain_type() {
		return train_type;
	}
	public void setTrain_type(Integer train_type) {
		this.train_type = train_type;
	}
	public Integer getRequired_ratio() {
		return required_ratio;
	}
	public void setRequired_ratio(Integer required_ratio) {
		this.required_ratio = required_ratio;
	}
	public Integer getOption_ratio() {
		return option_ratio;
	}
	public void setOption_ratio(Integer option_ratio) {
		this.option_ratio = option_ratio;
	}
	public Integer getIs_required() {
		return is_required;
	}
	public void setIs_required(Integer is_required) {
		this.is_required = is_required;
	}
	
}
