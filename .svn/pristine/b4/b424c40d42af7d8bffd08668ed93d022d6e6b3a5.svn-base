package cn.bnsr.edu_yun.frontstage.train.service;

import java.text.ParseException;
import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.StudyTimeView;
import cn.bnsr.edu_yun.backstage.train.view.StudyTimeStatsView;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudyTime;

public interface UserStudyTimeService {

	int insert(UserStudyTime userStudyTime);
	
	List<StudyTimeView> selectSumByUserId(StudyTimeView studyTimeView); 
	
	List<StudyTimeView> selectSumByCourseId(StudyTimeView studyTimeView); 
	
	List<StudyTimeView> selectSumByCourseHour(StudyTimeView studyTimeView); 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//后台
    //查询观看时长趋势
    List<StudyTimeStatsView> queryWatchStats(StudyTimeStatsView condition) throws ParseException;

    List<StudyTimeView> selectViewByUserId(StudyTimeView studyTimeView);

	long selectViewByUserIdCount(StudyTimeView studyTimeView);
}
