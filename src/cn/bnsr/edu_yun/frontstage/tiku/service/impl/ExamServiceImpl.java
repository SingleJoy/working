package cn.bnsr.edu_yun.frontstage.tiku.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.tiku.mapper.ExamAnswerMapper;
import cn.bnsr.edu_yun.frontstage.tiku.mapper.ExamMapper;
import cn.bnsr.edu_yun.frontstage.tiku.po.Exam;
import cn.bnsr.edu_yun.frontstage.tiku.po.ExamAnswer;
import cn.bnsr.edu_yun.frontstage.tiku.service.ExamService;
import cn.bnsr.edu_yun.frontstage.tiku.view.ExamView;
import cn.bnsr.edu_yun.frontstage.train.mapper.TrainPhaseMapper;
import cn.bnsr.edu_yun.frontstage.train.service.TrainCourseService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainPhaseView;

public class ExamServiceImpl implements ExamService{

	@Autowired
	private ExamMapper examMapper;
	@Autowired
	private ExamAnswerMapper examAnswerMapper;
	@Autowired 
	private TrainPhaseMapper trainPhaseMapper;
	@Autowired 
	private TrainCourseService trainCourseService;
	@Override
	public int insertSelective(Exam exam) {
		
		return examMapper.insertSelective(exam);
	}

	@Override
	public Exam selectStatus(Exam exam) {
		
		return examMapper.selectStatus(exam);
	}

	@Override
	public int saveAnswer(ExamAnswer examAnswer) {
	List<ExamAnswer> examAnswers = examAnswerMapper.selectByExamAndTest(examAnswer);
		if(examAnswers.size()>0){
			examAnswer.setId(examAnswers.get(0).getId());
			return examAnswerMapper.updateByPrimaryKeyWithBLOBs(examAnswer);
		}else{
		return examAnswerMapper.insertSelective(examAnswer);
		}
	}

	@Override
	public int updateByPrimaryKeySelective(Exam exam) {
		
		return examMapper.updateByPrimaryKeySelective(exam);
	}

	@Override
	public List<ExamView> queryExam(ExamView examView) {
		
		return examMapper.queryExam(examView);
	}

	@Override
	public int updateAnswer(ExamAnswer examAnswer) {
		
		return examAnswerMapper.updateByPrimaryKeySelective(examAnswer);
	}

	@Override
	public List<ExamAnswer> selectByExam(Long id) {
		
		return examAnswerMapper.selectByExam(id);
	}

	@Override
	public Exam selectById(long id) {
		
		return examMapper.selectByPrimaryKey(id);
	}

	@Override
	public ExamAnswer selectAnswer(long id) {
		
		return examAnswerMapper.selectByPrimaryKey(id);
	}

	@Override
	public int queryExamCount(ExamView examView) {
		
		return examMapper.queryExamCount(examView);
	}

	@Override
	public List<ExamView> queryMyExam(ExamView examView) {
		
		return examMapper.queryMyExam(examView);
	}

	@Override
	public int queryMyExamCount(ExamView examView) {
		
		return examMapper.queryMyExamCount(examView);
	}

	@Override
	public List<TrainPhaseView> queryTrainPhaseExam(Long id,Long trainId) {
		List<TrainPhaseView> trainPhaseList =  trainPhaseMapper.queryTrainPhase(trainId,null);
		for(TrainPhaseView tp : trainPhaseList ){
			//必修课程
			List<CourseView> requiredCourse = trainCourseService.queryTrainCourseExam(id,1,tp.getId(),0);
			tp.setRequiredCourse(requiredCourse);
			//选修课程
			List<CourseView> optionCourse = trainCourseService.queryTrainCourseExam(id,1,tp.getId(),1);
			tp.setOptionCourse(optionCourse);
			tp.setTotleNum(optionCourse.size()+requiredCourse.size());
		}
		return trainPhaseList;
	}

	@Override
	public Integer queryExamGrade(ExamView examView) {
		
		return examMapper.queryExamGrade(examView);
	}

	@Override
	public List<ExamView> queryMyCommunityExam(ExamView examView) {
		return examMapper.queryMyCommunityExam(examView);
	}

	@Override
	public int queryMyCommunityExamCount(ExamView examView) {
		// TODO Auto-generated method stub
		return examMapper.queryMyCommunityExamCount(examView);
	}

}
