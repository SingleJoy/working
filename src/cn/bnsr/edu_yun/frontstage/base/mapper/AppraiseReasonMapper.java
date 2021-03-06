package cn.bnsr.edu_yun.frontstage.base.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.AppraiseReason;
import cn.bnsr.edu_yun.frontstage.train.view.AppraiseReasonView;

public interface AppraiseReasonMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table appraise_reason
     *
     * @mbggenerated Sun Sep 24 17:06:18 CST 2017
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table appraise_reason
     *
     * @mbggenerated Sun Sep 24 17:06:18 CST 2017
     */
    int insert(AppraiseReason record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table appraise_reason
     *
     * @mbggenerated Sun Sep 24 17:06:18 CST 2017
     */
    int insertSelective(AppraiseReason record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table appraise_reason
     *
     * @mbggenerated Sun Sep 24 17:06:18 CST 2017
     */
    AppraiseReason selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table appraise_reason
     *
     * @mbggenerated Sun Sep 24 17:06:18 CST 2017
     */
    int updateByPrimaryKeySelective(AppraiseReason record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table appraise_reason
     *
     * @mbggenerated Sun Sep 24 17:06:18 CST 2017
     */
    int updateByPrimaryKey(AppraiseReason record);
    
    List<AppraiseReasonView> selectAll(AppraiseReasonView appraiseReasonView);
    
    long total();
    
    List<AppraiseReasonView> selectByType(AppraiseReasonView appraiseReasonView);
}