package cn.bnsr.edu_yun.frontstage.train.po;

public class CourseLabelRelation {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column course_label_relation.id
     *
     * @mbggenerated Thu Oct 27 14:30:11 CST 2016
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column course_label_relation.course_id
     *
     * @mbggenerated Thu Oct 27 14:30:11 CST 2016
     */
    private Long course_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column course_label_relation.course_label_id
     *
     * @mbggenerated Thu Oct 27 14:30:11 CST 2016
     */
    private Long course_label_id;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column course_label_relation.id
     *
     * @return the value of course_label_relation.id
     *
     * @mbggenerated Thu Oct 27 14:30:11 CST 2016
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column course_label_relation.id
     *
     * @param id the value for course_label_relation.id
     *
     * @mbggenerated Thu Oct 27 14:30:11 CST 2016
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column course_label_relation.course_id
     *
     * @return the value of course_label_relation.course_id
     *
     * @mbggenerated Thu Oct 27 14:30:11 CST 2016
     */
    public Long getCourse_id() {
        return course_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column course_label_relation.course_id
     *
     * @param course_id the value for course_label_relation.course_id
     *
     * @mbggenerated Thu Oct 27 14:30:11 CST 2016
     */
    public void setCourse_id(Long course_id) {
        this.course_id = course_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column course_label_relation.course_label_id
     *
     * @return the value of course_label_relation.course_label_id
     *
     * @mbggenerated Thu Oct 27 14:30:11 CST 2016
     */
    public Long getCourse_label_id() {
        return course_label_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column course_label_relation.course_label_id
     *
     * @param course_label_id the value for course_label_relation.course_label_id
     *
     * @mbggenerated Thu Oct 27 14:30:11 CST 2016
     */
    public void setCourse_label_id(Long course_label_id) {
        this.course_label_id = course_label_id;
    }
}