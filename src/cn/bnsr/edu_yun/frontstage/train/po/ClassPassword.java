package cn.bnsr.edu_yun.frontstage.train.po;

import java.util.Date;

public class ClassPassword {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column class_password.id
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column class_password.class_id
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    private Long class_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column class_password.code
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    private String code;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column class_password.is_use
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    private Integer is_use;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column class_password.use_time
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    private Date use_time;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column class_password.id
     *
     * @return the value of class_password.id
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column class_password.id
     *
     * @param id the value for class_password.id
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column class_password.class_id
     *
     * @return the value of class_password.class_id
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    public Long getClass_id() {
        return class_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column class_password.class_id
     *
     * @param class_id the value for class_password.class_id
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    public void setClass_id(Long class_id) {
        this.class_id = class_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column class_password.code
     *
     * @return the value of class_password.code
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    public String getCode() {
        return code;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column class_password.code
     *
     * @param code the value for class_password.code
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column class_password.is_use
     *
     * @return the value of class_password.is_use
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    public Integer getIs_use() {
        return is_use;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column class_password.is_use
     *
     * @param is_use the value for class_password.is_use
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    public void setIs_use(Integer is_use) {
        this.is_use = is_use;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column class_password.use_time
     *
     * @return the value of class_password.use_time
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    public Date getUse_time() {
        return use_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column class_password.use_time
     *
     * @param use_time the value for class_password.use_time
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    public void setUse_time(Date use_time) {
        this.use_time = use_time;
    }
}