package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.frontstage.base.mapper.OnlineUserMapper;
import cn.bnsr.edu_yun.frontstage.base.po.OnlineUser;
import cn.bnsr.edu_yun.frontstage.base.service.OnlineUserService;

public class OnlineUserServiceImpl implements OnlineUserService {

	@Autowired
	private OnlineUserMapper onlineUserMapper;
	
	@Override
	public void insert(OnlineUser record) {
		onlineUserMapper.insertSelective(record);
	}

}
