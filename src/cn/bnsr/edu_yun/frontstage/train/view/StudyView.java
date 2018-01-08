package cn.bnsr.edu_yun.frontstage.train.view;

import java.util.Date;
import cn.bnsr.edu_yun.backstage.base.view.PageBase;

/**
 * 学习视图，我的课程，我的培训
 * @author fangxiongwei
 * @date 2017年3月2日
 */
public class StudyView extends PageBase{
	private long id;
	private String img;//图片
	private int is_studyed;//是否全学完：0-否，1-是
	private String name;//名称
	private double price;//价格
	private long user_id;//用户id
	
	private int source_type;//0-课程；1-培训
	private long studyNum;//学习了多少
	private long allNum;//总共多少
	
	private Date end_time;//课程结束时间
	private double score;//课程成绩
	private int hours;//课时
	private Long   cert_id;//证书id
	private String cert_name;//证书名称
	private Long user_study_id;
	
	private int completedAmount;//完成的课程/培训的数量
	private int uncompletedAmount;//未完成的课程/培训的数量
	private int finishReqHour;//已完成的必修课学时
	private int finishOptHour;//已完成的必修修课学时
	private String paping;//分页 0-取消分页 1-分页
	private int sortEndTime;//按照课程/培训的结束时间排序  0-不作为检索条件 1-作为检索条件
	private int type;//培训类型 0-普通  1-阶段
	private Long classId;//班级id
	private Date add_time;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getIs_studyed() {
		return is_studyed;
	}
	public void setIs_studyed(int is_studyed) {
		this.is_studyed = is_studyed;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public long getUser_id() {
		return user_id;
	}
	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}
	public int getSource_type() {
		return source_type;
	}
	public void setSource_type(int source_type) {
		this.source_type = source_type;
	}
	public long getStudyNum() {
		return studyNum;
	}
	public void setStudyNum(long studyNum) {
		this.studyNum = studyNum;
	}
	public long getAllNum() {
		return allNum;
	}
	public void setAllNum(long allNum) {
		this.allNum = allNum;
	}

	public Date getEnd_time() {
		return end_time;
	}
	
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	
	public double getScore() {
		return score;
	}
	
	public void setScore(double score) {
		this.score = score;
	}
	
	public String getCert_name() {
		return cert_name;
	}
	
	public void setCert_name(String cert_name) {
		this.cert_name = cert_name;
	}
	
	public Long getUser_study_id() {
		return user_study_id;
	}
	
	public void setUser_study_id(Long user_study_id) {
		this.user_study_id = user_study_id;
	}
	
	public int getCompletedAmount() {
		return completedAmount;
	}
	
	public void setCompletedAmount(int completedAmount) {
		this.completedAmount = completedAmount;
	}
	
	public int getUncompletedAmount() {
		return uncompletedAmount;
	}
	
	public void setUncompletedAmount(int uncompletedAmount) {
		this.uncompletedAmount = uncompletedAmount;
	}
	
	public String getPaping() {
		return paping;
	}
	
	public void setPaping(String paping) {
		this.paping = paping;
	}
	public int getHours() {
		return hours;
	}
	public void setHours(int hours) {
		this.hours = hours;
	}
	public int getSortEndTime() {
		return sortEndTime;
	}
	public void setSortEndTime(int sortEndTime) {
		this.sortEndTime = sortEndTime;
	}
	public Long getCert_id() {
		return cert_id;
	}
	public void setCert_id(Long cert_id) {
		this.cert_id = cert_id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public Long getClassId() {
		return classId;
	}
	public void setClassId(Long classId) {
		this.classId = classId;
	}
	public int getFinishReqHour() {
		return finishReqHour;
	}
	public void setFinishReqHour(int finishReqHour) {
		this.finishReqHour = finishReqHour;
	}
	public int getFinishOptHour() {
		return finishOptHour;
	}
	public void setFinishOptHour(int finishOptHour) {
		this.finishOptHour = finishOptHour;
	}
	public Date getAdd_time() {
		return add_time;
	}
	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}
	
}
