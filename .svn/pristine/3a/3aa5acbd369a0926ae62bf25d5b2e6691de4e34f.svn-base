package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.service.UserFileService;
import cn.bnsr.edu_yun.frontstage.resource.mapper.User_fileMapper;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file;
import cn.bnsr.edu_yun.frontstage.resource.view.RankView;
import cn.bnsr.edu_yun.frontstage.resource.view.ResouceFileView;

public class UserFileServiceImpl implements UserFileService{

	@Autowired 
	private User_fileMapper userFileMapper;
	
	@Override
	public int insert(User_file userFile) {
		// TODO Auto-generated method stub
		return userFileMapper.insertSelective(userFile);
	}

	@Override
	public User_file selectFile(long user_id, long file_id) {
		// TODO Auto-generated method stub
		return userFileMapper.selectFile(user_id, file_id);
	}

	@Override
	public int delete(long file_id) {
		// TODO Auto-generated method stub
		return userFileMapper.deleteByPrimaryKey(file_id);
	}

	@Override
	public List<User_file> selectFileByUser(Long userId) {
		// TODO Auto-generated method stub
		return userFileMapper.selectFileByUser(userId);
	}

	@Override
	public User_file selectBuyFile(long user_id, long file_id) {
		// TODO Auto-generated method stub
		return userFileMapper.selectBuyFile(user_id, file_id);
	}

	@Override
	public List<RankView> queryRankFile() {
		return userFileMapper.queryRankFile();
	}

	@Override
	public List<ResouceFileView> queryUserFile(ResouceFileView resouceFileView) {
		return userFileMapper.queryUserFile(resouceFileView);
	}

	@Override
	public int queryTotalUserFile(ResouceFileView resouceFileView) {
		return userFileMapper.queryTotalUserFile(resouceFileView);
	}

}
