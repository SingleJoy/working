package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.resource.po.User_file;
import cn.bnsr.edu_yun.frontstage.resource.view.RankView;
import cn.bnsr.edu_yun.frontstage.resource.view.ResouceFileView;

public interface UserFileService {

	public int insert(User_file userFile);
	public User_file selectFile(long user_id,long file_id);
	public User_file selectBuyFile(long user_id,long file_id);
	public int delete(long file_id);
	public List<User_file> selectFileByUser(Long userId);
	
	public List<RankView> queryRankFile();
	/**
	 * 用户文件
	 */
	public List<ResouceFileView> queryUserFile(ResouceFileView resouceFileView);
	public int queryTotalUserFile(ResouceFileView resouceFileView);
}
