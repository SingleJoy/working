package cn.bnsr.edu_yun.frontstage.base.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.User_folder;

public interface User_folderMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_folder
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_folder
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    int insert(User_folder record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_folder
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    int insertSelective(User_folder record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_folder
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    User_folder selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_folder
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    int updateByPrimaryKeySelective(User_folder record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_folder
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    int updateByPrimaryKey(User_folder record);

	List<User_folder> findAllUserFolder();
}