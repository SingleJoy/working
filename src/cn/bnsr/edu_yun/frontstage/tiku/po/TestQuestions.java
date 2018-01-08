package cn.bnsr.edu_yun.frontstage.tiku.po;

public class TestQuestions {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column test_questions.id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column test_questions.test_paper_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    private Long test_paper_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column test_questions.question_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    private Long question_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column test_questions.questions_number
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    private Integer questions_number;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column test_questions.questions_score
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    private Double questions_score;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column test_questions.parent_question_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    private Long parent_question_id;
    
    private Integer question_status;
    
    private Integer question_type;
    
    private Integer question_is_son;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column test_questions.id
     *
     * @return the value of test_questions.id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column test_questions.id
     *
     * @param id the value for test_questions.id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column test_questions.test_paper_id
     *
     * @return the value of test_questions.test_paper_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public Long getTest_paper_id() {
        return test_paper_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column test_questions.test_paper_id
     *
     * @param test_paper_id the value for test_questions.test_paper_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public void setTest_paper_id(Long test_paper_id) {
        this.test_paper_id = test_paper_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column test_questions.question_id
     *
     * @return the value of test_questions.question_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public Long getQuestion_id() {
        return question_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column test_questions.question_id
     *
     * @param question_id the value for test_questions.question_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public void setQuestion_id(Long question_id) {
        this.question_id = question_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column test_questions.questions_number
     *
     * @return the value of test_questions.questions_number
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public Integer getQuestions_number() {
        return questions_number;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column test_questions.questions_number
     *
     * @param questions_number the value for test_questions.questions_number
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public void setQuestions_number(Integer questions_number) {
        this.questions_number = questions_number;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column test_questions.questions_score
     *
     * @return the value of test_questions.questions_score
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public Double getQuestions_score() {
        return questions_score;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column test_questions.questions_score
     *
     * @param questions_score the value for test_questions.questions_score
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public void setQuestions_score(Double questions_score) {
        this.questions_score = questions_score;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column test_questions.parent_question_id
     *
     * @return the value of test_questions.parent_question_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public Long getParent_question_id() {
        return parent_question_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column test_questions.parent_question_id
     *
     * @param parent_question_id the value for test_questions.parent_question_id
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    public void setParent_question_id(Long parent_question_id) {
        this.parent_question_id = parent_question_id;
    }
    
    public Integer getQuestion_status() {
		return question_status;
	}
    
    public void setQuestion_status(Integer question_status) {
		this.question_status = question_status;
	}
    public Integer getQuestion_type() {
		return question_type;
	}
    public void setQuestion_type(Integer question_type) {
		this.question_type = question_type;
	}
    public Integer getQuestion_is_son() {
		return question_is_son;
	}
    public void setQuestion_is_son(Integer question_is_son) {
		this.question_is_son = question_is_son;
	}
}