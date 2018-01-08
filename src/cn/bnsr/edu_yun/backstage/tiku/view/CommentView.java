package cn.bnsr.edu_yun.backstage.tiku.view;

import java.util.Date;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

public class CommentView extends PageBase {

	private Long id;
	
	private String content;
	
	private Integer seq;
	
	private Date create_time;
	
	private String ids;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
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
