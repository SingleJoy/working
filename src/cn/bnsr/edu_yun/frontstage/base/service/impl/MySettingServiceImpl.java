package cn.bnsr.edu_yun.frontstage.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.MySettingMapper;
import cn.bnsr.edu_yun.frontstage.base.service.MySettingService;
import cn.bnsr.edu_yun.frontstage.base.view.MySettingView;

public class MySettingServiceImpl implements MySettingService{
	@Autowired
	private MySettingMapper mapper;

	@Override
	public MySettingView showMySetting(Long userId) {
		// TODO Auto-generated method stub
		return mapper.showMySetting(userId);
	}

	@Override
	public int updateMySetting(MySettingView settingView) {
		// TODO Auto-generated method stub
		return mapper.updateMySetting(settingView);
	}

}
