package cn.bnsr.edu_yun.frontstage.base.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.Grade;

public interface GradeMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table grade
     *
     * @mbggenerated Thu Sep 08 13:27:10 CST 2016
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table grade
     *
     * @mbggenerated Thu Sep 08 13:27:10 CST 2016
     */
    int insert(Grade record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table grade
     *
     * @mbggenerated Thu Sep 08 13:27:10 CST 2016
     */
    int insertSelective(Grade record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table grade
     *
     * @mbggenerated Thu Sep 08 13:27:10 CST 2016
     */
    Grade selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table grade
     *
     * @mbggenerated Thu Sep 08 13:27:10 CST 2016
     */
    int updateByPrimaryKeySelective(Grade record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table grade
     *
     * @mbggenerated Thu Sep 08 13:27:10 CST 2016
     */
    int updateByPrimaryKey(Grade record);
    public List<Grade> selectGrade();
    public Grade selectById(int id);
}