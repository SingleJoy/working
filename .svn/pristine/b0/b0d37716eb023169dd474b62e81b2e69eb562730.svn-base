package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.MyCollectMapper;
import cn.bnsr.edu_yun.frontstage.base.service.MyCollectService;
import cn.bnsr.edu_yun.frontstage.base.view.MyCollectView;

public class MyCollectServiceImpl implements MyCollectService{
	@Autowired
	private MyCollectMapper mapper;

	@Override
	public List<MyCollectView> showCollert(MyCollectView model) {
		// TODO Auto-generated method stub
		return mapper.showCollert(model);
	}

	@Override
	public int queryTotalContribution(MyCollectView myCollectView) {
		// TODO Auto-generated method stub
		return mapper.queryTotalContribution(myCollectView);
	}

}
