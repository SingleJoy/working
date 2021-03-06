package cn.bnsr.edu_yun.frontstage.base.view;

public class CertificateView {

	private String name; //真实姓名
	private long school;//学校
	private String stage;//学段
	private String subject;//科目
	private String edition;//版本
	private int grade;//年级
	private int sex;//性别
	private String ID_number;//身份证号码
	private String email;//邮箱
	private String phone;//手机号
	private String yzm;//验证码
	private String picture1;//图片
	private String picture2;
	private String picture3;
	private Integer certificated;
	
	private String s_phone;
	private String s_username;
	private String s_area;
	private String s_school;
	private String area_id;
	private Long school_id;
	
	private String schoolName;
	private String position;
	private String titles;
	private int type;
	private String province;
	private String city;
	private String county;
	private int certificate_type;
	
	private int page;// 当前页
	private int rows;// 每页显示记录数
	private String sort;// 排序字段名
	private String order;// 按什么排序(asc,desc)
	private int start;
	public String getS_area() {
		return s_area;
	}public String getS_phone() {
		return s_phone;
	}
	public void setS_phone(String s_phone) {
		this.s_phone = s_phone;
	}
	public String getS_username() {
		return s_username;
	}
	public void setS_username(String s_username) {
		this.s_username = s_username;
	}
	
	public void setS_area(String s_area) {
		this.s_area = s_area;
	}
	public String getS_school() {
		return s_school;
	}
	public void setS_school(String s_school) {
		this.s_school = s_school;
	}
	public String getArea_id() {
		return area_id;
	}
	public void setArea_id(String area_id) {
		this.area_id = area_id;
	}
	public Long getSchool_id() {
		return school_id;
	}
	public void setSchool_id(Long school_id) {
		this.school_id = school_id;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getTitles() {
		return titles;
	}
	public void setTitles(String titles) {
		this.titles = titles;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public long getSchool() {
		return school;
	}
	public void setSchool(long school) {
		this.school = school;
	}
	public String getStage() {
		return stage;
	}
	public void setStage(String stage) {
		this.stage = stage;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getEdition() {
		return edition;
	}
	public void setEdition(String edition) {
		this.edition = edition;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public String getID_number() {
		return ID_number;
	}
	public void setID_number(String iD_number) {
		ID_number = iD_number;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getYzm() {
		return yzm;
	}
	public void setYzm(String yzm) {
		this.yzm = yzm;
	}
	public String getPicture1() {
		return picture1;
	}
	public void setPicture1(String picture1) {
		this.picture1 = picture1;
	}
	public String getPicture2() {
		return picture2;
	}
	public void setPicture2(String picture2) {
		this.picture2 = picture2;
	}
	public String getPicture3() {
		return picture3;
	}
	public void setPicture3(String picture3) {
		this.picture3 = picture3;
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
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getCertificate_type() {
		return certificate_type;
	}
	public void setCertificate_type(int certificate_type) {
		this.certificate_type = certificate_type;
	}
	public Integer getCertificated() {
		return certificated;
	}
	public void setCertificated(Integer certificated) {
		this.certificated = certificated;
	}
	
	
}
