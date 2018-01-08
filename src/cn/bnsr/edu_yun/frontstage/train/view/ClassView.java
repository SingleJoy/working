package cn.bnsr.edu_yun.frontstage.train.view;

import java.util.Date;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

public class ClassView extends PageBase {

	private Long id;
	private String name;// 班级名称
	private Integer status;// 状态：0-未发布；1-已发布；2-进行中；3-已完成；4-已结业
	private String classes;// 班次
	private Date end_time;// 报名截止时间/密码有效期
	private Integer maximum;// 学员上限-密码数量
	private Integer continue_study;// 结业延续学习时间：单位月
	private Integer type;// 班级类型：0-课程；1-培训(在查询考试和作业时分别对应0，1)
	private Date complete_time;// 结业时间
	private Integer discount;// 打折比例
	private Integer is_refund;// 是否退款：0-课程开始前全额退；1-课程开始后按课时比例扣除；2-不允许退款
	private Integer sign_up;// 报名方法:0-自主报名；1-密码学习
	private Double price;// 价格
	private Integer credit;// credit
	private Date close_time;// 结束时间
	private Date open_time;// 开班时间
	private Integer state;
	private Long classify_id;// 开班范围id (分类id)
	private Date create_time;// 开班时间
	private Integer seatwork;//作业批改服务（练）：0-不提供；1-提供
	private Integer testpaper;//试卷批阅服务（试）：0-不提供；1-提供
	private Integer question;//提问回答服务（问）：0-不提供；1-提供
	private Integer activity;//组织活动服务（动）：0-不提供；1-提供
	private Integer doubt;//解决疑惑服务（疑）：0-不提供；1-提供
	private Integer job;//就业指导服务（业）：0-不提供；1-提供

	private String classify_name;//用于查询班级的分类
	private Integer stunum;// 学员人数
	private Long source_id;// 班级关联来源id
	private Integer source_type;// 班级关联来源类型：0-课程；1-培训
	private Long userId;// 开班者id(班主任？)
	private String teacherName;//班主任名称
	private String user_id;// 助教id
	private Long courseId;
	private String flag;//跳转方式 0-创建跳转，1-保存后跳转,2普通跳转
	private String sign;//标识哪个标签
    private String stu_name;//学生姓名
    private String img;//图片
    private String paging;//是否分页 0-否 ，1-是
    private String sourceName;//课程名称、培训名称
    
    private int attribute_type;
    private String phaseId;//阶段课程id
    private int trainType;//培训类型 0-普通培训；1-培训阶段
    private Long class_id;//针对培训，同一页面会出现两个班级id，一个是培训班级id，另一个是其课程下的班级id
    
    private Long classBelongsId;//社区分类id
    private Integer communityType; //社区分类类别 0-社区; 1-工作坊
    private Long communityId;//社区id
    private Long classifyId;//分类id
    private Long firstClassifyId; //社区分类一级分类id
    private String firstClassifyContent; //社区分类一级分类名称
    private Long secondClassifyId; //社区分类二级分类id
    private String secondClassifyContent; //社区分类二级分类名称
    
    private int jumpType;//跳转类型 0-普通；1-社区；2-工作坊
	private Long jumpId;//跳转id
	
	private long current_user;//当前用户
	private long current_community_id;//社区主页当前选中的社区id
	private int current_community_type;//社区主页当前选中的社区type 0-社区 1-工作坊
	private int is_studyed;//是否已学完 0-否 1-是
	
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getClasses() {
		return classes;
	}

	public void setClasses(String classes) {
		this.classes = classes;
	}

	public Integer getContinue_study() {
		return continue_study;
	}

	public void setContinue_study(Integer continue_study) {
		this.continue_study = continue_study;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Date getComplete_time() {
		return complete_time;
	}

	public void setComplete_time(Date complete_time) {
		this.complete_time = complete_time;
	}

	public Integer getDiscount() {
		return discount;
	}

	public void setDiscount(Integer discount) {
		this.discount = discount;
	}

	public Integer getIs_refund() {
		return is_refund;
	}

	public void setIs_refund(Integer is_refund) {
		this.is_refund = is_refund;
	}

	public Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}

	public Integer getMaximum() {
		return maximum;
	}

	public void setMaximum(Integer maximum) {
		this.maximum = maximum;
	}

	public Integer getSign_up() {
		return sign_up;
	}

	public void setSign_up(Integer sign_up) {
		this.sign_up = sign_up;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Integer getCredit() {
		return credit;
	}

	public void setCredit(Integer credit) {
		this.credit = credit;
	}

	public Date getClose_time() {
		return close_time;
	}

	public void setClose_time(Date close_time) {
		this.close_time = close_time;
	}

	public Date getOpen_time() {
		return open_time;
	}

	public void setOpen_time(Date open_time) {
		this.open_time = open_time;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Long getClassify_id() {
		return classify_id;
	}

	public void setClassify_id(Long classify_id) {
		this.classify_id = classify_id;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getSeatwork() {
		return seatwork;
	}

	public void setSeatwork(Integer seatwork) {
		this.seatwork = seatwork;
	}

	public Integer getTestpaper() {
		return testpaper;
	}

	public void setTestpaper(Integer testpaper) {
		this.testpaper = testpaper;
	}

	public Integer getQuestion() {
		return question;
	}

	public void setQuestion(Integer question) {
		this.question = question;
	}

	public Integer getActivity() {
		return activity;
	}

	public void setActivity(Integer activity) {
		this.activity = activity;
	}

	public Integer getDoubt() {
		return doubt;
	}

	public void setDoubt(Integer doubt) {
		this.doubt = doubt;
	}

	public Integer getJob() {
		return job;
	}

	public void setJob(Integer job) {
		this.job = job;
	}

	public String getClassify_name() {
		return classify_name;
	}

	public void setClassify_name(String classify_name) {
		this.classify_name = classify_name;
	}

	public Integer getStunum() {
		return stunum;
	}

	public void setStunum(Integer stunum) {
		this.stunum = stunum;
	}

	public Long getSource_id() {
		return source_id;
	}

	public void setSource_id(Long source_id) {
		this.source_id = source_id;
	}

	public Integer getSource_type() {
		return source_type;
	}

	public void setSource_type(Integer source_type) {
		this.source_type = source_type;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Long getCourseId() {
		return courseId;
	}

	public void setCourseId(Long courseId) {
		this.courseId = courseId;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public String getStu_name() {
		return stu_name;
	}

	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getPaging() {
		return paging;
	}

	public void setPaging(String paging) {
		this.paging = paging;
	}

	public String getSourceName() {
		return sourceName;
	}

	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}

	public int getAttribute_type() {
		return attribute_type;
	}

	public void setAttribute_type(int attribute_type) {
		this.attribute_type = attribute_type;
	}

	public String getPhaseId() {
		return phaseId;
	}

	public void setPhaseId(String phaseId) {
		this.phaseId = phaseId;
	}

	public int getTrainType() {
		return trainType;
	}

	public void setTrainType(int trainType) {
		this.trainType = trainType;
	}

	public Long getClass_id() {
		return class_id;
	}

	public void setClass_id(Long class_id) {
		this.class_id = class_id;
	}

	public Integer getCommunityType() {
		return communityType;
	}
	
	public void setCommunityType(Integer communityType) {
		this.communityType = communityType;
	}
	
	public String getFirstClassifyContent() {
		return firstClassifyContent;
	}
	
	public void setFirstClassifyContent(String firstClassifyContent) {
		this.firstClassifyContent = firstClassifyContent;
	}

	public Long getFirstClassifyId() {
		return firstClassifyId;
	}

	public void setFirstClassifyId(Long firstClassifyId) {
		this.firstClassifyId = firstClassifyId;
	}

	public Long getSecondClassifyId() {
		return secondClassifyId;
	}

	public void setSecondClassifyId(Long secondClassifyId) {
		this.secondClassifyId = secondClassifyId;
	}

	public String getSecondClassifyContent() {
		return secondClassifyContent;
	}

	public void setSecondClassifyContent(String secondClassifyContent) {
		this.secondClassifyContent = secondClassifyContent;
	}
	
	public Long getClassBelongsId() {
		return classBelongsId;
	}
	
	public void setClassBelongsId(Long classBelongsId) {
		this.classBelongsId = classBelongsId;
	}
	
	public Long getCommunityId() {
		return communityId;
	}
	
	public void setCommunityId(Long communityId) {
		this.communityId = communityId;
	}

	public Long getClassifyId() {
		return classifyId;
	}
	
	public void setClassifyId(Long classifyId) {
		this.classifyId = classifyId;
	}

	public int getJumpType() {
		return jumpType;
	}

	public void setJumpType(int jumpType) {
		this.jumpType = jumpType;
	}

	public Long getJumpId() {
		return jumpId;
	}

	public void setJumpId(Long jumpId) {
		this.jumpId = jumpId;
	}
	
	public void setCurrent_user(long current_user) {
		this.current_user = current_user;
	}
	
	public long getCurrent_user() {
		return current_user;
	}
	
	public void setCurrent_community_id(long current_community_id) {
		this.current_community_id = current_community_id;
	}
	
	public long getCurrent_community_id() {
		return current_community_id;
	}
	
	public void setCurrent_community_type(int current_community_type) {
		this.current_community_type = current_community_type;
	}
	
	public int getCurrent_community_type() {
		return current_community_type;
	}
	
	public void setIs_studyed(int is_studyed) {
		this.is_studyed = is_studyed;
	}
	
	public int getIs_studyed() {
		return is_studyed;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	
	
}
