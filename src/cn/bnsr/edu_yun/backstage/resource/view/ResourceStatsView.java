package cn.bnsr.edu_yun.backstage.resource.view;

public class ResourceStatsView {
	private String days;//日期
	private int resourceType;//0-资料库新增数；1-资料库使用数；2-资料库未使用数；3-资源新增数；4-资源审核通过数；
	//5-资源审核未通过数；6-资源浏览数；7-资源收藏数；8-资源下载数
	private int timeType;//0-本月；1-上月；2-近三月；3-起止时间；
	private String startTime;
	private String endTime;
	private int countNum;//总数
	private int newNum;//xx新增数
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public int getResourceType() {
		return resourceType;
	}
	public void setResourceType(int resourceType) {
		this.resourceType = resourceType;
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
	public int getCountNum() {
		return countNum;
	}
	public void setCountNum(int countNum) {
		this.countNum = countNum;
	}
	public int getNewNum() {
		return newNum;
	}
	public void setNewNum(int newNum) {
		this.newNum = newNum;
	}
	
	

}
