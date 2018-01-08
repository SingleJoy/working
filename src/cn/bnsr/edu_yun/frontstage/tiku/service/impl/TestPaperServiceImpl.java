package cn.bnsr.edu_yun.frontstage.tiku.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.tiku.mapper.QuestionMapper;
import cn.bnsr.edu_yun.frontstage.tiku.mapper.QuestionMaterialMapper;
import cn.bnsr.edu_yun.frontstage.tiku.mapper.TestPaperMapper;
import cn.bnsr.edu_yun.frontstage.tiku.po.Question;
import cn.bnsr.edu_yun.frontstage.tiku.po.QuestionMaterial;
import cn.bnsr.edu_yun.frontstage.tiku.po.TestPaper;
import cn.bnsr.edu_yun.frontstage.tiku.po.TestQuestions;
import cn.bnsr.edu_yun.frontstage.tiku.service.TestPaperService;
import cn.bnsr.edu_yun.frontstage.tiku.service.TestQuestionsService;
import cn.bnsr.edu_yun.frontstage.tiku.view.QuestionView;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperQuestionView;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperView;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;

public class TestPaperServiceImpl implements TestPaperService {

	@Autowired
	private TestPaperMapper testPaperMapper;
	@Autowired
	private TestQuestionsService testQuestionsService;
	@Autowired
	private QuestionMapper questionMapper;
	@Autowired
	private QuestionMaterialMapper questionMaterialMapper;

	@Override
	public void saveTask(CourseHour courseHour, String questionIds, String questionSeqs,String[] accordScores) {
		TestPaper tp = new TestPaper();
		tp.setCourse_hour_id(courseHour.getId());
		tp.setCourse_id(courseHour.getCourse_id());
		tp.setName(courseHour.getHour_title());
		tp.setRemarks(courseHour.getRemarks());
		tp.setType(1);// 作业
		tp.setUser_id(courseHour.getUser_id());
		tp.setCreate_time(new Date());
		tp.setStatus(1);// 发布
		String[] qids = questionIds.split(",");
		tp.setTotal_number(qids.length);// 总题数
		String accord_score="";
		for(int i=0;i<accordScores.length;i++){
			double score=Double.parseDouble(accordScores[i])/100;
			if(i!=0&&i!=(accordScores.length-1)){
				accord_score+=","+score+",";
			}else{
				accord_score+=score;
			}
			
		}
		tp.setAccord_score(accord_score);
		testPaperMapper.insertSelective(tp);
		// List<TestQuestions> tqList = new ArrayList<TestQuestions>();
		/*
		 * li 修改于2017-3-16
		 * 需要存总分数
		 */
		double totalscore=0;
		for (int i = 0; i < qids.length; i++) {
			/*
			 * li 修改于2017-2-21
			 * 需要存题目分数
			 */
			TestQuestions tq = new TestQuestions();
			tq.setQuestion_id(Long.parseLong(qids[i]));
			Question question= questionMapper.selectByPrimaryKey(tq.getQuestion_id());
			tq.setQuestions_score(question.getScore());
			tq.setTest_paper_id(tp.getId());
			tq.setQuestions_number(Integer.parseInt(questionSeqs.split(",")[i]));
			testQuestionsService.saveTestQuestion(tq);
			totalscore+=question.getScore();
			/*
			 * li 修改于2017-2-14
			 * 如果题目为材料题
			 * 需要加入子题
			 */
		
		if(question.getType()==4){
			List<Question> sons = questionMapper.selectAllsonQuestion(question.getId());
			for (Question son : sons) {
				TestQuestions tq_son = new TestQuestions();
				tq_son.setQuestion_id(son.getId());
				tq_son.setTest_paper_id(tp.getId());
				tq_son.setParent_question_id(question.getId());
				tq_son.setQuestions_score(son.getScore());
				testQuestionsService.saveTestQuestion(tq_son);
				totalscore+=son.getScore();
			}
		}
			
			// tqList.add(tq);
		}
		tp.setTotal_score(totalscore);
		testPaperMapper.updateByPrimaryKey(tp);
		// testQuestionsService.saveTestQueList(tqList);

	}

	@Override
	public void choiceQuestion(QuestionView questionView, TestPaperView testPaperView) {
		TestPaper testPaper = new TestPaper();
		if (testPaperView.getId() != null) {
			testPaper.setId(testPaperView.getId());
		} else {
			testPaper.setName(testPaperView.getName());
			testPaper.setRemarks(testPaperView.getRemarks());
			testPaper.setTimeless(testPaperView.getTimeless());
			testPaper.setMode(testPaperView.getMode());
			testPaper.setSubject_range(testPaperView.getRange());
			testPaper.setCourse_id(testPaperView.getCourseId());
			testPaper.setType(0);
			testPaper.setUser_id(questionView.getUserId());
			Date date = new Date();
			testPaper.setCreate_time(date);
			testPaper.setUpdate_time(date);
			testPaper.setIs_objective(0);
			testPaper.setStatus(0);

			if (testPaperView.getRange() == 1) {
				String hour_range = testPaperView.getChapterListStart() + "," + testPaperView.getChapterListEnd();
				testPaper.setHour_range(hour_range);
			}
			testPaperMapper.insertSelective(testPaper);
		}
		int total_number = 0;
		double total_score = 0;
		int seq = 1;
		for (int type = 5; type < 6;) {//加了一个单选这个逻辑都乱了，需要把单选排前面
			List<QuestionView> questionList = new ArrayList<QuestionView>();
			questionView.setType(type);
			questionView.setDifficulty(0);
			List<QuestionView> simple = questionMapper.queryQuestion(questionView);
			questionView.setDifficulty(1);
			List<QuestionView> normal = questionMapper.queryQuestion(questionView);
			questionView.setDifficulty(2);
			List<QuestionView> difficulty = questionMapper.queryQuestion(questionView);
			for (QuestionView q : simple) {
				questionList.add(q);
			}
			for (QuestionView q : normal) {
				questionList.add(q);
			}
			for (QuestionView q : difficulty) {
				questionList.add(q);
			}

			int questionCount = 0;
			double questions_score = 0;
			if (type == 0) {
				questionCount = testPaperView.getCountsChoice();
				questions_score = testPaperView.getScoresChoice();
			} else if (type == 1) {
				questionCount = testPaperView.getCountsFill();
				questions_score = testPaperView.getScoresFill();
			} else if (type == 2) {
				questionCount = testPaperView.getCountsJudge();
				questions_score = testPaperView.getScoresJudge();
			} else if (type == 3) {
				questionCount = testPaperView.getCountsQa();
				questions_score = testPaperView.getScoresQa();
			} else if(type==4){
				questionCount = testPaperView.getCountsScience();
				questions_score = testPaperView.getScoresScience();
			}else{
				questionCount = testPaperView.getCountsOneChoice();
				questions_score = testPaperView.getScoresOneChoice();
			}
			Random ra = new Random();
			List<QuestionView> questionList_ = new ArrayList<QuestionView>();
			if (testPaperView.getMode() == 0) {
				int simple_percentage = testPaperView.getSimple_percentage();
				int normal_percentage = testPaperView.getNormal_percentage();
				int difficulty_percentage = testPaperView.getDifficulty_percentage();
				double p0 = questionCount * simple_percentage / 100.0;
				double p1 = questionCount * normal_percentage / 100.0;
				double p2 = questionCount * difficulty_percentage / 100.0;

				for (int i = 1; i <= p0; i++) {
					if (simple.size() == 0) {
						continue;
					}
					int index = ra.nextInt(simple.size());
					QuestionView q = simple.get(index);
					questionList_.add(q);
					int allIndex = questionList.indexOf(q);
					simple.remove(index);
					if (allIndex != -1)
						questionList.remove(allIndex);
				}
				for (int i = 1; i <= p1; i++) {
					if (normal.size() == 0) {
						continue;
					}
					int index = ra.nextInt(normal.size());
					QuestionView q = normal.get(index);
					questionList_.add(q);
					int allIndex = questionList.indexOf(q);
					normal.remove(index);
					if (allIndex != -1)
						questionList.remove(allIndex);
				}
				for (int i = 1; i <= p2; i++) {
					if (difficulty.size() == 0) {
						continue;
					}
					int index = ra.nextInt(difficulty.size());
					QuestionView q = difficulty.get(index);
					questionList_.add(q);
					int allIndex = questionList.indexOf(q);
					difficulty.remove(index);
					if (allIndex != -1)
						questionList.remove(allIndex);
				}
			}
			int otherQuestionCount = questionCount - questionList_.size();
			if (questionList_.size() < questionCount) {
				for (int i = 1; i <= otherQuestionCount; i++) {
					if (questionList.size() < 1) {
						continue;
					}
					int index = ra.nextInt(questionList.size());
					QuestionView q = questionList.get(index);
					questionList_.add(q);
					questionList.remove(index);
				}
				total_number += questionCount;
				for (QuestionView q : questionList_) {
					TestQuestions tq = new TestQuestions();
					tq.setQuestion_id(q.getId());
					tq.setTest_paper_id(testPaper.getId());
					if (q.getType() == 4) {
						List<Question> sons = questionMapper.selectAllsonQuestion(q.getId());
						for (Question son : sons) {
							TestQuestions tq_son = new TestQuestions();
							tq_son.setQuestion_id(son.getId());
							tq_son.setTest_paper_id(testPaper.getId());
							tq_son.setQuestions_score(questions_score);
							tq_son.setParent_question_id(q.getId());
							tq_son.setQuestions_number(seq++);
							tq_son.setQuestion_status(1);
							testQuestionsService.saveTestQuestion(tq_son);
							total_score += questions_score;
						}
					} else {
						tq.setQuestions_score(questions_score);
						tq.setQuestions_number(seq++);
						total_score += questions_score;
					}
					tq.setQuestion_status(1);
					testQuestionsService.saveTestQuestion(tq);
				}

			}
			//加入单选题后改变的逻辑，单选为5，需要放前面
			if(type==4){
				type=6;
			}
			if(type<4){
				type++;
			}
			if(type==5){
				type=0;
			}
		}
		testPaper.setTotal_number(total_number);
		testPaper.setTotal_score(total_score);
		testPaperMapper.updateByPrimaryKeySelective(testPaper);
		testPaperView.setId(testPaper.getId());
		testPaperView.setTotal_score(total_score);
	}

	@Override
	public List<TestPaperView> queryTestPaper(TestPaperView testPaperView) {

		return testPaperMapper.queryTestPaper(testPaperView);
	}

	@Override
	public TestPaper selectById(long id) {

		return testPaperMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateTestPaper(TestPaper testPaper) {

		testPaperMapper.updateByPrimaryKeySelective(testPaper);
	}

	@Override
	public void testPaperSave(TestPaperView testPaperView) {
		List<Long> lists = testPaperView.getList();
		List<Integer> seqs = testPaperView.getSeq();
		List<Double> scores = testPaperView.getScores();
		double total_score = 0;
		for (int i = 0; i < lists.size(); i++) {
			TestQuestions tq = new TestQuestions();
			tq.setQuestion_id(lists.get(i));
			tq.setQuestions_number(seqs.get(i));
			tq.setQuestions_score(scores.get(i));
			if (scores.get(i) != null) {
				total_score += scores.get(i);
			}
			tq.setTest_paper_id(testPaperView.getId());
			tq.setQuestion_status(1);
			testQuestionsService.saveTestQuestion(tq);
		}

		TestPaper testPaper = new TestPaper();
		Integer total_number = lists.size();
		testPaper.setId(testPaperView.getId());
		testPaper.setTotal_number(total_number);
		testPaper.setTotal_score(total_score);
		double accord_score=Double.parseDouble(testPaperView.getAccord_score())/total_score;
		testPaper.setAccord_score(accord_score+"");
		testPaperMapper.updateByPrimaryKeySelective(testPaper);
		TestPaperQuestionView testPaperQuestionView = new TestPaperQuestionView();
		testPaperQuestionView.setTestPaper_id(testPaperView.getId());
		testPaperQuestionView.setType(6);
		//List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryTestPaperQuestion(testPaperQuestionView);
		List<TestPaperQuestionView> testPaperQuestionViews = testQuestionsService.queryTestPaperQuestionOnDoTest(testPaperQuestionView);
		for (TestPaperQuestionView view : testPaperQuestionViews) {
			TestQuestions tq = new TestQuestions();
			List<QuestionMaterial> p = questionMaterialMapper.selectBySonId(view.getQuestion_id());
			tq.setParent_question_id(p.get(0).getQuestion_id());
			tq.setId(view.getId());
			testQuestionsService.updateTestQuestion(tq);
		}
	}

	@Override
	public int queryTestPaperCount(TestPaperView testPaperView) {
		
		return testPaperMapper.queryTestPaperCount(testPaperView);
	}

	@Override
	public TestPaper selectByCourseHourId(Long course_hour_id) {
		
		return testPaperMapper.selectByCourseHourId(course_hour_id);
	}

	@Override
	public List<TestPaper> selectByCourseIdPublish(Long course_id) {
		
		return testPaperMapper.selectByCourseIdPublish(course_id);
	}

	@Override
	public void resetTestPaper(Long course_hour_id) {
		testPaperMapper.resetTestPaper(course_hour_id);
	}

}
