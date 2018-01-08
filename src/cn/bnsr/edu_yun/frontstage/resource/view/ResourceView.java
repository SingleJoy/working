package cn.bnsr.edu_yun.frontstage.resource.view;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;
import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;

/**
 * 资源列表视图
 * @author fangxiongwei
 * @date 2016年8月22日
 */
public class ResourceView extends PageBase{
	private String stage;//学段
	private String subject;//科目
	private String edition;//版本
	private String stageId;//学段id
	private String subjectId;//学科、科目id
	private String editionId;//教材版本id
	private String gradeId;//年级id
	private String chapterId;//章节id
	private String sectionId;//小节id
	private List<SubjectList> subjectList;//科目list
	private List<PubverList> editionList;//教材版本list
	private List<BookCat> gradeList;//年级list
	private List<BookCat> chapterList;//章节list
	private List<BookCat> sectionList;//小节list
	
	private String fileId;
	private String fileName;//文档名
	private String format;//文档格式
	private String uploadName;//上传人
	private String score;//评分
	private String size;//大小
	private String uploadTime;//上传时间
	private String image;//封面图片
	private int downloadNum;//下载数
	private int collectionNum;//收藏数 
	private double value;//价格
	
	private int recommendTotal;//推荐总数
	private String sort;//排序字段
	private String isNot;//是否是第一次
	private String type;//类别
	private Integer file_type;
	private Integer status;
	private Integer source_type;
	private Long source_id;
	private String icon;
	public String getStage() {
		return stage;
	}
	public void setStage(String stage) {
		this.stage = stage;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getEdition() {
		return edition;
	}
	public void setEdition(String edition) {
		this.edition = edition;
	}
	public String getStageId() {
		return stageId;
	}
	public void setStageId(String stageId) {
		this.stageId = stageId;
	}
	public String getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}
	public String getEditionId() {
		return editionId;
	}
	public void setEditionId(String editionId) {
		this.editionId = editionId;
	}
	public String getGradeId() {
		return gradeId;
	}
	public void setGradeId(String gradeId) {
		this.gradeId = gradeId;
	}
	public String getChapterId() {
		return chapterId;
	}
	public void setChapterId(String chapterId) {
		this.chapterId = chapterId;
	}
	public String getSectionId() {
		return sectionId;
	}
	public void setSectionId(String sectionId) {
		this.sectionId = sectionId;
	}
	public List<SubjectList> getSubjectList() {
		return subjectList;
	}
	public void setSubjectList(List<SubjectList> subjectList) {
		this.subjectList = subjectList;
	}
	public List<PubverList> getEditionList() {
		return editionList;
	}
	public void setEditionList(List<PubverList> editionList) {
		this.editionList = editionList;
	}
	public List<BookCat> getGradeList() {
		return gradeList;
	}
	public void setGradeList(List<BookCat> gradeList) {
		this.gradeList = gradeList;
	}
	public List<BookCat> getChapterList() {
		return chapterList;
	}
	public void setChapterList(List<BookCat> chapterList) {
		this.chapterList = chapterList;
	}
	public List<BookCat> getSectionList() {
		return sectionList;
	}
	public void setSectionList(List<BookCat> sectionList) {
		this.sectionList = sectionList;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public String getUploadName() {
		return uploadName;
	}
	public void setUploadName(String uploadName) {
		this.uploadName = uploadName;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getDownloadNum() {
		return downloadNum;
	}
	public void setDownloadNum(int downloadNum) {
		this.downloadNum = downloadNum;
	}
	public int getCollectionNum() {
		return collectionNum;
	}
	public void setCollectionNum(int collectionNum) {
		this.collectionNum = collectionNum;
	}
	public int getRecommendTotal() {
		return recommendTotal;
	}
	public void setRecommendTotal(int recommendTotal) {
		this.recommendTotal = recommendTotal;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getIsNot() {
		return isNot;
	}
	public void setIsNot(String isNot) {
		this.isNot = isNot;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public double getValue() {
		return value;
	}
	public void setValue(double value) {
		this.value = value;
	}
	public Integer getFile_type() {
		return file_type;
	}
	public void setFile_type(Integer file_type) {
		this.file_type = file_type;
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
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	

	
}
