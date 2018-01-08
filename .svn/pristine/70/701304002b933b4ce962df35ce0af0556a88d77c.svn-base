package cn.bnsr.edu_yun.frontstage.tiku.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.tiku.po.Question;
import cn.bnsr.edu_yun.frontstage.tiku.view.QuestionView;

public interface QuestionService {

	/** 翻页查询题库列表*/
	List<QuestionView> queryQuestion(QuestionView questionView);
	
	/** 翻页查询题库列表总数*/
	int queryTotalCourse(QuestionView questionView);
	/** 选择*/
	int insertSelect(QuestionView questionView);
	/** 填空*/
	int insertFill(QuestionView questionView);
	/** 判断和问答*/
	int insertJudgeAndQa(QuestionView questionView);
	/** 材料*/
	int insertScience(QuestionView questionView);
	/** 通过id查Question*/
	Question selectById(Long id);
	/** 根据questionIds 查询题目信息*/
	List<QuestionView> searchQuestion(String questionIds);
	/**分页查询子题列表*/
	List<QuestionView> querySonQuestion(QuestionView questionView);
	/**删除问题*/
	int deleteQuestion(long id);
	/**子题的总数 */
	int querySonQuestionCount(QuestionView questionView);
	/**所有的子题 */
	List<Question> selectAllsonQuestion(Long id);
	/**每种类型题目的数量 */
	QuestionView selectEveryQuestionTypeCount(QuestionView questionView);
	

}
