package cn.bnsr.edu_yun.frontstage.train.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.UserCert;

public interface UserCertMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_cert
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_cert
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int insert(UserCert record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_cert
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int insertSelective(UserCert record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_cert
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    UserCert selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_cert
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int updateByPrimaryKeySelective(UserCert record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_cert
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int updateByPrimaryKey(UserCert record);
    
    List<UserCert> selectByUserCert(UserCert record);
}