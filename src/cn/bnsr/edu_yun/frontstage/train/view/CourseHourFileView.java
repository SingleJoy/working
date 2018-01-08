package cn.bnsr.edu_yun.frontstage.train.view;

/**
 * 课时子文件视图
 * @author fangxiongwei
 * @date 2016年11月9日
 */
public class CourseHourFileView {
	private String id;
	private String fileName;
	private String path;//
	private String file_profile;
	private Long class_id;
	private Long user_id;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getFile_profile() {
		return file_profile;
	}
	public void setFile_profile(String file_profile) {
		this.file_profile = file_profile;
	}
	public Long getClass_id() {
		return class_id;
	}
	public void setClass_id(Long class_id) {
		this.class_id = class_id;
	}
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	
}
