package cn.bnsr.edu_yun.frontstage.train.view;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

/**
 * 培训视图
 * @author fangxiongwei
 * @date 2017年1月3日
 */
public class TrainView extends PageBase{
	private Long id;
	private String ids;
	private String name;//名称
	private String profile;//简介
	private Long classify_id;//分类id x
	private String classify_name;
	private String img;//图片
	private Double price;//价格
	private Double old_price;//原价
	private Integer status;//状态：0-未发布；1-已发布；2-已关闭；3-删除
	private int is_recommend;//是否推荐：0-是；1-否
	private String recommendTime;//推荐时间
	private int recommendSeq;//推荐序号
	private String sponsor;//主办方
	private int is_sort;//是否按顺序学：0-是；1-否
	private int already_studyed_phase;//进阶培训-已经学完的阶段
	private String createUser;//创建人
	private Long user_id;//创建人id
	private String username;//创建者姓名
	private String create_time;//创建时间
	private int type;//培训类型：0-普通；1-培训项目
	private int is_simple_train;//简单培训 0-否 1-是
	private int is_complex_train;//复杂培训 0-否 1-是
	
	private String titles;//创建人职称
	private String icon;//创建人头像
	private String flag;//跳转方式 0-创建跳转，1-保存后跳转,2-普通跳转
	private String sign;//标识哪个标签
	private String state;//个人中心标签
	private String stamp;//个人中分组
	private int courseCount;//课程总数
	private String openTime;//开班时间
	private String closeTime;//结束时间
	
	private long trainTotalAppraise;//培训评价总数
	private int trainTotalScore;//培训评价总分
	private long classId;//选中班级id
	
	private int elite;//0-全部；1-精华
	private String sort_name;//排序名称 
	
	private String studentNum;//学员数 
	private String appraiseNum;//评价数
	private Integer classNum;
	
	
	private int sortType;//排序
	private int jumpType;//跳转类型 0-普通；1-社区；2-工作坊
	private Long jumpId;//跳转id
	private int is_check;//是否设置考核 0-是；1-否
	
	private int open_class_num;//开班次数
	private Integer viewType;
	private Integer userStudyStatus;
	private int currSignUp;//正在报名 0-不作为检索条件 1-作为检索条件
	private Integer is_default_img;//0：使用默认图片 1：使用自定义图片
	private int score;
	private String classifyName;//分类名称
	private int collectNum;
	private List<String> ClassifyIds;
	private Long sonClassifyId;//所属子分类id
	private String sonClassifyName;//所属子分类名称
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Integer getClassNum() {
		return classNum;
	}
	public void setClassNum(Integer classNum) {
		this.classNum = classNum;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
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
	public Long getClassify_id() {
		return classify_id;
	}
	public void setClassify_id(Long classify_id) {
		this.classify_id = classify_id;
	}
	public String getClassify_name() {
		return classify_name;
	}
	public void setClassify_name(String classify_name) {
		this.classify_name = classify_name;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getOld_price() {
		return old_price;
	}
	public void setOld_price(Double old_price) {
		this.old_price = old_price;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public int getIs_recommend() {
		return is_recommend;
	}
	public void setIs_recommend(int is_recommend) {
		this.is_recommend = is_recommend;
	}
	public String getRecommendTime() {
		return recommendTime;
	}
	public void setRecommendTime(String recommendTime) {
		this.recommendTime = recommendTime;
	}
	public int getRecommendSeq() {
		return recommendSeq;
	}
	public void setRecommendSeq(int recommendSeq) {
		this.recommendSeq = recommendSeq;
	}
	public String getSponsor() {
		return sponsor;
	}
	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}
	public int getIs_sort() {
		return is_sort;
	}
	public void setIs_sort(int is_sort) {
		this.is_sort = is_sort;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	public String getTitles() {
		return titles;
	}
	public void setTitles(String titles) {
		this.titles = titles;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
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
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getStamp() {
		return stamp;
	}
	public void setStamp(String stamp) {
		this.stamp = stamp;
	}
	public int getCourseCount() {
		return courseCount;
	}
	public void setCourseCount(int courseCount) {
		this.courseCount = courseCount;
	}
	public String getOpenTime() {
		return openTime;
	}
	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}
	public long getTrainTotalAppraise() {
		return trainTotalAppraise;
	}
	public void setTrainTotalAppraise(long trainTotalAppraise) {
		this.trainTotalAppraise = trainTotalAppraise;
	}
	public int getTrainTotalScore() {
		return trainTotalScore;
	}
	public void setTrainTotalScore(int trainTotalScore) {
		this.trainTotalScore = trainTotalScore;
	}
	public long getClassId() {
		return classId;
	}
	public void setClassId(long classId) {
		this.classId = classId;
	}
	public int getElite() {
		return elite;
	}
	public void setElite(int elite) {
		this.elite = elite;
	}
	public String getSort_name() {
		return sort_name;
	}
	public void setSort_name(String sort_name) {
		this.sort_name = sort_name;
	}
	public String getCloseTime() {
		return closeTime;
	}
	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getStudentNum() {
		return studentNum;
	}
	public void setStudentNum(String studentNum) {
		this.studentNum = studentNum;
	}
	public String getAppraiseNum() {
		return appraiseNum;
	}
	public void setAppraiseNum(String appraiseNum) {
		this.appraiseNum = appraiseNum;
	}
	public int getSortType() {
		return sortType;
	}
	public void setSortType(int sortType) {
		this.sortType = sortType;
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
	public int getIs_check() {
		return is_check;
	}
	public void setIs_check(int is_check) {
		this.is_check = is_check;
	}
	public int getOpen_class_num() {
		return open_class_num;
	}
	public void setOpen_class_num(int open_class_num) {
		this.open_class_num = open_class_num;
	}
	public Integer getViewType() {
		return viewType;
	}
	public void setViewType(Integer viewType) {
		this.viewType = viewType;
	}
	public Integer getUserStudyStatus() {
		return userStudyStatus;
	}
	public void setUserStudyStatus(Integer userStudyStatus) {
		this.userStudyStatus = userStudyStatus;
	}
	public int getCurrSignUp() {
		return currSignUp;
	}
	public void setCurrSignUp(int currSignUp) {
		this.currSignUp = currSignUp;
	}
	public int getIs_simple_train() {
		return is_simple_train;
	}
	public void setIs_simple_train(int is_simple_train) {
		this.is_simple_train = is_simple_train;
	}
	public int getIs_complex_train() {
		return is_complex_train;
	}
	public void setIs_complex_train(int is_complex_train) {
		this.is_complex_train = is_complex_train;
	}
	public Integer getIs_default_img() {
		return is_default_img;
	}
	public void setIs_default_img(Integer is_default_img) {
		this.is_default_img = is_default_img;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getClassifyName() {
		return classifyName;
	}
	public void setClassifyName(String classifyName) {
		this.classifyName = classifyName;
	}
	public int getCollectNum() {
		return collectNum;
	}
	public void setCollectNum(int collectNum) {
		this.collectNum = collectNum;
	}
	public int getAlready_studyed_phase() {
		return already_studyed_phase;
	}
	public void setAlready_studyed_phase(int already_studyed_phase) {
		this.already_studyed_phase = already_studyed_phase;
	}
	public List<String> getClassifyIds() {
		return ClassifyIds;
	}
	public void setClassifyIds(List<String> classifyIds) {
		ClassifyIds = classifyIds;
	}
	public Long getSonClassifyId() {
		return sonClassifyId;
	}
	public void setSonClassifyId(Long sonClassifyId) {
		this.sonClassifyId = sonClassifyId;
	}
	public String getSonClassifyName() {
		return sonClassifyName;
	}
	public void setSonClassifyName(String sonClassifyName) {
		this.sonClassifyName = sonClassifyName;
	}
	
}
