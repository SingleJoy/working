package cn.bnsr.edu_yun.frontstage.base.po;

import java.util.Date;

public class OnlineUser {

	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column online_user.id
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	private Long id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column online_user.user_id
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	private Long user_id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column online_user.device
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	private Integer device;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column online_user.province_id
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	private String province_id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column online_user.address
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	private String address;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column online_user.create_time
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	private Date create_time;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column online_user.is_add
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	private Integer is_add;

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column online_user.id
	 * @return  the value of online_user.id
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public Long getId() {
		return id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column online_user.id
	 * @param id  the value for online_user.id
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column online_user.user_id
	 * @return  the value of online_user.user_id
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public Long getUser_id() {
		return user_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column online_user.user_id
	 * @param user_id  the value for online_user.user_id
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column online_user.device
	 * @return  the value of online_user.device
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public Integer getDevice() {
		return device;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column online_user.device
	 * @param device  the value for online_user.device
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public void setDevice(Integer device) {
		this.device = device;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column online_user.province_id
	 * @return  the value of online_user.province_id
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public String getProvince_id() {
		return province_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column online_user.province_id
	 * @param province_id  the value for online_user.province_id
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public void setProvince_id(String province_id) {
		this.province_id = province_id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column online_user.address
	 * @return  the value of online_user.address
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column online_user.address
	 * @param address  the value for online_user.address
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column online_user.create_time
	 * @return  the value of online_user.create_time
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public Date getCreate_time() {
		return create_time;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column online_user.create_time
	 * @param create_time  the value for online_user.create_time
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column online_user.is_add
	 * @return  the value of online_user.is_add
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public Integer getIs_add() {
		return is_add;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column online_user.is_add
	 * @param is_add  the value for online_user.is_add
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	public void setIs_add(Integer is_add) {
		this.is_add = is_add;
	}
}