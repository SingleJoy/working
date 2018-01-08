package cn.bnsr.edu_yun.frontstage.tiku.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.tiku.mapper.TestQuestionsMapper;
import cn.bnsr.edu_yun.frontstage.tiku.po.TestQuestions;
import cn.bnsr.edu_yun.frontstage.tiku.service.TestQuestionsService;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperQuestionView;

public class TestQuestionsServiceImpl implements TestQuestionsService{
	@Autowired
	private TestQuestionsMapper testQuestionsMapper;

	@Override
	public void saveTestQueList(List<TestQuestions> tqList) {
		testQuestionsMapper.insertSelectiveList(tqList);		
	}

	@Override
	public void saveTestQuestion(TestQuestions tq) {
		testQuestionsMapper.insertSelective(tq);		
	}

	@Override
	public List<TestPaperQuestionView> queryAllTestPaperQuestion(
			TestPaperQuestionView testPaperQuestionView) {
		
		return testQuestionsMapper.queryAllTestPaperQuestion(testPaperQuestionView);
	}

	@Override
	public void delete(long id) {

		testQuestionsMapper.deleteByPrimaryKey(id);
		
	}

	@Override
	public void updateTestQuestion(TestQuestions tq) {
		
		testQuestionsMapper.updateByPrimaryKeySelective(tq);
	}

	@Override
	public TestPaperQuestionView queryOneTestPaperQuestion(Long id) {
		// TODO Auto-generated method stub
		return testQuestionsMapper.queryOneTestPaperQuestion(id);
	}

	@Override
	public void updateTestQuestionsStatusByQid(
			TestPaperQuestionView testPaperQuestionView) {
		testQuestionsMapper.updateTestQuestionsStatusByQid(testPaperQuestionView);
	}

	@Override
	public List<TestPaperQuestionView> queryTestPaperQuestionOnDoTest(
			TestPaperQuestionView testPaperQuestionView) {
		// TODO Auto-generated method stub
		return testQuestionsMapper.queryTestPaperQuestionOnDoTest(testPaperQuestionView);
	}

	@Override
	public List<TestPaperQuestionView> queryAllTestPaperQuestionOnDoHomework(
			TestPaperQuestionView testPaperQuestionView) {
		// TODO Auto-generated method stub
		return testQuestionsMapper.queryAllTestPaperQuestionOnDoHomework(testPaperQuestionView);
	}

	/*
	@Override
	public List<TestPaperQuestionView> queryTestPaperQuestionOnDoCheck(
			TestPaperQuestionView testPaperQuestionView) {
		// TODO Auto-generated method stub
		return testQuestionsMapper.queryTestPaperQuestionOnDoCheck(testPaperQuestionView);
	}
	*/
	
	
}
