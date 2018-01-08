package cn.bnsr.edu_yun.frontstage.xbjy.view;

public class LessonUserTaskView {

	
	private long id;
	private long lesson_id;
	private long user_id;
	private int purview;//用户被分配的任务编号
	private int status;//完成状态:0未开始 1进行中 2已完成
	
	private String true_name;
	private String user_name;
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
	public long getUser_id() {
		return user_id;
	}
	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}
	public int getPurview() {
		return purview;
	}
	public void setPurview(int purview) {
		this.purview = purview;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	/**
	 * @return the true_name
	 */
	public String getTrue_name() {
		return true_name;
	}
	/**
	 * @param true_name the true_name to set
	 */
	public void setTrue_name(String true_name) {
		this.true_name = true_name;
	}
	/**
	 * @return the user_name
	 */
	public String getUser_name() {
		return user_name;
	}
	/**
	 * @param user_name the user_name to set
	 */
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	
}
