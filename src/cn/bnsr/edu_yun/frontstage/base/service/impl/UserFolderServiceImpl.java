package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.User_folderMapper;
import cn.bnsr.edu_yun.frontstage.base.po.User_folder;
import cn.bnsr.edu_yun.frontstage.base.service.UserFolderService;

public class UserFolderServiceImpl implements UserFolderService{
	@Autowired
	private User_folderMapper userfolderMapper;
	
	@Override
	public List<User_folder> findAllUserFolder() {
		return userfolderMapper.findAllUserFolder();
	}

}
