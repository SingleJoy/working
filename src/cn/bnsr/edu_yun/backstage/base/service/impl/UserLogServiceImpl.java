package cn.bnsr.edu_yun.backstage.base.service.impl;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.mapper.SysLogMapper;
import cn.bnsr.edu_yun.backstage.base.service.UserLogService;
import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.UserLogView;
import cn.bnsr.edu_yun.util.AddressUtils;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.TimeUtil;

public class UserLogServiceImpl implements UserLogService {

	@Autowired
	private SysLogMapper sysLogMapper;
	
	@Override
	public DataGrid datagrid(UserLogView userLogView) throws ParseException {
		DataGrid j = new DataGrid();
		userLogView.setPage(NumUtil.startingNum(userLogView.getPage(),userLogView.getRows()));
		j.setRows(searchUserLog(userLogView));
		j.setTotal(countUserLog(userLogView));
		return j;
	}
	
	public List<UserLogView> searchUserLog(UserLogView userLogView) throws ParseException{
		String timeEnd = userLogView.getTimeEnd();
		if(timeEnd!=null&&timeEnd!=""){
			userLogView.setTimeEnd(TimeUtil.afterNDay(timeEnd, 1));
		}
		return sysLogMapper.searchUserLog(userLogView);
	}
	
	public Long countUserLog(UserLogView userLogView){
		return sysLogMapper.countUserLog(userLogView);
	}

}
