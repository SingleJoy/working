package cn.bnsr.edu_yun.frontstage.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.UserSupportMapper;
import cn.bnsr.edu_yun.frontstage.base.po.UserSupport;
import cn.bnsr.edu_yun.frontstage.base.service.UserSupportService;

public class UserSupportServiceImpl implements UserSupportService{
	@Autowired
	private UserSupportMapper mapper;

	@Override
	public int insertSupport(UserSupport userSupport) {
		// TODO Auto-generated method stub
		return mapper.insert(userSupport);
	}

	@Override
	public int deleteSupport(UserSupport userSupport) {
		// TODO Auto-generated method stub
		return mapper.updateByPrimaryKeySelective(userSupport);
	}

	@Override
	public UserSupport showSupport(UserSupport userSupport) {
		// TODO Auto-generated method stub
		return mapper.showUserSupport(userSupport);
	}

}
