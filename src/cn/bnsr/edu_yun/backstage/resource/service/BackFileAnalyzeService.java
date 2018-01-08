package cn.bnsr.edu_yun.backstage.resource.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.resource.view.BackFileView;
import cn.bnsr.edu_yun.backstage.resource.view.FileStatsView;

public interface BackFileAnalyzeService {
	
	DataGrid datagrid(BackFileView backFileView);
	
	List<FileStatsView> queryfileTrend(FileStatsView fileStatsView) throws Exception;
	
	List<FileStatsView> queryFileRanking(FileStatsView fileStats);

}
