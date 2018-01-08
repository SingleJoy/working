package cn.bnsr.edu_yun.frontstage.tiku.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.tiku.po.TestQuestions;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperQuestionView;

public interface TestQuestionsMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table test_questions
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table test_questions
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    int insert(TestQuestions record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table test_questions
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    int insertSelective(TestQuestions record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table test_questions
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    TestQuestions selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table test_questions
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    int updateByPrimaryKeySelective(TestQuestions record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table test_questions
     *
     * @mbggenerated Tue Dec 06 10:04:22 CST 2016
     */
    int updateByPrimaryKey(TestQuestions record);

	void insertSelectiveList(List<TestQuestions> tqList);
	
	List<TestPaperQuestionView> queryTestPaperQuestionOnDoTest(TestPaperQuestionView testPaperQuestionView);
	/*
	List<TestPaperQuestionView> queryTestPaperQuestionOnDoCheck(TestPaperQuestionView testPaperQuestionView);
	*/
	List<TestPaperQuestionView> queryAllTestPaperQuestion(TestPaperQuestionView testPaperQuestionView);
	List<TestPaperQuestionView> queryAllTestPaperQuestionOnDoHomework(TestPaperQuestionView testPaperQuestionView);
	TestPaperQuestionView queryOneTestPaperQuestion(Long id);
	void updateTestQuestionsStatusByQid(TestPaperQuestionView testPaperQuestionView);
}