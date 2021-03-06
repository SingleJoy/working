package cn.bnsr.edu_yun.frontstage.train.service;

import java.text.ParseException;
import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.frontstage.train.po.Community;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityView;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;

public interface CommunityService {

	void saveCommunity(Community community);
	
	void saveCommunityBackstage(Community community);

	/**查询社区list*/
	List<CommunityView> queryCommunity(CommunityView CommunityView);
	
	/**通过社区id查询社区信息*/
	CommunityView getById(Long id);

	void updateCommunity(Community community);
	
	int queryTotalCommunity(CommunityView communityView);
	
	/**查询数据统计*/
	List<DataStatsView> queryDataStats(DataStatsView dataStatsView) throws ParseException;
	
	/* 查询社区列表 */
	List<Community> queryCommunitys();
	
	/*
	 * 后台
	 */
	DataGrid datagrid(CommunityView communityView);
	Long getMaxSeq();
}
