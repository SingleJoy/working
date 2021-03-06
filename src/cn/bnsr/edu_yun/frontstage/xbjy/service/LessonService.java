package cn.bnsr.edu_yun.frontstage.xbjy.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;
import cn.bnsr.edu_yun.frontstage.xbjy.po.Lesson;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.SubjectLessonView;

public interface LessonService {

	/**查询课例list*/
	List<LessonView> queryLesson(LessonView lessonView);
	
	/**查询课例总数*/
	int queryTotalLesson(LessonView lessonView);
	
	void saveLesson(LessonView lessonView);
	
	LessonView findPK(Long userId);
	
	Lesson getById(Long id);
	
    LessonView queryLessonView(Long id);
    
    void updateExcellent(LessonView lessonView);
    
    void updateStatus(LessonView lessonView);

	void saveLessonSelf(LessonView lessonView);
	
	 List<LessonView> queryLessonMain(LessonView lessonView);
	 
	 int queryLessonMainCount(LessonView lessonView);
	 
	 int update(Lesson lesson);

	List<LessonView> queryUserLesson(LessonView lessonView);

	int countUserLesson(LessonView lessonView);

	List<LessonView> queryCommunityLesson(CommunityCenterView communityCenterView);

	int queryTotalCommunityLesson(CommunityCenterView communityCenterView);

	/**课例数据统计*/
	List<DataStatsView> lessonDataStats(DataStatsView dataStatsView);
	
	List<LessonView> queryUserLessonCreate(LessonView lessonView);

	int countUserLessonCreate(LessonView lessonView);
	
	LessonView queryLessonOne(LessonView lessonView);
	
	List<LessonView> queryLessonByArea(LessonView lessonView);
	
	List<SubjectLessonView> queryLessonHome(SubjectLessonView subjectLessonView);
	
	/*
	 * 后台
	 */
	DataGrid datagrid(LessonView lessonView);
	
	Long getMaxSeq(Long workshop_id);
}
