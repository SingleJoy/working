package cn.bnsr.edu_yun.backstage.base.mapper;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.po.RoleAuth;

public interface RoleAuthMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table role_auth
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    int deleteByPrimaryKey(Long id);

    int deleteByAuthId(Long auth_id);
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table role_auth
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    int insert(RoleAuth record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table role_auth
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    int insertSelective(RoleAuth record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table role_auth
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    RoleAuth selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table role_auth
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    int updateByPrimaryKeySelective(RoleAuth record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table role_auth
     *
     * @mbggenerated Mon Aug 29 15:35:13 CST 2016
     */
    int updateByPrimaryKey(RoleAuth record);

	public List<RoleAuth> getByRoleId(Long id);
}