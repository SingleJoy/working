package cn.bnsr.edu_yun.frontstage.train.service;

import java.text.ParseException;
import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.frontstage.resource.view.SearchView;
import cn.bnsr.edu_yun.frontstage.train.po.Course;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.SchoolCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.UserCollectView;

public interface CourseService {

	/**查询用户课程管理list*/
	List<CourseView> queryCourse(CourseView courseView);

	/**查询课程总数*/
	int queryTotalCourse(CourseView courseView);
	
	/**创建课程*/
	Long createCourse(String title, Long userId,int type,String room_id);
	
	/**保存课程信息*/
	void saveCourse(CourseView courseView);

	/**查询课程基础信息*/
	CourseView queryCourseInfo(CourseView courseView);

	/**发布课程*/
	void releaseCourse(String id);

	/**根据课程id查询课程详细*/
	Course getById(Long courseId);

	/**后台*/
	/**课程管理列表*/
	public DataGrid datagrid(CourseView courseView);
	
	/**课程管理操作*/
	void updateStatus(CourseView courseView);
	
	List<SchoolCenterView> querySchoolCourse(SchoolCenterView view);
	int querySchoolCourseCount(SchoolCenterView view);
	
	List<SchoolCenterView> querySchoolTeacher(SchoolCenterView view);
	int querySchoolTeacherCount(SchoolCenterView view);
	
	List<SchoolCenterView>querySchoolResourse(SchoolCenterView view);
	int querySchoolResourseCount(SchoolCenterView view);

	/**课程中心课程*/
	List<CourseCenterView> queryCourseCenter(CourseCenterView ccv);

	int queryTotalCourseCenter(CourseCenterView ccv);
	
	/**根据课程ids查询课程信息*/
	List<CourseView> getByCourseIds(List<String> list);

	/**培训首页-课程*/
	List<CourseView> queryClassifyCourse();

	/**社区课程列表*/
	List<CommunityCenterView> queryCommunityCourse(CommunityCenterView ccv);
	/**社区课程列表总数*/
	int queryTotalCommunityCourse(CommunityCenterView ccv);
	
	/**加入的社区中我的课程列表*/
	List<CommunityCenterView> queryMyCommunityCourse(CommunityCenterView ccv);
	/**加入的社区中我的课程列表总数*/
	int queryTotalMyCommunityCourse(CommunityCenterView ccv);
	
	List<CourseView> queryMyJoinCourse(CourseView courseView);
	
	int queryMyJoinCourseCount(CourseView courseView);

	
	List<SearchView> querySearch(SearchView searchView);
	
	int querySearchCount(SearchView searchView);

	
	DataGrid generalCourseDatagrid(CourseView courseView) throws ParseException;
	
	List<CourseView> queryCourseRanking(String sort);
	
	List<UserCollectView> searchCourceM(String str);
	/** 个人主页查询创建课程 */
	List<CourseView> queryCreateCourseOfPersonal(CourseView courseView);
	/** 个人主页查询创建课程总数 */
	int queryTotalCreateCourseOfPersonal(CourseView courseView);
 
}
