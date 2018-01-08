package cn.bnsr.edu_yun.frontstage.train.view;

import java.util.Date;

public class UserClassHourView {

    private Long id;

    private Long user_id;

    private Long course_hour_id;

    private Long course_id;

    private Integer is_studyed;

    private Long class_id;
 
    private Date create_time;
    
    private Integer attribute_type;//所属类型  0-试卷；1-章节；2-课时；3-讨论；4-作业
    
    private Date studyed_time;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public Long getCourse_hour_id() {
		return course_hour_id;
	}

	public void setCourse_hour_id(Long course_hour_id) {
		this.course_hour_id = course_hour_id;
	}

	public Long getCourse_id() {
		return course_id;
	}

	public void setCourse_id(Long course_id) {
		this.course_id = course_id;
	}

	public Integer getIs_studyed() {
		return is_studyed;
	}

	public void setIs_studyed(Integer is_studyed) {
		this.is_studyed = is_studyed;
	}

	public Long getClass_id() {
		return class_id;
	}

	public void setClass_id(Long class_id) {
		this.class_id = class_id;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getAttribute_type() {
		return attribute_type;
	}

	public void setAttribute_type(Integer attribute_type) {
		this.attribute_type = attribute_type;
	}

	public Date getStudyed_time() {
		return studyed_time;
	}

	public void setStudyed_time(Date studyed_time) {
		this.studyed_time = studyed_time;
	}

    
}
