package cn.bnsr.edu_yun.frontstage.train.mapper;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.StudyTimeView;
import cn.bnsr.edu_yun.backstage.train.view.StudyTimeStatsView;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudyTime;

public interface UserStudyTimeMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_study_time
     *
     * @mbggenerated Thu Sep 07 16:27:02 CST 2017
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_study_time
     *
     * @mbggenerated Thu Sep 07 16:27:02 CST 2017
     */
    int insert(UserStudyTime record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_study_time
     *
     * @mbggenerated Thu Sep 07 16:27:02 CST 2017
     */
    int insertSelective(UserStudyTime record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_study_time
     *
     * @mbggenerated Thu Sep 07 16:27:02 CST 2017
     */
    UserStudyTime selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_study_time
     *
     * @mbggenerated Thu Sep 07 16:27:02 CST 2017
     */
    int updateByPrimaryKeySelective(UserStudyTime record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_study_time
     *
     * @mbggenerated Thu Sep 07 16:27:02 CST 2017
     */
    int updateByPrimaryKey(UserStudyTime record);
    
    //后台
    //查询观看时长趋势
    List<StudyTimeStatsView> queryWatchStats(StudyTimeStatsView condition);
    
   Long sumTotalUserTime(UserStudyTime userStudyTime);
   
   List<StudyTimeView> selectViewByUserId(StudyTimeView studyTimeView); 
   
   long selectViewByUserIdCount(StudyTimeView studyTimeView); 
   
   List<StudyTimeView> selectSumByUserId(StudyTimeView studyTimeView); 
   
   List<StudyTimeView> selectSumByCourseId(StudyTimeView studyTimeView); 
   
   List<StudyTimeView> selectSumByCourseHour(StudyTimeView studyTimeView); 
}