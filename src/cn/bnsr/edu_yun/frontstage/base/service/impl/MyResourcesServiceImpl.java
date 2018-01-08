package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.MyResourcesMapper;
import cn.bnsr.edu_yun.frontstage.base.service.MyResourcesService;
import cn.bnsr.edu_yun.frontstage.base.view.MyResourcesView;

public class MyResourcesServiceImpl implements MyResourcesService{
	@Autowired
	private MyResourcesMapper mapper;

	@Override
	public List<MyResourcesView> showMyResources(MyResourcesView myResourcesView) {
		// TODO Auto-generated method stub
		return mapper.showMyResources(myResourcesView);
	}

	@Override
	public int queryTotalResources(MyResourcesView myResourcesView) {
		// TODO Auto-generated method stub
		return mapper.queryTotalResources(myResourcesView);
	}

}
