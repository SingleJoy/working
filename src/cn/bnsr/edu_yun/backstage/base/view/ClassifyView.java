package cn.bnsr.edu_yun.backstage.base.view;

import java.util.Date;

/**
 * 分类设置视图
 * @author fangxiongwei
 * @date 2016年10月18日
 */
public class ClassifyView extends PageBase{
	private Integer id;
	private String parent_id;
	private String parent_classify_name;
	private Integer gradepa_id;
	private String classify_name;
	private String type;//类型名称
	private String code;//编码
	private Integer seq;//序号
	private String remarks;//描述
	private Date create_time;
	private String ids;
	private String state = "open";// 是否展开(open,closed)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getClassify_name() {
		return classify_name;
	}
	public void setClassify_name(String classify_name) {
		this.classify_name = classify_name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getParent_classify_name() {
		return parent_classify_name;
	}
	public void setParent_classify_name(String parent_classify_name) {
		this.parent_classify_name = parent_classify_name;
	}
	public Integer getGradepa_id() {
		return gradepa_id;
	}
	public void setGradepa_id(Integer gradepa_id) {
		this.gradepa_id = gradepa_id;
	}
	
	
}