package cn.bnsr.edu_yun.frontstage.train.view;

import java.util.Date;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

public class WorkshopView extends PageBase {

	private Long id;

	private String name;

	private String profile;

	private String img;
	
	private String img_name;

	private String period;

	private String subject;

	private Integer is_top;

	private Long community_id;

	private Integer status;

	private Long user_id;

	private Date create_time;
	
	private Long workshop_user_id;//坊主id
	
	private String workshop_user;//坊主
	
	private String periodName;//学段名
	
	private String subjectName;//学科名
	
	private Integer user_count;//人数
	
	private String search;//查询关键字
	
	private String ids;
	
	private int stamp;
	
	private int  source_type; //0-社区 1-工作坊
	
	private int studentNum;
	
	private int topicNum;
	
	private int sign;
	
	private String workshop_user_ids;//坊主id 集合

	private int recommended;
	
	private String community_name;
	
	private String expert;//专家
	
	private Integer is_default_img;
	
	//后台
	private String timeStart;
	private String timeEnd;
	
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

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getImg_name() {
		return img_name;
	}

	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public Integer getIs_top() {
		return is_top;
	}

	public void setIs_top(Integer is_top) {
		this.is_top = is_top;
	}

	public Long getCommunity_id() {
		return community_id;
	}

	public void setCommunity_id(Long community_id) {
		this.community_id = community_id;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Long getWorkshop_user_id() {
		return workshop_user_id;
	}

	public void setWorkshop_user_id(Long workshop_user_id) {
		this.workshop_user_id = workshop_user_id;
	}

	public String getWorkshop_user() {
		return workshop_user;
	}

	public void setWorkshop_user(String workshop_user) {
		this.workshop_user = workshop_user;
	}

	public String getPeriodName() {
		return periodName;
	}

	public void setPeriodName(String periodName) {
		this.periodName = periodName;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	public Integer getUser_count() {
		return user_count;
	}

	public void setUser_count(Integer user_count) {
		this.user_count = user_count;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public int getStamp() {
		return stamp;
	}

	public void setStamp(int stamp) {
		this.stamp = stamp;
	}
	
	public int getSource_type() {
		return source_type;
	}
	
	public void setSource_type(int source_type) {
		this.source_type = source_type;
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

	public String getWorkshop_user_ids() {
		return workshop_user_ids;
	}

	public void setWorkshop_user_ids(String workshop_user_ids) {
		this.workshop_user_ids = workshop_user_ids;
	}

	public int getRecommended() {
		return recommended;
	}

	public void setRecommended(int recommended) {
		this.recommended = recommended;
	}

	public String getCommunity_name() {
		return community_name;
	}

	public void setCommunity_name(String community_name) {
		this.community_name = community_name;
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

	public String getExpert() {
		return expert;
	}

	public void setExpert(String expert) {
		this.expert = expert;
	}

	public Integer getIs_default_img() {
		return is_default_img;
	}

	public void setIs_default_img(Integer is_default_img) {
		this.is_default_img = is_default_img;
	}
	
}
