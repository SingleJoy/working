package cn.bnsr.edu_yun.frontstage.base.view;

import java.util.Date;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

/**
 * 我的贡献view
 * @author apple
 *
 */
public class MyContributionView extends PageBase{
	private long userId;//上传人id
	private String fileName;//文件名
	private java.util.Date uploadTime;//上传时间
	private String time;//返回上传时间
	private int fileType;//文件状态
	private String size;//文件大小
	private String type;//类型
	private int id;//文件id
	private int status;//
	private java.util.Date checkTime;//审核时间
	private String check;//返回审核时间
	private String reason;//审核不通过原因
	private java.util.Date deleteTime;//删除时间
	private String delete;//返回删除时间
	
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	
	public Date getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	public int getFileType() {
		return fileType;
	}
	public void setFileType(int fileType) {
		this.fileType = fileType;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public java.util.Date getCheckTime() {
		return checkTime;
	}
	public void setCheckTime(java.util.Date checkTime) {
		this.checkTime = checkTime;
	}
	public String getCheck() {
		return check;
	}
	public void setCheck(String check) {
		this.check = check;
	}
	public java.util.Date getDeleteTime() {
		return deleteTime;
	}
	public void setDeleteTime(java.util.Date deleteTime) {
		this.deleteTime = deleteTime;
	}
	public String getDelete() {
		return delete;
	}
	public void setDelete(String delete) {
		this.delete = delete;
	}
	

	
	
	
	

}
