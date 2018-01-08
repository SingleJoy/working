package cn.bnsr.edu_yun.frontstage.tiku.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.tiku.po.TestPaper;
import cn.bnsr.edu_yun.frontstage.tiku.view.QuestionView;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperView;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;

public interface TestPaperService {

	/**保存课时作业*/
	void saveTask(CourseHour courseHour, String questionIds,String questionSeqs,String[] accordScores);
	/**试卷指定难度挑选问题 */
	void choiceQuestion(QuestionView questionView,TestPaperView examView);
	/**试卷列表*/
	List<TestPaperView> queryTestPaper(TestPaperView testPaperView);
	/**通过id查询TestPaper*/
	TestPaper selectById(long id);
	/**试卷状态改变*/
	void updateTestPaper(TestPaper testPaper);
	/**通过List保存试卷题目*/
	void testPaperSave(TestPaperView testPaperView);
	/**总数*/
	int queryTestPaperCount(TestPaperView testPaperView);
	/**通过course_hour_id找作业*/
	TestPaper selectByCourseHourId(Long course_hour_id);
	 /**找已发布的试卷*/
	List<TestPaper> selectByCourseIdPublish(Long course_id);
	/** 重置已使用的试卷 */
	void resetTestPaper(Long course_hour_id);
}
