package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.MyContributionMapper;
import cn.bnsr.edu_yun.frontstage.base.service.MyContributionService;
import cn.bnsr.edu_yun.frontstage.base.view.MyContributionView;

public class MyContributionServiceImpl implements MyContributionService{
	@Autowired
	private MyContributionMapper myContributionMapper;

	@Override
	public List<MyContributionView> showMyContribution(MyContributionView myContributionView) {
		// TODO Auto-generated method stub
		return myContributionMapper.showMyContribution(myContributionView);
	}

	@Override
	public int queryTotalContribution(MyContributionView myContributionView) {
		// TODO Auto-generated method stub
		return myContributionMapper.queryTotalContribution(myContributionView);
	}

	

}
