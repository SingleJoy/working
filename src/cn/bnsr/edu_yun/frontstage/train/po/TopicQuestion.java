package cn.bnsr.edu_yun.frontstage.train.po;

import java.util.Date;

import cn.bnsr.edu_yun.frontstage.base.po.User;

public class TopicQuestion {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.user_id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    private Long user_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.source_id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    private Long source_id;
    
    private Long class_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.course_hour_id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    private Long course_hour_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.title
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    private String title;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.question_time
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    private Date question_time;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.last_reply_time
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    private Date last_reply_time;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.watch_times
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    private Integer watch_times;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.reply_times
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    private Integer reply_times;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.question_content
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    private String question_content;
    
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topic_question.source_type
     *
     * @mbggenerated Thu Feb 16 09:35:03 CST 2017
     */
    private Integer source_type;

    /**
     * 最后回复的人
     */
    private Long last_answer_user;
    
    private User user;
    
    private String last_answer_name;
    
    private Long last_answer_id;
    /**
     * 置顶
     */
    private Integer  stick;
    /**
     * 精华
     */
    private Integer  elite;
    
    private Integer is_delete;
    
    
    public Integer getStick() {
		return stick;
	}

	public void setStick(Integer stick) {
		this.stick = stick;
	}

	public Integer getElite() {
		return elite;
	}

	public void setElite(Integer elite) {
		this.elite = elite;
	}

	/**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topic_question.id
     *
     * @return the value of topic_question.id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topic_question.id
     *
     * @param id the value for topic_question.id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topic_question.user_id
     *
     * @return the value of topic_question.user_id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public Long getUser_id() {
        return user_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topic_question.user_id
     *
     * @param user_id the value for topic_question.user_id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topic_question.source_id
     *
     * @return the value of topic_question.source_id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public Long getSource_id() {
        return source_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topic_question.source_id
     *
     * @param source_id the value for topic_question.source_id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public void setSource_id(Long source_id) {
        this.source_id = source_id;
    }

    public Long getClass_id() {
		return class_id;
	}

	public void setClass_id(Long class_id) {
		this.class_id = class_id;
	}

	/**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topic_question.course_hour_id
     *
     * @return the value of topic_question.course_hour_id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public Long getCourse_hour_id() {
        return course_hour_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topic_question.course_hour_id
     *
     * @param course_hour_id the value for topic_question.course_hour_id
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public void setCourse_hour_id(Long course_hour_id) {
        this.course_hour_id = course_hour_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topic_question.title
     *
     * @return the value of topic_question.title
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public String getTitle() {
        return title;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topic_question.title
     *
     * @param title the value for topic_question.title
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topic_question.question_time
     *
     * @return the value of topic_question.question_time
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public Date getQuestion_time() {
        return question_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topic_question.question_time
     *
     * @param question_time the value for topic_question.question_time
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public void setQuestion_time(Date question_time) {
        this.question_time = question_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topic_question.last_reply_time
     *
     * @return the value of topic_question.last_reply_time
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public Date getLast_reply_time() {
        return last_reply_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topic_question.last_reply_time
     *
     * @param last_reply_time the value for topic_question.last_reply_time
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public void setLast_reply_time(Date last_reply_time) {
        this.last_reply_time = last_reply_time;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topic_question.watch_times
     *
     * @return the value of topic_question.watch_times
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public Integer getWatch_times() {
        return watch_times;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topic_question.watch_times
     *
     * @param watch_times the value for topic_question.watch_times
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public void setWatch_times(Integer watch_times) {
        this.watch_times = watch_times;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topic_question.reply_times
     *
     * @return the value of topic_question.reply_times
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public Integer getReply_times() {
        return reply_times;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topic_question.reply_times
     *
     * @param reply_times the value for topic_question.reply_times
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public void setReply_times(Integer reply_times) {
        this.reply_times = reply_times;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topic_question.question_content
     *
     * @return the value of topic_question.question_content
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public String getQuestion_content() {
        return question_content;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topic_question.question_content
     *
     * @param question_content the value for topic_question.question_content
     *
     * @mbggenerated Wed Nov 02 13:57:07 CST 2016
     */
    public void setQuestion_content(String question_content) {
        this.question_content = question_content;
    }

	public Integer getSource_type() {
		return source_type;
	}

	public void setSource_type(Integer source_type) {
		this.source_type = source_type;
	}

	public Long getLast_answer_user() {
		return last_answer_user;
	}

	public void setLast_answer_user(Long last_answer_user) {
		this.last_answer_user = last_answer_user;
	}

	public String getLast_answer_name() {
		return last_answer_name;
	}

	public void setLast_answer_name(String last_answer_name) {
		this.last_answer_name = last_answer_name;
	}

	public Long getLast_answer_id() {
		return last_answer_id;
	}

	public void setLast_answer_id(Long last_answer_id) {
		this.last_answer_id = last_answer_id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Integer getIs_delete() {
		return is_delete;
	}

	public void setIs_delete(Integer is_delete) {
		this.is_delete = is_delete;
	}

	
	
}