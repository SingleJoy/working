package cn.bnsr.edu_yun.backstage.resource.view;

/**
 * 资源统计
 * @author fangxiongwei
 * @date 2016年9月27日
 */
public class FileStatsView {
	private String days;//日期
	private String year;//年
	private String month;//月
	private int uploadNum;//上传量
	private int downLoadNum;//下载量
	private int collectionNum;//收藏量
	private int clickNum;//点击浏览量
	private int buyNum;//购买数量
	private int timeUnit;//时间单位：0-按时；1-按日；2-按周；3-按月；
	private Integer compare;//对比：0-前一日；1-上一周期；
	private String startTime;//起始时间    
	private String endTime;//结束时间
	private String timeType;//0-今天；1-昨天；2-最近七天；3-最近30天
	private String logType;//0-下载量;1-收藏量;2-点击浏览量;3-购买数量;
	private int sort;
	//资源排序：0-上传；1-收藏；2-购买；3-下载；4-点击；5-分享；
	private int newNum1;
	private int newNum2;
	private String oneDay;
	private String group;//0-按资源分组；1-按人分组；
	private String username;
	private String filename;
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getUploadNum() {
		return uploadNum;
	}
	public void setUploadNum(int uploadNum) {
		this.uploadNum = uploadNum;
	}
	public int getDownLoadNum() {
		return downLoadNum;
	}
	public void setDownLoadNum(int downLoadNum) {
		this.downLoadNum = downLoadNum;
	}
	public int getCollectionNum() {
		return collectionNum;
	}
	public void setCollectionNum(int collectionNum) {
		this.collectionNum = collectionNum;
	}
	public int getClickNum() {
		return clickNum;
	}
	public void setClickNum(int clickNum) {
		this.clickNum = clickNum;
	}
	public int getBuyNum() {
		return buyNum;
	}
	public void setBuyNum(int buyNum) {
		this.buyNum = buyNum;
	}
	public int getTimeUnit() {
		return timeUnit;
	}
	public void setTimeUnit(int timeUnit) {
		this.timeUnit = timeUnit;
	}
	public Integer getCompare() {
		return compare;
	}
	public void setCompare(Integer compare) {
		this.compare = compare;
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
	public String getTimeType() {
		return timeType;
	}
	public void setTimeType(String timeType) {
		this.timeType = timeType;
	}
	public String getLogType() {
		return logType;
	}
	public void setLogType(String logType) {
		this.logType = logType;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getNewNum1() {
		return newNum1;
	}
	public void setNewNum1(int newNum1) {
		this.newNum1 = newNum1;
	}
	public int getNewNum2() {
		return newNum2;
	}
	public void setNewNum2(int newNum2) {
		this.newNum2 = newNum2;
	}
	public String getOneDay() {
		return oneDay;
	}
	public void setOneDay(String oneDay) {
		this.oneDay = oneDay;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
}
