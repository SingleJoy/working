package cn.bnsr.edu_yun.frontstage.train.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.bnsr.edu_yun.backstage.train.view.TopicAnswerView;
import cn.bnsr.edu_yun.frontstage.train.po.TopicAnswer;
import cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerMobileView;

public interface TopicAnswerMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table topic_answer
     *
     * @mbggenerated Wed Nov 02 13:54:37 CST 2016
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table topic_answer
     *
     * @mbggenerated Wed Nov 02 13:54:37 CST 2016
     */
    int insert(TopicAnswer record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table topic_answer
     *
     * @mbggenerated Wed Nov 02 13:54:37 CST 2016
     */
    int insertSelective(TopicAnswer record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table topic_answer
     *
     * @mbggenerated Wed Nov 02 13:54:37 CST 2016
     */
    TopicAnswer selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table topic_answer
     *
     * @mbggenerated Wed Nov 02 13:54:37 CST 2016
     */
    int updateByPrimaryKeySelective(TopicAnswer record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table topic_answer
     *
     * @mbggenerated Wed Nov 02 13:54:37 CST 2016
     */
    int updateByPrimaryKeyWithBLOBs(TopicAnswer record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table topic_answer
     *
     * @mbggenerated Wed Nov 02 13:54:37 CST 2016
     */
    int updateByPrimaryKey(TopicAnswer record);
    
    TopicAnswer  selectLastAnswer(long question_id);

	List<TopicAnswer> selectAnswerByQuestionId(@Param("question_id") long question_id, @Param("start") long start,@Param("pageSize") long pageSize);
	
	//后台
	List<TopicAnswerView> getByQuestionId(TopicAnswerView topicAnswerView);
	
    Long count(TopicAnswerView topicAnswerView);
    
    TopicAnswerView getById(Long id);
    
    List<cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView> queryMyTopicAnswer(cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView topicAnswerView);
    
    Integer queryMyTopicAnswerCount(cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView topicAnswerView);

    List<TopicAnswerMobileView> selectAnswerM(@Param("question_id") long question_id);
}