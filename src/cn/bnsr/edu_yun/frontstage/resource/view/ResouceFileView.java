package cn.bnsr.edu_yun.frontstage.resource.view;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

/**
 * 资源文件视图（我的上传，我的下载)
 * @author fangxiongwei
 * @date 2017年8月14日
 */
public class ResouceFileView extends PageBase{
	private Long id;
	private String filename;//文件名
	private int status;//状态 0－审核通过(正常)  1－未审核 2-审核不通过 3－删除
	private int file_type;//文件类型0-普通文档；1-教案；
	private String profile;//简介
	private String time;//操作时间
	private Long user_id;//登录用户id
	private int type;//1:上传的文件 2:收藏 3:转载 4:购买 5:下载
	private Long upload_user_id;//上传人id
	private String upload_user_name;//上传人名
	private String upload_icon;//上传人头像
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getFile_type() {
		return file_type;
	}
	public void setFile_type(int file_type) {
		this.file_type = file_type;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public Long getUpload_user_id() {
		return upload_user_id;
	}
	public void setUpload_user_id(Long upload_user_id) {
		this.upload_user_id = upload_user_id;
	}
	public String getUpload_icon() {
		return upload_icon;
	}
	public void setUpload_icon(String upload_icon) {
		this.upload_icon = upload_icon;
	}
	public String getUpload_user_name() {
		return upload_user_name;
	}
	public void setUpload_user_name(String upload_user_name) {
		this.upload_user_name = upload_user_name;
	}
	
}
