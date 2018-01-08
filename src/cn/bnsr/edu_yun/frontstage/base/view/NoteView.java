package cn.bnsr.edu_yun.frontstage.base.view;

import java.util.Date;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

public class NoteView extends PageBase{

	private long note_id;//笔记id
	private long course_id;//课程id
	private String course_title;//课程标题
	private String course_picture;//课程图片courseIds
	
	private int noteNum;//指定课程笔记数量
	private Date noteTime;//笔记时间
	private String noteContent;//笔记内容
	
	private long course_hour_id;//课时id
	private String course_hour_title;//课时标题
	
	private long user_id;
	public long getCourse_id() {
		return course_id;
	}
	public void setCourse_id(long course_id) {
		this.course_id = course_id;
	}
	public String getCourse_title() {
		return course_title;
	}
	public void setCourse_title(String course_title) {
		this.course_title = course_title;
	}
	public String getCourse_picture() {
		return course_picture;
	}
	public void setCourse_picture(String course_picture) {
		this.course_picture = course_picture;
	}
	public int getNoteNum() {
		return noteNum;
	}
	public void setNoteNum(int noteNum) {
		this.noteNum = noteNum;
	}
	public Date getNoteTime() {
		return noteTime;
	}
	public void setNoteTime(Date noteTime) {
		this.noteTime = noteTime;
	}
	public String getNoteContent() {
		return noteContent;
	}
	public void setNoteContent(String noteContent) {
		this.noteContent = noteContent;
	}
	public long getCourse_hour_id() {
		return course_hour_id;
	}
	public void setCourse_hour_id(long course_hour_id) {
		this.course_hour_id = course_hour_id;
	}
	public String getCourse_hour_title() {
		return course_hour_title;
	}
	public void setCourse_hour_title(String course_hour_title) {
		this.course_hour_title = course_hour_title;
	}
	public long getUser_id() {
		return user_id;
	}
	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}
	public long getNote_id() {
		return note_id;
	}
	public void setNote_id(long note_id) {
		this.note_id = note_id;
	}
	
	
	
}
