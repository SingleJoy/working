package cn.bnsr.edu_yun.frontstage.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.UserPropertyMapper;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.service.UserPropertyService;

public class UserPropertyServiceImpl implements UserPropertyService{
	@Autowired
	private UserPropertyMapper mapper;

	@Override
	public UserProperty showUserProperty(Long id) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateUserProperty(UserProperty userProperty) {
		// TODO Auto-generated method stub
		return mapper.updateByPrimaryKeySelective(userProperty);
	}

}
