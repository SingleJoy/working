package cn.bnsr.edu_yun.frontstage.train.po;

public class CommunityRelation {

	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column community_relation.id
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	private Long id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column community_relation.community_id
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	private Long community_id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column community_relation.type
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	private Integer type;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column community_relation.subject_id
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	private String subject_id;

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column community_relation.id
	 * @return  the value of community_relation.id
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	public Long getId() {
		return id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column community_relation.id
	 * @param id  the value for community_relation.id
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column community_relation.community_id
	 * @return  the value of community_relation.community_id
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	public Long getCommunity_id() {
		return community_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column community_relation.community_id
	 * @param community_id  the value for community_relation.community_id
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	public void setCommunity_id(Long community_id) {
		this.community_id = community_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column community_relation.type
	 * @return  the value of community_relation.type
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	public Integer getType() {
		return type;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column community_relation.type
	 * @param type  the value for community_relation.type
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	public void setType(Integer type) {
		this.type = type;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column community_relation.subject_id
	 * @return  the value of community_relation.subject_id
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	public String getSubject_id() {
		return subject_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column community_relation.subject_id
	 * @param subject_id  the value for community_relation.subject_id
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	public void setSubject_id(String subject_id) {
		this.subject_id = subject_id;
	}
}