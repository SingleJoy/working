package cn.bnsr.edu_yun.frontstage.base.service;

import cn.bnsr.edu_yun.frontstage.base.view.MySettingView;

public interface MySettingService {
	public MySettingView showMySetting(Long userId);
	public int updateMySetting(MySettingView settingView);
}
