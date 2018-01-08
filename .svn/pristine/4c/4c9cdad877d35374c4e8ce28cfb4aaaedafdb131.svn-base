package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.ClassBelongsMapper;
import cn.bnsr.edu_yun.frontstage.train.po.ClassBelongs;
import cn.bnsr.edu_yun.frontstage.train.service.ClassBelongsService;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityCourseView;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityTrainView;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;

public class ClassBelongsServiceImpl implements ClassBelongsService{
	@Autowired
	private ClassBelongsMapper classBelongsMapper;
	@Override
	public void saveClassBelongs(ClassBelongs classBelongs) {
		classBelongsMapper.insert(classBelongs);
	}
	@Override
	public void updateClassBelogs(ClassBelongs classBelongs) {
		classBelongsMapper.updateByPrimaryKey(classBelongs);
	}
	@Override
	public ClassBelongs selectClassBelongsByClassId(Long classId) {
		return classBelongsMapper.selectClassBelongsByClassId(classId);
	}

	@Override
	public List<CommunityTrainView> queryCommunityTrains(
			CommunityTrainView communityTrainView) {
		return classBelongsMapper.queryCommunityTarins(communityTrainView);
	}
	
	@Override
	public List<CommunityCourseView> queryCommunityCourses(
			CommunityCourseView communityCourseView) {
		return classBelongsMapper.queryCommunityCourses(communityCourseView);
	}
	@Override
	public List<DataStatsView> classBelongsDataStats(DataStatsView dataStatsView) {
		return classBelongsMapper.classBelongsDataStats(dataStatsView);
	}
	@Override
	public void batchUpdateStatus(long[] ids,int status) {
		if(ids.length<=0){
			 return;
		}
		for(int i=0;i<ids.length;i++){
			classBelongsMapper.updateStatus(ids[i], status);
		}
	}
	@Override
	public int queryCommunityCoursesTotal(
			CommunityCourseView communityCourseView) {
		return classBelongsMapper.queryCommunityCoursesTotal(communityCourseView);
	}
	@Override
	public int queryCommunityTrainsTotal(
			CommunityTrainView communityTrainView) {
		return classBelongsMapper.queryCommunityTarinsTotal(communityTrainView);
	}
}
