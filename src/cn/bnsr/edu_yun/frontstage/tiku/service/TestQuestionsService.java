package cn.bnsr.edu_yun.frontstage.tiku.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.tiku.po.TestQuestions;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperQuestionView;

public interface TestQuestionsService {

	void saveTestQueList(List<TestQuestions> tqList);

	void saveTestQuestion(TestQuestions tq);
	/**按类型查询试卷中的题目--考试状态 */
	List<TestPaperQuestionView> queryTestPaperQuestionOnDoTest(TestPaperQuestionView testPaperQuestionView);
	/** 按类型查询试卷中的题目--核对/批改状态
	List<TestPaperQuestionView> queryTestPaperQuestionOnDoCheck(TestPaperQuestionView testPaperQuestionView);
  	 */
	/**查询试卷内所有题目*/
	List<TestPaperQuestionView> queryAllTestPaperQuestion(TestPaperQuestionView testPaperQuestionView);
	/** 查看试卷内所有题目(含已删除的题目) */
	List<TestPaperQuestionView> queryAllTestPaperQuestionOnDoHomework(TestPaperQuestionView testPaperQuestionView);
	/**查询一道题目*/
	TestPaperQuestionView queryOneTestPaperQuestion(Long id);
	void delete(long id);
   void updateTestQuestion(TestQuestions tq);
   /** 根据试题id和状态更新试卷与试题的关联数据的试题状态 */
   void updateTestQuestionsStatusByQid(TestPaperQuestionView testPaperQuestionView);
}
