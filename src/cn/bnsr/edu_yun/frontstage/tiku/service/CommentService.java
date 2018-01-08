package cn.bnsr.edu_yun.frontstage.tiku.service;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.tiku.view.CommentView;

public interface CommentService {

	public DataGrid datagrid(CommentView commentView);
	
	public void save(CommentView commentView);
	
	public void update(CommentView commentView);
	
	public CommentView getByPrimaryKey(Long id);
	
	public void delete(String ids);
	
	
}
