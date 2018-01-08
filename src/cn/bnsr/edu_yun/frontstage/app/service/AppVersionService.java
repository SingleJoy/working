package cn.bnsr.edu_yun.frontstage.app.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.PageBase;
import cn.bnsr.edu_yun.frontstage.app.po.AppVersion;

public interface AppVersionService {

	 AppVersion selectNew();
	 
	 int insert(AppVersion appVersion);
	 
	 List<AppVersion> selectAll(PageBase pageBase);
	 
	 long selectCount();

	DataGrid datagrid(PageBase pageBase);
}
