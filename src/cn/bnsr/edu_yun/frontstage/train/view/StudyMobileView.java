package cn.bnsr.edu_yun.frontstage.train.view;

public class StudyMobileView {

	private long course_id;
	private String img;//图片
	private String name;
	private String end_time;
	private int hours;
	private int studyNum;//学过课程
	private int allNum;//总课程
	private long class_id;
	private boolean can_study;
	
	public long getCourse_id() {
		return course_id;
	}
	public void setCourse_id(long course_id) {
		this.course_id = course_id;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public int getHours() {
		return hours;
	}
	public void setHours(int hours) {
		this.hours = hours;
	}
	public int getAllNum() {
		return allNum;
	}
	public void setAllNum(int allNum) {
		this.allNum = allNum;
	}
	public int getStudyNum() {
		return studyNum;
	}
	public void setStudyNum(int studyNum) {
		this.studyNum = studyNum;
	}
	public long getClass_id() {
		return class_id;
	}
	public void setClass_id(long class_id) {
		this.class_id = class_id;
	}
	public boolean isCan_study() {
		return can_study;
	}
	public void setCan_study(boolean can_study) {
		this.can_study = can_study;
	}
	
}
