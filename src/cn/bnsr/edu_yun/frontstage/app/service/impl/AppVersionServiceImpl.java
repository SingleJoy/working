package cn.bnsr.edu_yun.frontstage.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.PageBase;
import cn.bnsr.edu_yun.frontstage.app.mapper.AppVersionMapper;
import cn.bnsr.edu_yun.frontstage.app.po.AppVersion;
import cn.bnsr.edu_yun.frontstage.app.service.AppVersionService;
import cn.bnsr.edu_yun.util.NumUtil;

public class AppVersionServiceImpl implements AppVersionService{
	
	@Autowired
	private AppVersionMapper appVersionMapper;

	@Override
	public AppVersion selectNew() {
		
		return appVersionMapper.selectNew();
	}

	@Override
	public int insert(AppVersion appVersion) {
		
		return appVersionMapper.insert(appVersion);
	}

	@Override
	public List<AppVersion> selectAll(PageBase pageBase) {
		
		return appVersionMapper.selectAll(pageBase);
	}

	@Override
	public long selectCount() {
		
		return appVersionMapper.selectCount();
	}

	@Override
	public DataGrid datagrid(PageBase pageBase) {
		DataGrid j = new DataGrid();
		pageBase.setPage(NumUtil.startingNum(pageBase.getPage(), pageBase.getRows()));
		j.setRows(selectAll(pageBase));
		j.setTotal(selectCount());
		return j;
	}

}
