package cn.bnsr.edu_yun.backstage.base.service;

import java.text.ParseException;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.UserLogView;

public interface UserLogService {
	
	public DataGrid datagrid(UserLogView userLogView) throws ParseException;

}
