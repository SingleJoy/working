package cn.bnsr.edu_yun.backstage.base.view;

import java.math.BigDecimal;

/**
 * 树视图
 * @author fangxiongwei
 * @date 2016年8月28日
 */
public class TreeView {
	private String id;
	private String iconcls;
	private String name;
	private String pid;//父id
	private String pname;//父名称
	private String remarks;//权限描述
	private BigDecimal seq;//排序
	private String url;//
	private String state = "open";// 是否展开(open,closed)

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIconcls() {
		return iconcls;
	}
	public void setIconcls(String iconcls) {
		this.iconcls = iconcls;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public BigDecimal getSeq() {
		return seq;
	}
	public void setSeq(BigDecimal seq) {
		this.seq = seq;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
}
