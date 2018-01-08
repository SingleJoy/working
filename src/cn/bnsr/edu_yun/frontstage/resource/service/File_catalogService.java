package cn.bnsr.edu_yun.frontstage.resource.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.resource.po.File_catalog;
import cn.bnsr.edu_yun.frontstage.resource.po.File_label;

public interface File_catalogService {
	public List<File_catalog> selectAnyOne(File_catalog catalog);
	
	/**
	 * 新增编目
	 * @param catalog
	 * @return
	 */
	public int insert(File_catalog catalog);
	/**
	 * 新增label
	 * @param file_label
	 * @return
	 */
	public int insertLabel(File_label file_label);
	/**
	 * 按主键查询
	 * @param id
	 * @return catalog
	 */
	public File_catalog selectById(long id);

	public int update(File_catalog catalog);
}
