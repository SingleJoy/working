package cn.bnsr.edu_yun.frontstage.train.po;

import java.util.Date;

public class CourseInfo {

	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column course_info.id
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	private Long id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column course_info.target
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	private String target;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column course_info.crowd
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	private String crowd;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column course_info.img
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	private String img;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column course_info.price
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	private Double price;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column course_info.is_recommend
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	private Integer is_recommend;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column course_info.recommend_time
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	private Date recommend_time;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column course_info.recommend_seq
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	private Integer recommend_seq;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column course_info.course_id
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	private Long course_id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column course_info.profile
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	private String profile;
	
	private Integer is_default_img;

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column course_info.id
	 * @return  the value of course_info.id
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public Long getId() {
		return id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column course_info.id
	 * @param id  the value for course_info.id
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column course_info.target
	 * @return  the value of course_info.target
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public String getTarget() {
		return target;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column course_info.target
	 * @param target  the value for course_info.target
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public void setTarget(String target) {
		this.target = target;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column course_info.crowd
	 * @return  the value of course_info.crowd
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public String getCrowd() {
		return crowd;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column course_info.crowd
	 * @param crowd  the value for course_info.crowd
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public void setCrowd(String crowd) {
		this.crowd = crowd;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column course_info.img
	 * @return  the value of course_info.img
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public String getImg() {
		return img;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column course_info.img
	 * @param img  the value for course_info.img
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public void setImg(String img) {
		this.img = img;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column course_info.price
	 * @return  the value of course_info.price
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public Double getPrice() {
		return price;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column course_info.price
	 * @param price  the value for course_info.price
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public void setPrice(Double price) {
		this.price = price;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column course_info.is_recommend
	 * @return  the value of course_info.is_recommend
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public Integer getIs_recommend() {
		return is_recommend;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column course_info.is_recommend
	 * @param is_recommend  the value for course_info.is_recommend
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public void setIs_recommend(Integer is_recommend) {
		this.is_recommend = is_recommend;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column course_info.recommend_time
	 * @return  the value of course_info.recommend_time
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public Date getRecommend_time() {
		return recommend_time;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column course_info.recommend_time
	 * @param recommend_time  the value for course_info.recommend_time
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public void setRecommend_time(Date recommend_time) {
		this.recommend_time = recommend_time;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column course_info.recommend_seq
	 * @return  the value of course_info.recommend_seq
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public Integer getRecommend_seq() {
		return recommend_seq;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column course_info.recommend_seq
	 * @param recommend_seq  the value for course_info.recommend_seq
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public void setRecommend_seq(Integer recommend_seq) {
		this.recommend_seq = recommend_seq;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column course_info.course_id
	 * @return  the value of course_info.course_id
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public Long getCourse_id() {
		return course_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column course_info.course_id
	 * @param course_id  the value for course_info.course_id
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public void setCourse_id(Long course_id) {
		this.course_id = course_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column course_info.profile
	 * @return  the value of course_info.profile
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public String getProfile() {
		return profile;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column course_info.profile
	 * @param profile  the value for course_info.profile
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	public void setProfile(String profile) {
		this.profile = profile;
	}

	public Integer getIs_default_img() {
		return is_default_img;
	}

	public void setIs_default_img(Integer is_default_img) {
		this.is_default_img = is_default_img;
	}
}