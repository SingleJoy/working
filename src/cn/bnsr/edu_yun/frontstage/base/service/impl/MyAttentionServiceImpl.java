package cn.bnsr.edu_yun.frontstage.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.MyAttentionMapper;
import cn.bnsr.edu_yun.frontstage.base.service.MyAttentionService;
import cn.bnsr.edu_yun.frontstage.base.view.MyAttentionView;

public class MyAttentionServiceImpl implements MyAttentionService{
	@Autowired
	private MyAttentionMapper mapper;

	@Override
	public MyAttentionView showMyAttenation(MyAttentionView myAttentionView) {
		// TODO Auto-generated method stub
		return mapper.showMyAttenation(myAttentionView);
	}

	@Override
	public MyAttentionView showMyFans(MyAttentionView myAttentionView) {
		// TODO Auto-generated method stub
		return mapper.showMyFans(myAttentionView);
	}

	@Override
	public int showMyAttenationCount(MyAttentionView myAttentionView) {
		// TODO Auto-generated method stub
		return mapper.showMyAttenationCount(myAttentionView);
	}

	@Override
	public int showMyFansCount(MyAttentionView myAttentionView) {
		// TODO Auto-generated method stub
		return mapper.showMyFansCount(myAttentionView);
	}

}
