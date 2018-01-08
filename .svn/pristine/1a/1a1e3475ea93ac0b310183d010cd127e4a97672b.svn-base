package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.UserDiscussMapper;
import cn.bnsr.edu_yun.frontstage.train.po.UserDiscuss;
import cn.bnsr.edu_yun.frontstage.train.service.UserDiscussService;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.UserDiscussView;

public class UserDiscussServiceImpl implements UserDiscussService {
	
	@Autowired
	private UserDiscussMapper userDiscussMapper;


	@Override
	public int insertDiscuss(UserDiscuss userDiscuss) {
		
		return userDiscussMapper.insertSelective(userDiscuss);
	}

	@Override
	public List<UserDiscussView> queryDiscuss(UserDiscussView userDiscussView) {
		
		return userDiscussMapper.queryDiscuss(userDiscussView);
	}
	@Override
	public List<UserDiscussView> queryClassDiscuss(UserDiscussView userDiscussView) {
		
		return userDiscussMapper.queryClassDiscuss(userDiscussView);
	}
	@Override
	public int countClassDiscuss(UserDiscussView userDiscussView) {
		
		return userDiscussMapper.countClassDiscuss(userDiscussView);
	}


	@Override
	public int countUserDiscuss(UserDiscuss userDiscuss) {
		
		return userDiscussMapper.countUserDiscuss(userDiscuss);
	}

	@Override
	public int countClassHomeDiscuss(ClassView record) {
		// TODO Auto-generated method stub
		return userDiscussMapper.countClassHomeDiscuss(record);
	}


	

}
