package cn.bnsr.edu_yun.frontstage.train.po;

public class UserTrainClass {

	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column user_train_class.id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	private Long id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column user_train_class.source_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	private Long source_id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column user_train_class.user_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	private Long user_id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column user_train_class.class_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	private Long class_id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column user_train_class.is_studyed
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	private Integer is_studyed;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column user_train_class.course_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	private Long course_id;

	private int source_type;
	
	private Long user_study_id;
	
	private Integer train_required;
	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column user_train_class.id
	 * @return  the value of user_train_class.id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public Long getId() {
		return id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column user_train_class.id
	 * @param id  the value for user_train_class.id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column user_train_class.source_id
	 * @return  the value of user_train_class.source_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */

	public Long getSource_id() {
		return source_id;
	}

	

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column user_train_class.source_id
	 * @param source_id  the value for user_train_class.source_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public void setSource_id(Long source_id) {
		this.source_id = source_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column user_train_class.user_id
	 * @return  the value of user_train_class.user_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public Long getUser_id() {
		return user_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column user_train_class.user_id
	 * @param user_id  the value for user_train_class.user_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column user_train_class.class_id
	 * @return  the value of user_train_class.class_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public Long getClass_id() {
		return class_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column user_train_class.class_id
	 * @param class_id  the value for user_train_class.class_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public void setClass_id(Long class_id) {
		this.class_id = class_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column user_train_class.is_studyed
	 * @return  the value of user_train_class.is_studyed
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public Integer getIs_studyed() {
		return is_studyed;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column user_train_class.is_studyed
	 * @param is_studyed  the value for user_train_class.is_studyed
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public void setIs_studyed(Integer is_studyed) {
		this.is_studyed = is_studyed;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column user_train_class.course_id
	 * @return  the value of user_train_class.course_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public Long getCourse_id() {
		return course_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column user_train_class.course_id
	 * @param course_id  the value for user_train_class.course_id
	 * @mbggenerated  Thu Mar 09 15:48:42 CST 2017
	 */
	public void setCourse_id(Long course_id) {
		this.course_id = course_id;
	}

	public int getSource_type() {
		return source_type;
	}

	public void setSource_type(int source_type) {
		this.source_type = source_type;
	}

	public Long getUser_study_id() {
		return user_study_id;
	}

	public void setUser_study_id(Long user_study_id) {
		this.user_study_id = user_study_id;
	}

	public Integer getTrain_required() {
		return train_required;
	}

	public void setTrain_required(Integer train_required) {
		this.train_required = train_required;
	}
	
	
}