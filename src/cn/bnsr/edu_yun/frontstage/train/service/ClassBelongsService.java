package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.ClassBelongs;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityCourseView;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityTrainView;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;

public interface ClassBelongsService {
	
	void saveClassBelongs(ClassBelongs classBelongs);
	
	void updateClassBelogs(ClassBelongs classBelongs);
	
	ClassBelongs selectClassBelongsByClassId(Long classId);
	
	/**查询社区课程list */
	List<CommunityCourseView> queryCommunityCourses(CommunityCourseView communityCourseView);
	
	/** 查询社区培训list */
	List<CommunityTrainView> queryCommunityTrains(CommunityTrainView communityTrainView);

	/** 查询社区课程list总数 */
	int queryCommunityCoursesTotal(CommunityCourseView communityCourseView);

	/** 查询社区培训list总数 */
	int queryCommunityTrainsTotal(CommunityTrainView communityTrainView);

	/** 查询社区-工作坊/课程-培训统计*/
	List<DataStatsView> classBelongsDataStats(DataStatsView dataStatsView);

	void batchUpdateStatus(long[] ids,int status);
}
