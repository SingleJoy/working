package cn.bnsr.edu_yun.backstage.resource.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.resource.view.BackFileView;
import cn.bnsr.edu_yun.backstage.resource.view.FileDetailView;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;

public interface BackFileService {
	public DataGrid datagrid(BackFileView backFileView);

	public void save(BackFileView backFileView);

	public void update(BackFileView backFileView);

	public void delete(String ids);

	public void saveReviewFile(BackFileView backFileView);

	/**根据文件id查询文档详细*/
	public FileDetailView queryFileDetail(String id);
	
	public List<File_base> selectByBack(String str,String sort,String order,long start,long pageSize);
}
