package cn.bnsr.edu_yun.frontstage.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.UserDurationPartMapper;
import cn.bnsr.edu_yun.frontstage.base.po.UserDurationPart;
import cn.bnsr.edu_yun.frontstage.base.service.UserDurationPartService;

public class UserDurationPartServiceImpl implements UserDurationPartService {

	@Autowired
	private UserDurationPartMapper userDurationPartMapper;
	@Override
	public void insert(UserDurationPart record) {
		userDurationPartMapper.insertSelective(record);
	}

}
