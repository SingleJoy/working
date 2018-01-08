package cn.bnsr.edu_yun.frontstage.train.view;


/**
 * 教师关联视图 0-课程；1-课程班级；2-培训班级
 * @author fangxiongwei
 * @date 2016年11月6日
 */
public class TeacherRelationView {
	private String icon;
	private String teacherName;
	private String seq;
	private String isDisplay;//是否显示 0-是；1-否
	private Long id;//
	private String userId;//
	private Long source_id;//
	private int source_type;//来源类型：0-课程；1-班级；2-培训班级
	private String titles;//职称
	private String profile;//
	private int type;//类型：0-教师；1-助教；2-班主任
	
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	
	public String getIsDisplay() {
		return isDisplay;
	}
	public void setIsDisplay(String isDisplay) {
		this.isDisplay = isDisplay;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Long getSource_id() {
		return source_id;
	}
	public void setSource_id(Long source_id) {
		this.source_id = source_id;
	}
	public int getSource_type() {
		return source_type;
	}
	public void setSource_type(int source_type) {
		this.source_type = source_type;
	}
	public String getTitles() {
		return titles;
	}
	public void setTitles(String titles) {
		this.titles = titles;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
}
