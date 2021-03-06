package cn.bnsr.edu_yun.frontstage.xbjy.mapper;

import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonProblem;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonProblemView;

public interface LessonProblemMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson_problem
     *
     * @mbggenerated Wed Mar 22 16:36:55 CST 2017
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson_problem
     *
     * @mbggenerated Wed Mar 22 16:36:55 CST 2017
     */
    int insert(LessonProblem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson_problem
     *
     * @mbggenerated Wed Mar 22 16:36:55 CST 2017
     */
    int insertSelective(LessonProblem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson_problem
     *
     * @mbggenerated Wed Mar 22 16:36:55 CST 2017
     */
    LessonProblem selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson_problem
     *
     * @mbggenerated Wed Mar 22 16:36:55 CST 2017
     */
    int updateByPrimaryKeySelective(LessonProblem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson_problem
     *
     * @mbggenerated Wed Mar 22 16:36:55 CST 2017
     */
    int updateByPrimaryKeyWithBLOBs(LessonProblem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lesson_problem
     *
     * @mbggenerated Wed Mar 22 16:36:55 CST 2017
     */
    int updateByPrimaryKey(LessonProblem record);
    
    void updateByLesssonId(LessonProblemView lessonProblemView);
     
    LessonProblemView findByLesson(Long lesson_id);
    
}