package cn.bnsr.edu_yun.frontstage.train.view;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

/**
 * 社区课程视图
 * @author heliwei
 * @date 2017年5月25日
 */
public class CommunityCourseView extends PageBase {
	private Long id;//班级id
	private String name;//班级名称
	private String creator;//创建人
	private int stamp;//课程/培训 0-课程 1-培训
	private int total;//班级总人数
	private int status;//状态：0-开启；1-关闭
	private Long classifyBelongsId;//classifyBelongs id
	private String classifyName;//分类名称
	private int source_type;//0-社区 1-工作坊
	private Long source_id;//社区/工作坊id
	private String paging;//是否分页 0-否 1-是
	private String courseName;//课程名称
	private int sort_type;//0-创建时间 1-学习人数 2-状态
	private int sort_desc;//0-是 1-否
	private int recommended;//推荐
	private Integer courseId;
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
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public int getStamp() {
		return stamp;
	}
	public void setStamp(int stamp) {
		this.stamp = stamp;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Long getClassifyBelongsId() {
		return classifyBelongsId;
	}
	public void setClassifyBelongsId(Long classifyBelongsId) {
		this.classifyBelongsId = classifyBelongsId;
	}
	
	public String getClassifyName() {
		return classifyName;
	}
	
	public void setClassifyName(String classifyName) {
		this.classifyName = classifyName;
	}
	
	public void setSource_id(Long source_id) {
		this.source_id = source_id;
	}
	
	public Long getSource_id() {
		return source_id;
	}
	
	public void setSource_type(int source_type) {
		this.source_type = source_type;
	}
	
	public int getSource_type() {
		return source_type;
	}
	
	public void setPaging(String paging) {
		this.paging = paging;
	}
	
	public String getPaging() {
		return paging;
	}
	
	public String getCourseName() {
		return courseName;
	}
	
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	
	public int getSort_type() {
		return sort_type;
	}

	public void setSort_type(int sort_type) {
		this.sort_type = sort_type;
	}

	public int getSort_desc() {
		return sort_desc;
	}

	public void setSort_desc(int sort_desc) {
		this.sort_desc = sort_desc;
	}
	public int getRecommended() {
		return recommended;
	}
	public void setRecommended(int recommended) {
		this.recommended = recommended;
	}
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
}
