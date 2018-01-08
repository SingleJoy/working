package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.StudyTimeView;
import cn.bnsr.edu_yun.frontstage.train.po.TopicQuestion;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.TopicQuestionMobileView;
import cn.bnsr.edu_yun.frontstage.train.view.TopicQuestionView;

public interface TopicQuestionService {

	int selectCountByCourseId(long course_id, int type, int elite);

	List<TopicQuestion> selectByCourseId(long course_id, int type, int elite, String sort, long start, long pageSize);

	
	int selectCountByClassId(long class_id, int elite);

	List<TopicQuestion> selectByClassId(long class_id, int elite, String sort, long start, long pageSize);
	
	List<TopicQuestion> selectByCourseHourId(long course_hour_id, String sort, long start, long pageSize);

	int insert(TopicQuestion topicQuestion);

	int update(TopicQuestion topicQuestion);

	int delete(TopicQuestion topicQuestion);

	TopicQuestion selectById(long id);

	List<TopicQuestionView> queryQuestion(TopicQuestionView topicQuestionView);

	int queryTotalQuestion(TopicQuestionView topicQuestionView);

	int countAllTopicQuestion(TopicQuestion topicQuestion);
	
	int queryTopicCount(TopicQuestionView topicQuestionView);
	
	 List<StudyTimeView> selectTopicChart(StudyTimeView studyTimeView);

	// 后台
	DataGrid datagrid(TopicQuestionView topicQuestionView);

	void delete(String ids);

	TopicQuestionView getById(Long id);

	List<TopicQuestionView> queryUserStudentsAsk(TopicQuestionView topicQuestionView);

	int queryUserTotalQuestion(TopicQuestionView topicQuestionView);

	List<TopicQuestionView> queryTopic(TopicQuestionView topicQuestionView);

	List<TopicQuestionView> queryTopicCommunity(CommunityCenterView communityCenterView);

	int queryTopicCommunityCount(CommunityCenterView communityCenterView);
	
	 List<TopicQuestionMobileView>   selectByCourseIdM(long source_id,int source_type,Long user_id,Integer type);

	 TopicQuestionMobileView selectByIdM(long id);
}
