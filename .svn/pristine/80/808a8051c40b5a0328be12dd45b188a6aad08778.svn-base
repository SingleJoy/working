package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.train.view.TopicAnswerView;
import cn.bnsr.edu_yun.frontstage.train.mapper.TopicAnswerMapper;
import cn.bnsr.edu_yun.frontstage.train.po.TopicAnswer;
import cn.bnsr.edu_yun.frontstage.train.service.TopicAnswerService;
import cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerMobileView;
import cn.bnsr.edu_yun.util.NumUtil;

public class TopicAnswerServiceImpl implements TopicAnswerService {

	@Autowired
	private TopicAnswerMapper mapper;

	@Override
	public TopicAnswer selectLastAnswer(long question_id) {

		return mapper.selectLastAnswer(question_id);
	}

	@Override
	public List<TopicAnswer> selectAnswerByQuestionId(long question_id,
			long start, long pageSize) {

		return mapper.selectAnswerByQuestionId(question_id, start, pageSize);
	}

	@Override
	public int insert(TopicAnswer topicAnswer) {

		return mapper.insertSelective(topicAnswer);
	}

	@Override
	public DataGrid datagrid(TopicAnswerView topicAnswerView) {
		
		DataGrid j = new DataGrid();
		topicAnswerView.setPage(NumUtil.startingNum(topicAnswerView.getPage(),topicAnswerView.getRows()));
		j.setRows(mapper.getByQuestionId(topicAnswerView));
		j.setTotal(mapper.count(topicAnswerView));
		return j;
	}

	@Override
	public void delete(String ids) {
		if(ids!=null){
			for(String id:ids.split(",")){
				mapper.deleteByPrimaryKey(Long.parseLong(id.trim()));
			}
		}
		
	}

	@Override
	public TopicAnswerView getById(Long id) {
		TopicAnswerView qaView = mapper.getById(id);
		if(qaView!=null){
			return qaView;
		}
		return null; 
	}

	@Override
	public Long count(TopicAnswerView topicAnswerView) {
		
		return mapper.count(topicAnswerView);
	}

	@Override
	public List<cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView> queryMyTopicAnswer(cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView topicAnswerView) {
		
		return mapper.queryMyTopicAnswer(topicAnswerView);
	}

	@Override
	public Integer queryMyTopicAnswerCount(cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView topicAnswerView) {
		
		return mapper.queryMyTopicAnswerCount(topicAnswerView);
	}

	@Override
	public List<TopicAnswerMobileView> selectAnswerM(long question_id) {
		
		return mapper.selectAnswerM(question_id);
	}

}
