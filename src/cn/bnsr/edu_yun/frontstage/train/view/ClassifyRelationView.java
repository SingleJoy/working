package cn.bnsr.edu_yun.frontstage.train.view;

import java.util.Date;
import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;
import cn.bnsr.edu_yun.frontstage.train.po.ClassifyRelation;

public class ClassifyRelationView extends PageBase {

    private Long id;

    private String name;

    private String code;
    
    private String remarks;
   
    private Long parent_id;

    private Date create_time;

    private Integer type;//类型：0-课程分类；1-培训分类

    private Integer source_type;//来源类型：0-社区；1-工作坊

    private Long source_id;
    
    private List<ClassifyRelation> sonClassifys;

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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Long getParent_id() {
		return parent_id;
	}

	public void setParent_id(Long parent_id) {
		this.parent_id = parent_id;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getSource_type() {
		return source_type;
	}

	public void setSource_type(Integer source_type) {
		this.source_type = source_type;
	}

	public Long getSource_id() {
		return source_id;
	}

	public void setSource_id(Long source_id) {
		this.source_id = source_id;
	}

	public List<ClassifyRelation> getSonClassifys() {
		return sonClassifys;
	}

	public void setSonClassifys(List<ClassifyRelation> sonClassifys) {
		this.sonClassifys = sonClassifys;
	}

	

	
    
    
}
