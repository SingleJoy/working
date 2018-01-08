package cn.bnsr.edu_yun.backstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.po.SysLog;
import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.SysLogView;
import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;

public interface SysLogService {

	void saveSysLog(SysLog syslog);

	public DataGrid datagrid(SysLogView sysLogView);

	/**数据统计*/
	List<DataStatsView> dataStats(DataStatsView dataStatsView);
	/**统计新增用户数*/
	Long countAddUser(UserStatsView userStats);
	/**统计登录用户数*/
	Long countLoginUser(UserStatsView userStats);

}