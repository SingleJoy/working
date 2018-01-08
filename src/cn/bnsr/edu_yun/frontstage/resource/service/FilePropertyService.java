package cn.bnsr.edu_yun.frontstage.resource.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.resource.po.File_property;
import cn.bnsr.edu_yun.frontstage.resource.view.FileView;

public interface FilePropertyService {

	public int insert(File_property property);
	
	public int update(File_property property);
	
	/**根据附加属性ids查询用户所有文件下载、浏览量*/
	public FileView queryCount(List<String> proIds);

	/**获取综合评分*/
	public double querScoreNum(Long userId);


}
