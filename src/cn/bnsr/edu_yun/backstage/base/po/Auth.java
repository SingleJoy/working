package cn.bnsr.edu_yun.backstage.base.po;

import java.math.BigDecimal;

public class Auth {

	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column auth.id
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	private Long id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column auth.name
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	private String name;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column auth.seq
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	private BigDecimal seq;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column auth.url
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	private String url;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column auth.pid
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	private Long pid;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column auth.remarks
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	private String remarks;

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column auth.id
	 * @return  the value of auth.id
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public Long getId() {
		return id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column auth.id
	 * @param id  the value for auth.id
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column auth.name
	 * @return  the value of auth.name
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public String getName() {
		return name;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column auth.name
	 * @param name  the value for auth.name
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column auth.seq
	 * @return  the value of auth.seq
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public BigDecimal getSeq() {
		return seq;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column auth.seq
	 * @param seq  the value for auth.seq
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public void setSeq(BigDecimal seq) {
		this.seq = seq;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column auth.url
	 * @return  the value of auth.url
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column auth.url
	 * @param url  the value for auth.url
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column auth.pid
	 * @return  the value of auth.pid
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public Long getPid() {
		return pid;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column auth.pid
	 * @param pid  the value for auth.pid
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public void setPid(Long pid) {
		this.pid = pid;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column auth.remarks
	 * @return  the value of auth.remarks
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public String getRemarks() {
		return remarks;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column auth.remarks
	 * @param remarks  the value for auth.remarks
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}