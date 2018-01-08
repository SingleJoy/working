package cn.bnsr.edu_yun.backstage.base.view;
/**
 * 用户统计
 * @author fangxiongwei
 * @date 2016年10月14日
 */
public class UserStatsView {
	private String days;//日期
	private String year;//年
	private String month;//月
	private int frontNum;//前台用户注册数量
	private String logType;//0-注册；1-登录；（用户统计）
	//0-留存数；1-留存率；2-留失数；3-留失率；（新用户留存分析）
	//0-用户访问时长；1-用户上次访问时长；3-用户登录频次；（忠诚度）
	private String timeType;//0-本月；1-上月；2-近三月；3-起止时间；4-本周   （用户登录注册）
	//0-次日；1-三日；2-七日；3-起止时间；（用户留存率）
	//0-今天；1-昨天；2-最近七天；3-最近30天（用户统计）
	//0-次日；1-三日；2-七日；3-30日；（新用户留存分析）
	private int isDuration;//是否是时间段：0-是；1-否；
	private int timeUnit;//时间单位：0-按时；1-按日；2-按周；3-按月；（用户统计）
	//类别：0-区间；1-点日；（新用户留存分析）
	private Integer inactive;//不可点击：0-按周；1-按月；
	private Integer device;//设备：-1-全部；0-PC端；1-移动端
	private String province_id;//省、直辖市、自治区 id 0--全国
	private Integer compare;//对比：0-前一日；1-上一周期；
	private String startTime;//起始时间    
	private String endTime;//结束时间
	private String returnTime;//月回归上限时间
	private String oneDay;//true,it's that song
	private int countNum;//总数
	
	private int newNum;//新增数、留存数
	private int loginNum;//访客数 
	private String meanVisitTime = "00:00:00";//平均访问时长
	private String newMeanVisitTime = "00:00:00";//新用户平均访问时长
	
	private int activeNum;//活跃数
	//高活跃用户数
	private int returnNum;//回归数
	//回归僵尸用户数
	private int remain_type;//留存方式  0-求和，1-查询某一天
	private int remainRatio;//留存率
	private int lossNum;//流失数
	private int lossRatio;//留存率
	
	private int tryNum;//尝试用户数
	private int hour;//活跃规定小时
	private int status;//用户：0-全部；1-新用户；2-老用户
	
	private int newNum1;//必须是int
	private int newNum2;//必须是int
	private String interval1 = "00:00:00";//时段1
	private String interval2 = "00:00:00";//时段2
	private int sort;//0--按小时排序，1--按日排序，2--
	private int sex;//0-全部；1-男；2-女
	
	private int avgNum;//平均值
	private int maxNum;//峰值
	
	private String ageInterval;//年龄范围
	
	private int ipNum;//IP数
	private String province;//省、直辖市、自治区
	
	
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
	public int getFrontNum() {
		return frontNum;
	}
	public void setFrontNum(int frontNum) {
		this.frontNum = frontNum;
	}
	public String getLogType() {
		return logType;
	}
	public void setLogType(String logType) {
		this.logType = logType;
	}
	public String getTimeType() {
		return timeType;
	}
	public void setTimeType(String timeType) {
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
	public String getOneDay() {
		return oneDay;
	}
	public void setOneDay(String oneDay) {
		this.oneDay = oneDay;
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
	public int getLoginNum() {
		return loginNum;
	}
	public void setLoginNum(int loginNum) {
		this.loginNum = loginNum;
	}
	public String getMeanVisitTime() {
		return meanVisitTime;
	}
	public void setMeanVisitTime(String meanVisitTime) {
		this.meanVisitTime = meanVisitTime;
	}
	public String getNewMeanVisitTime() {
		return newMeanVisitTime;
	}
	public void setNewMeanVisitTime(String newMeanVisitTime) {
		this.newMeanVisitTime = newMeanVisitTime;
	}
	public int getRemain_type() {
		return remain_type;
	}
	public void setRemain_type(int remain_type) {
		this.remain_type = remain_type;
	}
	public int getRemainRatio() {
		return remainRatio;
	}
	public void setRemainRatio(int remainRatio) {
		this.remainRatio = remainRatio;
	}
	public String getReturnTime() {
		return returnTime;
	}
	public void setReturnTime(String returnTime) {
		this.returnTime = returnTime;
	}
	public int getActiveNum() {
		return activeNum;
	}
	public void setActiveNum(int activeNum) {
		this.activeNum = activeNum;
	}
	public int getReturnNum() {
		return returnNum;
	}
	public void setReturnNum(int returnNum) {
		this.returnNum = returnNum;
	}
	public int getIsDuration() {
		return isDuration;
	}
	public void setIsDuration(int isDuration) {
		this.isDuration = isDuration;
	}
	public int getTimeUnit() {
		return timeUnit;
	}
	public void setTimeUnit(int timeUnit) {
		this.timeUnit = timeUnit;
	}
	public Integer getInactive() {
		return inactive;
	}
	public void setInactive(Integer inactive) {
		this.inactive = inactive;
	}
	public Integer getDevice() {
		return device;
	}
	public void setDevice(Integer device) {
		this.device = device;
	}
	public String getProvince_id() {
		return province_id;
	}
	public void setProvince_id(String province_id) {
		this.province_id = province_id;
	}
	public Integer getCompare() {
		return compare;
	}
	public void setCompare(Integer compare) {
		this.compare = compare;
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
	public String getInterval1() {
		return interval1;
	}
	public void setInterval1(String interval1) {
		this.interval1 = interval1;
	}
	public String getInterval2() {
		return interval2;
	}
	public void setInterval2(String interval2) {
		this.interval2 = interval2;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getLossNum() {
		return lossNum;
	}
	public void setLossNum(int lossNum) {
		this.lossNum = lossNum;
	}
	public int getLossRatio() {
		return lossRatio;
	}
	public void setLossRatio(int lossRatio) {
		this.lossRatio = lossRatio;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public int getTryNum() {
		return tryNum;
	}
	public void setTryNum(int tryNum) {
		this.tryNum = tryNum;
	}
	public int getHour() {
		return hour;
	}
	public void setHour(int hour) {
		this.hour = hour;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getAvgNum() {
		return avgNum;
	}
	public void setAvgNum(int avgNum) {
		this.avgNum = avgNum;
	}
	public int getMaxNum() {
		return maxNum;
	}
	public void setMaxNum(int maxNum) {
		this.maxNum = maxNum;
	}
	public String getAgeInterval() {
		return ageInterval;
	}
	public void setAgeInterval(String ageInterval) {
		this.ageInterval = ageInterval;
	}
	public int getIpNum() {
		return ipNum;
	}
	public void setIpNum(int ipNum) {
		this.ipNum = ipNum;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	
}
