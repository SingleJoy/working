package cn.bnsr.edu_yun.frontstage.base.po;

import java.util.Date;

public class Order {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.id
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.name
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private String name;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.number
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private String number;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.status
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private Integer status;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.create_time
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private Date create_time;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.amount
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private Double amount;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.pay_amount
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private Double pay_amount;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.coupon_code
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private String coupon_code;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.coupon_remarks
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private String coupon_remarks;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.coupon_cash
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private Double coupon_cash;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.order_from
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private Integer order_from;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.buy_type
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private Integer buy_type;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.buy_id
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private Long buy_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column order.user_id
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    private Long user_id;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.id
     *
     * @return the value of order.id
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.id
     *
     * @param id the value for order.id
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.name
     *
     * @return the value of order.name
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.name
     *
     * @param name the value for order.name
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.number
     *
     * @return the value of order.number
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public String getNumber() {
        return number;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.number
     *
     * @param number the value for order.number
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setNumber(String number) {
        this.number = number;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.status
     *
     * @return the value of order.status
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public Integer getStatus() {
        return status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.status
     *
     * @param status the value for order.status
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setStatus(Integer status) {
        this.status = status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.create_time
     *
     * @return the value of order.create_time
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public Date getCreate_time() {
        return create_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.create_time
     *
     * @param create_time the value for order.create_time
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.amount
     *
     * @return the value of order.amount
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public Double getAmount() {
        return amount;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.amount
     *
     * @param amount the value for order.amount
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setAmount(Double amount) {
        this.amount = amount;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.pay_amount
     *
     * @return the value of order.pay_amount
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public Double getPay_amount() {
        return pay_amount;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.pay_amount
     *
     * @param pay_amount the value for order.pay_amount
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setPay_amount(Double pay_amount) {
        this.pay_amount = pay_amount;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.coupon_code
     *
     * @return the value of order.coupon_code
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public String getCoupon_code() {
        return coupon_code;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.coupon_code
     *
     * @param coupon_code the value for order.coupon_code
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setCoupon_code(String coupon_code) {
        this.coupon_code = coupon_code;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.coupon_remarks
     *
     * @return the value of order.coupon_remarks
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public String getCoupon_remarks() {
        return coupon_remarks;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.coupon_remarks
     *
     * @param coupon_remarks the value for order.coupon_remarks
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setCoupon_remarks(String coupon_remarks) {
        this.coupon_remarks = coupon_remarks;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.coupon_cash
     *
     * @return the value of order.coupon_cash
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public Double getCoupon_cash() {
        return coupon_cash;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.coupon_cash
     *
     * @param coupon_cash the value for order.coupon_cash
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setCoupon_cash(Double coupon_cash) {
        this.coupon_cash = coupon_cash;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.order_from
     *
     * @return the value of order.order_from
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public Integer getOrder_from() {
        return order_from;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.order_from
     *
     * @param order_from the value for order.order_from
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setOrder_from(Integer order_from) {
        this.order_from = order_from;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.buy_type
     *
     * @return the value of order.buy_type
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public Integer getBuy_type() {
        return buy_type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.buy_type
     *
     * @param buy_type the value for order.buy_type
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setBuy_type(Integer buy_type) {
        this.buy_type = buy_type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.buy_id
     *
     * @return the value of order.buy_id
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public Long getBuy_id() {
        return buy_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.buy_id
     *
     * @param buy_id the value for order.buy_id
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setBuy_id(Long buy_id) {
        this.buy_id = buy_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column order.user_id
     *
     * @return the value of order.user_id
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public Long getUser_id() {
        return user_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column order.user_id
     *
     * @param user_id the value for order.user_id
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }
}