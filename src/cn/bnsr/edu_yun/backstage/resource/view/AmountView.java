package cn.bnsr.edu_yun.backstage.resource.view;

import java.util.Date;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

/**
 * 金额设置视图
 * @author fangxiongwei
 * @date 2016年10月18日
 */
public class AmountView extends PageBase{
	private Long id;
	private Double amount;
	private Byte status;
	private Date create_time;
	private String ids;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public Byte getStatus() {
		return status;
	}
	public void setStatus(Byte status) {
		this.status = status;
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
	
}
