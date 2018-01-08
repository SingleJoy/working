package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.train.view.TopicAnswerView;
import cn.bnsr.edu_yun.frontstage.train.po.TopicAnswer;
import cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerMobileView;

public interface TopicAnswerService {

	/**
	 * 查询最后一个回复者
	 * 
	 * @param question_id
	 * @return
	 */
	TopicAnswer selectLastAnswer(long question_id);

	/**
	 * 查询所有回复
	 * 
	 * @param question_id
	 * @param start
	 * @param pageSize
	 * @return
	 */
	List<TopicAnswer> selectAnswerByQuestionId(long question_id, long start,
			long pageSize);
	Long count(TopicAnswerView topicAnswerView);
	/**
	 * 进行回复
	 * 
	 * @param topicAnswer
	 * @return
	 */
	int insert(TopicAnswer topicAnswer);
	
	//后台
	DataGrid datagrid(TopicAnswerView topicAnswerView);
	
	void delete(String ids);
	
	TopicAnswerView getById(Long id);
	
	List<cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView> queryMyTopicAnswer(cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView topicAnswerView);

	Integer queryMyTopicAnswerCount(cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView topicAnswerView);

	  List<TopicAnswerMobileView> selectAnswerM( long question_id);
}
