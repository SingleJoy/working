package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.train.view.CourseNoteView;
import cn.bnsr.edu_yun.frontstage.base.view.NoteView;
import cn.bnsr.edu_yun.frontstage.train.po.CourseNote;
import cn.bnsr.edu_yun.frontstage.train.view.TrainDetailView;

public interface CourseNoteService {

	/**
	 * 按课程查笔记总数
	 * @param course_id
	 * @return
	 */
	 int selectCountByCourseId(long course_id,String course_hour_id);
	
	 /**
	 * 按课程分页查询笔记，指定排序字段
	 * @param course_id
	 * @param sort
	 * @param start
	 * @param pageSize
	 * @return 
	 */
	 List<CourseNote>  selectByCourseId(long course_id,String course_hour_id,String sort,long start,long pageSize);
	   
	 CourseNote selectCountById(long id);
	 
	 int update(CourseNote courseNote);
	 
	 int insert(CourseNote courseNote);
	 
	 CourseNote selectByHourIdAndUserId(long user_id,long course_hour_id);
	 
	 //后台courseIds
	 DataGrid datagrid(CourseNoteView courseNoteView);
		
	 void delete(String ids);
	
	 CourseNoteView getById(Long id);
	 
	 List<NoteView> queryMyNote(NoteView view);
	 int queryMyNoteCount(NoteView view);
	 
	 List<NoteView> queryMyCourseNote(NoteView view);
	 int queryMyCourseNoteCount(NoteView view);
	 
	 //删除
	 int deleteNote(long id);

	 /**根据课程ids 查询课程笔记*/
	 List<CourseNoteView> queryCourseIdsNote(TrainDetailView trainDetailView);
	 
	 /**根据课程ids 查询课程笔记总数*/
	 int queryTotalCourseIdsNote(TrainDetailView trainDetailView);
	 
	 List<cn.bnsr.edu_yun.frontstage.train.view.CourseNoteView> queryNoteM(long user_id,long course_id,int status);

}