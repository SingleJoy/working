package cn.bnsr.edu_yun.backstage.base.po;

public class RoleAuth {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column role_auth.id
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    private Long id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column role_auth.role_id
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    private Long role_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column role_auth.auth_id
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    private Long auth_id;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column role_auth.id
     *
     * @return the value of role_auth.id
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    public Long getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column role_auth.id
     *
     * @param id the value for role_auth.id
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column role_auth.role_id
     *
     * @return the value of role_auth.role_id
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    public Long getRole_id() {
        return role_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column role_auth.role_id
     *
     * @param role_id the value for role_auth.role_id
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    public void setRole_id(Long role_id) {
        this.role_id = role_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column role_auth.auth_id
     *
     * @return the value of role_auth.auth_id
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    public Long getAuth_id() {
        return auth_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column role_auth.auth_id
     *
     * @param auth_id the value for role_auth.auth_id
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    public void setAuth_id(Long auth_id) {
        this.auth_id = auth_id;
    }
}