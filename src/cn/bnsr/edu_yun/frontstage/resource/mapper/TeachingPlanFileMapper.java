package cn.bnsr.edu_yun.frontstage.resource.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.resource.po.TeachingPlanFile;

public interface TeachingPlanFileMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table teaching_plan_file
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table teaching_plan_file
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    int insert(TeachingPlanFile record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table teaching_plan_file
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    int insertSelective(TeachingPlanFile record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table teaching_plan_file
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    TeachingPlanFile selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table teaching_plan_file
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    int updateByPrimaryKeySelective(TeachingPlanFile record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table teaching_plan_file
     *
     * @mbggenerated Sun Aug 13 16:06:55 CST 2017
     */
    int updateByPrimaryKey(TeachingPlanFile record);
    
    List<TeachingPlanFile>  selectByPlanId(Long id);
}