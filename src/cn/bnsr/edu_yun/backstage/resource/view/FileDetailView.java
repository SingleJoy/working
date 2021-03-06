package cn.bnsr.edu_yun.backstage.resource.view;
/**
 * 文档详情视图
 * @author fangxiongwei
 * @date 2016年9月22日
 */
public class FileDetailView {
	private String title;//标题
	private String profile;//简介
	private String type;//类型
	private String labels;//标签
	private String columnName;//分类
	private String classifyId;//科目分类id
	private String parentId;//父分类id
	private Double price;//价格
	private String length;//长度
	private String size;//大小
	private String upload_time;//上传时间
	
	private String status;//状态
	private String reason;//原因
	
	private String version;//教材版本
	private String grade;//年级分类
	private String stageName;//学段名称
	private String subjectName;//科目名称
	private String editionName;//版本名称
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getLabels() {
		return labels;
	}
	public void setLabels(String labels) {
		this.labels = labels;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getClassifyId() {
		return classifyId;
	}
	public void setClassifyId(String classifyId) {
		this.classifyId = classifyId;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getStageName() {
		return stageName;
	}
	public void setStageName(String stageName) {
		this.stageName = stageName;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getEditionName() {
		return editionName;
	}
	public void setEditionName(String editionName) {
		this.editionName = editionName;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
}
