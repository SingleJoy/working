package cn.bnsr.edu_yun.frontstage.base.view;

/**
 * 我的资源模型类
 * 
 * @author apple
 *
 */
public class MyResourcesView {
	private int id;// 文件id
	private String fileName;// 文件名
	private String phase;// 学段
	private String subject;// 科目Ø
	private String type;// 类型
	private String version;// 版本
	private String grade;// 年级
	private java.util.Date uploadTime;// 时间
	private int columnId;
	private long upload_user;// 上传人id；
	private String fileType;// 文件类型;
	private String classification_entryId;
	private String catalogId;
	private String time;// 上传时间的载体
	private String size;// 文件大小
	private int startLine;// 翻页起始行
	private int rows;// 每页显示记录数
	private int page;// 当前页
	private int totalPage;// 总页数
	private int total;// 总数(多少篇作品)

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getPhase() {
		return phase;
	}

	public void setPhase(String phase) {
		this.phase = phase;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public java.util.Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(java.util.Date uploadTime) {
		this.uploadTime = uploadTime;
	}

	public int getColumnId() {
		return columnId;
	}

	public void setColumnId(int columnId) {
		this.columnId = columnId;
	}

	public long getUpload_user() {
		return upload_user;
	}

	public void setUpload_user(long upload_user) {
		this.upload_user = upload_user;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getClassification_entryId() {
		return classification_entryId;
	}

	public void setClassification_entryId(String classification_entryId) {
		this.classification_entryId = classification_entryId;
	}

	public String getCatalogId() {
		return catalogId;
	}

	public void setCatalogId(String catalogId) {
		this.catalogId = catalogId;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getStartLine() {
		return startLine;
	}

	public void setStartLine(int startLine) {
		this.startLine = startLine;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}
	

}
