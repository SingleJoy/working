package cn.bnsr.edu_yun.frontstage.train.view;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

/**
 * 社区视图
 * 
 * @author fangxiongwei
 * @date 2017年5月16日
 */
public class CommunityView extends PageBase {
	private Long id;
	private String name;
	private String head_img;
	private String head_img_name;
	private String back_img;
	private Long user_id;
	private String community_user;// 创建者
	private int stamp;// 标识 0-课程；1-培训；2-课例；3-工作坊；4-话题；5-信息管理；
						// 6-用户管理；7-计划管理；8-课程分类管理；9-培训分类管理；10-数据统计；11-社区主页
	private Integer type;// 类型：0-普通；1-教师培训社区
	private int the_type;// 所属类型 ：0-综合素质；1-其他
	private Integer grade;// 等级:0-省级；1-市级；2-县级
	private int hour;// 学时
	private int credit;// 学分
	private int plan_num;// 计划人数
	private int is_examine;// 是否需要审：0-是；1-否
	private int status;// 状态：0-正常；1-关闭
	private String start_time;//
	private String end_time;//
	private String create_time;//
	private String profile;// 简介

	private String subjects;// 学科
	private String periods;// 学段
	private int source_type; // 0-社区 1-工作坊
	private int studentNum;// 学员数
	private int topicNum;// 话题数

	private int sign;// 标识 ：0-社区主页；1-加入的社区；2-创建的社区；3-发起的话题
	private String area_id;// 所属地区id
	private String province;// 省
	private String city;// 市
	private String county;// 县

	private Long currentCommunity;// 社区主页 当前选中的社区id
	private int finish_total_lesson; // 完成的课时数量
	private int unfinish_total_lesson;// 未完成的课时数量
	private int finish_total_course;// 完成的课程数量
	private int unfinish_total_course;// 未完成的课程数量
	private int finish_total_train;// 完成的培训数量
	private int unfinish_total_train;// 未完成的培训数量
	private int finish_total_exam;// 完成的作业数量
	private int unfinish_total_exam;// 未完成的作业数量
	private int finish_total_test;// 完成的考试数量
	private int unfinish_total_test;// 未完成的考试数量
	private int finish_total_discuss;// 完成研讨数量
	private int unfinish_total_discuss;// 未完成的研讨数量
	private String paging;// 分页 0-否 1-是
	private int open_index;// 完全展开(更多) 1-课例 2-课程 3-培训 4-作业 5-调研 6-试卷

	// 后台
	private String timeStart;
	private String timeEnd;
	private Integer serach_time;//0-创建时间;1-开始时间;2-截止时间
	private Integer recommended;
	private String admins;//管理员姓名
	private String ids;//管理员id

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getHead_img() {
		return head_img;
	}

	public void setHead_img(String head_img) {
		this.head_img = head_img;
	}

	public String getHead_img_name() {
		return head_img_name;
	}

	public void setHead_img_name(String head_img_name) {
		this.head_img_name = head_img_name;
	}

	public String getBack_img() {
		return back_img;
	}

	public void setBack_img(String back_img) {
		this.back_img = back_img;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public String getCommunity_user() {
		return community_user;
	}

	public void setCommunity_user(String community_user) {
		this.community_user = community_user;
	}

	public int getStamp() {
		return stamp;
	}

	public void setStamp(int stamp) {
		this.stamp = stamp;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public int getThe_type() {
		return the_type;
	}

	public void setThe_type(int the_type) {
		this.the_type = the_type;
	}

	public Integer getGrade() {
		return grade;
	}

	public void setGrade(Integer grade) {
		this.grade = grade;
	}

	public int getHour() {
		return hour;
	}

	public void setHour(int hour) {
		this.hour = hour;
	}

	public int getCredit() {
		return credit;
	}

	public void setCredit(int credit) {
		this.credit = credit;
	}

	public int getPlan_num() {
		return plan_num;
	}

	public void setPlan_num(int plan_num) {
		this.plan_num = plan_num;
	}

	public int getIs_examine() {
		return is_examine;
	}

	public void setIs_examine(int is_examine) {
		this.is_examine = is_examine;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getSubjects() {
		return subjects;
	}

	public void setSubjects(String subjects) {
		this.subjects = subjects;
	}

	public String getPeriods() {
		return periods;
	}

	public void setPeriods(String periods) {
		this.periods = periods;
	}

	public int getStudentNum() {
		return studentNum;
	}

	public void setStudentNum(int studentNum) {
		this.studentNum = studentNum;
	}

	public int getTopicNum() {
		return topicNum;
	}

	public void setTopicNum(int topicNum) {
		this.topicNum = topicNum;
	}

	public int getSign() {
		return sign;
	}

	public void setSign(int sign) {
		this.sign = sign;
	}

	public int getSource_type() {
		return source_type;
	}

	public void setSource_type(int source_type) {
		this.source_type = source_type;
	}

	public void setCurrentCommunity(Long currentCommunity) {
		this.currentCommunity = currentCommunity;
	}

	public Long getCurrentCommunity() {
		return currentCommunity;
	}

	public int getFinish_total_lesson() {
		return finish_total_lesson;
	}

	public void setFinish_total_lesson(int finish_total_lesson) {
		this.finish_total_lesson = finish_total_lesson;
	}

	public int getUnfinish_total_lesson() {
		return unfinish_total_lesson;
	}

	public void setUnfinish_total_lesson(int unfinish_total_lesson) {
		this.unfinish_total_lesson = unfinish_total_lesson;
	}

	public int getFinish_total_course() {
		return finish_total_course;
	}

	public void setFinish_total_course(int finish_total_course) {
		this.finish_total_course = finish_total_course;
	}

	public int getUnfinish_total_course() {
		return unfinish_total_course;
	}

	public void setUnfinish_total_course(int unfinish_total_course) {
		this.unfinish_total_course = unfinish_total_course;
	}

	public int getFinish_total_train() {
		return finish_total_train;
	}

	public void setFinish_total_train(int finish_total_train) {
		this.finish_total_train = finish_total_train;
	}

	public int getUnfinish_total_train() {
		return unfinish_total_train;
	}

	public void setUnfinish_total_train(int unfinish_total_train) {
		this.unfinish_total_train = unfinish_total_train;
	}

	public int getFinish_total_exam() {
		return finish_total_exam;
	}

	public void setFinish_total_exam(int finish_total_exam) {
		this.finish_total_exam = finish_total_exam;
	}

	public int getUnfinish_total_exam() {
		return unfinish_total_exam;
	}

	public void setUnfinish_total_exam(int unfinish_total_exam) {
		this.unfinish_total_exam = unfinish_total_exam;
	}

	public int getFinish_total_test() {
		return finish_total_test;
	}

	public void setFinish_total_test(int finish_total_test) {
		this.finish_total_test = finish_total_test;
	}

	public int getUnfinish_total_test() {
		return unfinish_total_test;
	}

	public void setUnfinish_total_test(int unfinish_total_test) {
		this.unfinish_total_test = unfinish_total_test;
	}

	public int getOpen_index() {
		return open_index;
	}

	public void setOpen_index(int open_index) {
		this.open_index = open_index;
	}

	public String getPaging() {
		return paging;
	}

	public void setPaging(String paging) {
		this.paging = paging;
	}

	public String getArea_id() {
		return area_id;
	}

	public void setArea_id(String area_id) {
		this.area_id = area_id;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public void setUnfinish_total_discuss(int unfinish_total_discuss) {
		this.unfinish_total_discuss = unfinish_total_discuss;
	}

	public int getUnfinish_total_discuss() {
		return unfinish_total_discuss;
	}

	public void setFinish_total_discuss(int finish_total_discuss) {
		this.finish_total_discuss = finish_total_discuss;
	}

	public int getFinish_total_discuss() {
		return finish_total_discuss;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public String getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(String timeStart) {
		this.timeStart = timeStart;
	}

	public String getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(String timeEnd) {
		this.timeEnd = timeEnd;
	}

	public Integer getSerach_time() {
		return serach_time;
	}

	public void setSerach_time(Integer serach_time) {
		this.serach_time = serach_time;
	}

	public Integer getRecommended() {
		return recommended;
	}

	public void setRecommended(Integer recommended) {
		this.recommended = recommended;
	}

	public String getAdmins() {
		return admins;
	}

	public void setAdmins(String admins) {
		this.admins = admins;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	
}
