package cn.bnsr.edu_yun.frontstage.base.mapper;

import cn.bnsr.edu_yun.frontstage.base.view.MySettingView;

/**
 * 我的设置的mapper
 * @author apple
 *
 */
public interface MySettingMapper {
	public MySettingView showMySetting(Long userId);
	public int updateMySetting(MySettingView mySettingView);

}
