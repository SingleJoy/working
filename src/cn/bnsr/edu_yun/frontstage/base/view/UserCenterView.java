package cn.bnsr.edu_yun.frontstage.base.view;

/**
 * 个人中心视图
 * @author fangxiongwei
 * @date 2017年6月28日
 */
public class UserCenterView {
	private Long id;
	private int studyCourse;//在学课程
	private int teachingCourse;//在教课程
	private int studyTrain;//在学培训
	private int teachingTrain;//在教培训
	private int createLesson;//创建的课例
	private int continueDay;//连续学习天数
	private long studytime;//累计学习时间 时
	private long studytimeM;//累计学习时间 分
	private int resourceNum;//资源数 
	private int studyedCourse;//完成课程
	private int studyedTrain;//完成培训
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public int getStudyCourse() {
		return studyCourse;
	}
	public void setStudyCourse(int studyCourse) {
		this.studyCourse = studyCourse;
	}
	public int getTeachingCourse() {
		return teachingCourse;
	}
	public void setTeachingCourse(int teachingCourse) {
		this.teachingCourse = teachingCourse;
	}
	public int getStudyTrain() {
		return studyTrain;
	}
	public void setStudyTrain(int studyTrain) {
		this.studyTrain = studyTrain;
	}
	public int getTeachingTrain() {
		return teachingTrain;
	}
	public void setTeachingTrain(int teachingTrain) {
		this.teachingTrain = teachingTrain;
	}
	public int getCreateLesson() {
		return createLesson;
	}
	public void setCreateLesson(int createLesson) {
		this.createLesson = createLesson;
	}
	public int getContinueDay() {
		return continueDay;
	}
	public void setContinueDay(int continueDay) {
		this.continueDay = continueDay;
	}
	public long getStudytime() {
		return studytime;
	}
	public void setStudytime(long studytime) {
		this.studytime = studytime;
	}
	public int getResourceNum() {
		return resourceNum;
	}
	public void setResourceNum(int resourceNum) {
		this.resourceNum = resourceNum;
	}
	public int getStudyedCourse() {
		return studyedCourse;
	}
	public void setStudyedCourse(int studyedCourse) {
		this.studyedCourse = studyedCourse;
	}
	public long getStudytimeM() {
		return studytimeM;
	}
	public void setStudytimeM(long studytimeM) {
		this.studytimeM = studytimeM;
	}
	public int getStudyedTrain() {
		return studyedTrain;
	}
	public void setStudyedTrain(int studyedTrain) {
		this.studyedTrain = studyedTrain;
	}
	
	
}
