package cn.bnsr.edu_yun.frontstage.resource.po;

public class TeachingPlanFile {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column teaching_plan_file.id
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column teaching_plan_file.teaching_plan_id
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    private Long teaching_plan_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column teaching_plan_file.filename
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    private String filename;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column teaching_plan_file.url
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    private String url;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column teaching_plan_file.id
     *
     * @return the value of teaching_plan_file.id
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column teaching_plan_file.id
     *
     * @param id the value for teaching_plan_file.id
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column teaching_plan_file.teaching_plan_id
     *
     * @return the value of teaching_plan_file.teaching_plan_id
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    public Long getTeaching_plan_id() {
        return teaching_plan_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column teaching_plan_file.teaching_plan_id
     *
     * @param teaching_plan_id the value for teaching_plan_file.teaching_plan_id
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    public void setTeaching_plan_id(Long teaching_plan_id) {
        this.teaching_plan_id = teaching_plan_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column teaching_plan_file.filename
     *
     * @return the value of teaching_plan_file.filename
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    public String getFilename() {
        return filename;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column teaching_plan_file.filename
     *
     * @param filename the value for teaching_plan_file.filename
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    public void setFilename(String filename) {
        this.filename = filename;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column teaching_plan_file.url
     *
     * @return the value of teaching_plan_file.url
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    public String getUrl() {
        return url;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column teaching_plan_file.url
     *
     * @param url the value for teaching_plan_file.url
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    public void setUrl(String url) {
        this.url = url;
    }
}