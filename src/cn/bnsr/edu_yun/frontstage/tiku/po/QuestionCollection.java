package cn.bnsr.edu_yun.frontstage.tiku.po;

import java.util.Date;

public class QuestionCollection {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column question_collection.id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column question_collection.user_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    private Long user_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column question_collection.question_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    private Long question_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column question_collection.create_time
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    private Date create_time;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column question_collection.id
     *
     * @return the value of question_collection.id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column question_collection.id
     *
     * @param id the value for question_collection.id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column question_collection.user_id
     *
     * @return the value of question_collection.user_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public Long getUser_id() {
        return user_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column question_collection.user_id
     *
     * @param user_id the value for question_collection.user_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column question_collection.question_id
     *
     * @return the value of question_collection.question_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public Long getQuestion_id() {
        return question_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column question_collection.question_id
     *
     * @param question_id the value for question_collection.question_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public void setQuestion_id(Long question_id) {
        this.question_id = question_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column question_collection.create_time
     *
     * @return the value of question_collection.create_time
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public Date getCreate_time() {
        return create_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column question_collection.create_time
     *
     * @param create_time the value for question_collection.create_time
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }
}