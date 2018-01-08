package cn.bnsr.edu_yun.frontstage.xbjy.view;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

public class LessonDesignView extends PageBase{
	
	private Long id;
	private Long lesson_id;
	private String edu_goal;//教育目标
	private String lesson_divide;//课时划分
	private String materials_analysis;//教材及内容分析
	private String student_analysis;//学生学情分析
	private String strategy_design;//教学策略选择与设计
	private String focus_difficulty;//教学重点与难点
	private String media_selection;//教学媒体选择
	private String teaching_process;//教学过程
	private String typography_design;//板书设计
	private String create_time;//发表时间
	private Long user_id;//发表人
	private Integer version_num;//版本号
	private Integer status;
	private String fileUrl;
	
	private String username;
	private String compare;//first last before
	private String true_name;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getLesson_id() {
		return lesson_id;
	}
	public void setLesson_id(Long lesson_id) {
		this.lesson_id = lesson_id;
	}
	public String getEdu_goal() {
		return edu_goal;
	}
	public void setEdu_goal(String edu_goal) {
		this.edu_goal = edu_goal;
	}
	public String getLesson_divide() {
		return lesson_divide;
	}
	public void setLesson_divide(String lesson_divide) {
		this.lesson_divide = lesson_divide;
	}
	public String getMaterials_analysis() {
		return materials_analysis;
	}
	public void setMaterials_analysis(String materials_analysis) {
		this.materials_analysis = materials_analysis;
	}
	public String getStudent_analysis() {
		return student_analysis;
	}
	public void setStudent_analysis(String student_analysis) {
		this.student_analysis = student_analysis;
	}
	public String getStrategy_design() {
		return strategy_design;
	}
	public void setStrategy_design(String strategy_design) {
		this.strategy_design = strategy_design;
	}
	public String getFocus_difficulty() {
		return focus_difficulty;
	}
	public void setFocus_difficulty(String focus_difficulty) {
		this.focus_difficulty = focus_difficulty;
	}
	public String getMedia_selection() {
		return media_selection;
	}
	public void setMedia_selection(String media_selection) {
		this.media_selection = media_selection;
	}
	public String getTeaching_process() {
		return teaching_process;
	}
	public void setTeaching_process(String teaching_process) {
		this.teaching_process = teaching_process;
	}
	public String getTypography_design() {
		return typography_design;
	}
	public void setTypography_design(String typography_design) {
		this.typography_design = typography_design;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public Integer getVersion_num() {
		return version_num;
	}
	public void setVersion_num(Integer version_num) {
		this.version_num = version_num;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getCompare() {
		return compare;
	}
	public void setCompare(String compare) {
		this.compare = compare;
	}
	public String getTrue_name() {
		return true_name;
	}
	public void setTrue_name(String true_name) {
		this.true_name = true_name;
	}

	
	
}
