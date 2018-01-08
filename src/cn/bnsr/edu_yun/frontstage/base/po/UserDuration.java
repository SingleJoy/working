package cn.bnsr.edu_yun.frontstage.base.po;

import java.util.Date;

public class UserDuration {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_duration.id
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_duration.start_time
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    private Date start_time;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_duration.end_time
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    private Date end_time;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_duration.total_ms
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    private Long total_ms;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_duration.status
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    private Integer status;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_duration.user_id
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    private Long user_id;
    
    private Integer device;
    
    private String province_id;
    
    private String address;
    
    private String remote_ip;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_duration.id
     *
     * @return the value of user_duration.id
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_duration.id
     *
     * @param id the value for user_duration.id
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_duration.start_time
     *
     * @return the value of user_duration.start_time
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public Date getStart_time() {
        return start_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_duration.start_time
     *
     * @param start_time the value for user_duration.start_time
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_duration.end_time
     *
     * @return the value of user_duration.end_time
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public Date getEnd_time() {
        return end_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_duration.end_time
     *
     * @param end_time the value for user_duration.end_time
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_duration.total_ms
     *
     * @return the value of user_duration.total_ms
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public Long getTotal_ms() {
        return total_ms;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_duration.total_ms
     *
     * @param total_ms the value for user_duration.total_ms
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public void setTotal_ms(Long total_ms) {
        this.total_ms = total_ms;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_duration.status
     *
     * @return the value of user_duration.status
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public Integer getStatus() {
        return status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_duration.status
     *
     * @param status the value for user_duration.status
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public void setStatus(Integer status) {
        this.status = status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_duration.user_id
     *
     * @return the value of user_duration.user_id
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public Long getUser_id() {
        return user_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_duration.user_id
     *
     * @param user_id the value for user_duration.user_id
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }

	public Integer getDevice() {
		return device;
	}

	public void setDevice(Integer device) {
		this.device = device;
	}

	public String getProvince_id() {
		return province_id;
	}

	public void setProvince_id(String province_id) {
		this.province_id = province_id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRemote_ip() {
		return remote_ip;
	}

	public void setRemote_ip(String remote_ip) {
		this.remote_ip = remote_ip;
	}
    
}