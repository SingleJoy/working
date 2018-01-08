package cn.bnsr.edu_yun.frontstage.tiku.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.tiku.po.Exam;
import cn.bnsr.edu_yun.frontstage.tiku.po.ExamAnswer;
import cn.bnsr.edu_yun.frontstage.tiku.view.ExamView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainPhaseView;

public interface ExamService {

	int insertSelective(Exam exam);
	
	 int updateByPrimaryKeySelective(Exam exam);
	
	Exam selectStatus(Exam exam);
	
	Exam selectById(long id);
	
	ExamAnswer selectAnswer(long id);
	
	int saveAnswer(ExamAnswer examAnswer);
	
	int updateAnswer(ExamAnswer examAnswer);
	
	 List<ExamView> queryExam(ExamView examView);
	 
	 List<ExamAnswer> selectByExam(Long id);
	 
	 int queryExamCount(ExamView examView);
	 
	 List<ExamView> queryMyExam(ExamView examView);
	   
	 int queryMyExamCount(ExamView examView);
	 
	 List<TrainPhaseView> queryTrainPhaseExam(Long id,Long trainId);
	 
	 Integer queryExamGrade(ExamView examView);
	 
	 List<ExamView> queryMyCommunityExam(ExamView examView);
	 
	 int queryMyCommunityExamCount(ExamView examView);
}
