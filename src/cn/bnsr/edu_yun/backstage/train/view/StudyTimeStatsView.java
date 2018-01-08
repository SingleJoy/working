package cn.bnsr.edu_yun.backstage.train.view;

public class StudyTimeStatsView {

	private String days;//日期
	private int watchNum;//观看人数
	private int totalNum;//总观看时长
	private int averageNum;//平均每人观看时长
	private int timeUnit;//0-秒；1-分钟；2-小时；
	private int timeType;//0-本月；1-上月；2-近三月；3-起止时间；4-具体某天
	private String startTime;
	private String endTime;
	
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public int getWatchNum() {
		return watchNum;
	}
	public void setWatchNum(int watchNum) {
		this.watchNum = watchNum;
	}
	public int getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}
	public int getAverageNum() {
		return averageNum;
	}
	public void setAverageNum(int averageNum) {
		this.averageNum = averageNum;
	}
	public int getTimeUnit() {
		return timeUnit;
	}
	public void setTimeUnit(int timeUnit) {
		this.timeUnit = timeUnit;
	}
	public int getTimeType() {
		return timeType;
	}
	public void setTimeType(int timeType) {
		this.timeType = timeType;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	
}
