package cn.bnsr.edu_yun.backstage.base.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.mapper.SysLogMapper;
import cn.bnsr.edu_yun.backstage.base.po.SysLog;
import cn.bnsr.edu_yun.backstage.base.service.SysLogService;
import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.SysLogView;
import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;
import cn.bnsr.edu_yun.util.NumUtil;

public class SysLogServiceImpl implements SysLogService{
	@Autowired 
	private SysLogMapper sysLogMapper;

	@Override
	public void saveSysLog(SysLog syslog) {
		sysLogMapper.insertSelective(syslog);
	}

	@Override
	public DataGrid datagrid(SysLogView sysLogView){
		DataGrid j = new DataGrid();
		sysLogView.setPage(NumUtil.startingNum(sysLogView.getPage(),sysLogView.getRows()));
		j.setRows(changeModel(find(sysLogView)));
		j.setTotal(total(sysLogView));
		return j;
	}

	private List<SysLogView> changeModel(List<SysLog> sysLogList) {
		List<SysLogView> users = new ArrayList<SysLogView>();
		if (sysLogList != null && sysLogList.size() > 0) {
			for (SysLog syslog : sysLogList) {
				SysLogView slv = new SysLogView();
				BeanUtils.copyProperties(syslog, slv);
				users.add(slv);
			}
		}
		return users;
	}

	private List<SysLog> find(SysLogView sysLogView) {
		return sysLogMapper.find(sysLogView);
	}

	private Long total(SysLogView sysLogView) {
		return sysLogMapper.count(sysLogView);
	}

	@Override
	public List<DataStatsView> dataStats(DataStatsView dataStatsView) {
		return sysLogMapper.dataStats(dataStatsView);
	}

	@Override
	public Long countAddUser(UserStatsView userStats) {
		// TODO Auto-generated method stub
		return sysLogMapper.countAddUser(userStats);
	}

	@Override
	public Long countLoginUser(UserStatsView userStats) {
		// TODO Auto-generated method stub
		return sysLogMapper.countLoginUser(userStats);
	}

	
}
