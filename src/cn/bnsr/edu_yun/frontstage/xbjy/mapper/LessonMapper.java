package cn.bnsr.edu_yun.frontstage.xbjy.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.view.CommunityCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;
import cn.bnsr.edu_yun.frontstage.xbjy.po.Lesson;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.SubjectLessonView;

public interface LessonMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson
     *
     * @mbggenerated Fri Mar 10 13:47:22 CST 2017
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson
     *
     * @mbggenerated Fri Mar 10 13:47:22 CST 2017
     */
    int insert(Lesson record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson
     *
     * @mbggenerated Fri Mar 10 13:47:22 CST 2017
     */
    int insertSelective(Lesson record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson
     *
     * @mbggenerated Fri Mar 10 13:47:22 CST 2017
     */
    Lesson selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson
     *
     * @mbggenerated Fri Mar 10 13:47:22 CST 2017
     */
    int updateByPrimaryKeySelective(Lesson record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson
     *
     * @mbggenerated Fri Mar 10 13:47:22 CST 2017
     */
    int updateByPrimaryKeyWithBLOBs(Lesson record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson
     *
     * @mbggenerated Fri Mar 10 13:47:22 CST 2017
     */
    int updateByPrimaryKey(Lesson record);
    
    List<LessonView> queryLesson(LessonView lessonView);
    
    int queryTotalLesson(LessonView lessonView);
    
    LessonView findPK(Long userId);
    
    LessonView queryLessonView(Long id);
    
    void updateExcellent(LessonView lessonView);
    
    void updateStatus(LessonView lessonView);
    
    void saveLessonSelf(LessonView lessonView);
    
    List<LessonView> queryLessonMain(LessonView lessonView);
    
    int queryLessonMainCount(LessonView lessonView);

	List<LessonView> queryUserLesson(LessonView lessonView);

	int countUserLesson(LessonView lessonView);

	int queryTotalCommunityLesson(CommunityCenterView communityCenterView);

	List<LessonView> queryCommunityLesson(CommunityCenterView communityCenterView);

	List<DataStatsView> lessonDataStats(DataStatsView dataStatsView);
	
	List<LessonView> queryUserLessonCreate(LessonView lessonView);

	int countUserLessonCreate(LessonView lessonView);
	
	LessonView queryLessonOne(LessonView lessonView);
	
	List<LessonView> queryLessonByArea(LessonView lessonView);
	List<SubjectLessonView> queryLessonHome(SubjectLessonView subjectLessonView);
	
	/*
	 * 后台
	 */
	List<LessonView> search(LessonView lessonView);
	
	long total(LessonView lessonView);
	
	Long getMaxSeq(Long workshop_id);
	
	
}