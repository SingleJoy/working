package cn.bnsr.edu_yun.frontstage.resource.po;

import java.util.Date;

public class FileAmount {

	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column file_amount.id
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	private Long id;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column file_amount.amount
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	private Double amount;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column file_amount.status
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	private Byte status;
	/**
	 * This field was generated by MyBatis Generator. This field corresponds to the database column file_amount.create_time
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	private Date create_time;

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column file_amount.id
	 * @return  the value of file_amount.id
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	public Long getId() {
		return id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column file_amount.id
	 * @param id  the value for file_amount.id
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column file_amount.amount
	 * @return  the value of file_amount.amount
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	public Double getAmount() {
		return amount;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column file_amount.amount
	 * @param amount  the value for file_amount.amount
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	public void setAmount(Double amount) {
		this.amount = amount;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column file_amount.status
	 * @return  the value of file_amount.status
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	public Byte getStatus() {
		return status;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column file_amount.status
	 * @param status  the value for file_amount.status
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	public void setStatus(Byte status) {
		this.status = status;
	}

	/**
	 * This method was generated by MyBatis Generator. This method returns the value of the database column file_amount.create_time
	 * @return  the value of file_amount.create_time
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	public Date getCreate_time() {
		return create_time;
	}

	/**
	 * This method was generated by MyBatis Generator. This method sets the value of the database column file_amount.create_time
	 * @param create_time  the value for file_amount.create_time
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
}