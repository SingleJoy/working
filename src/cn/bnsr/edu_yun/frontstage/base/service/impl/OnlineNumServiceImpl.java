package cn.bnsr.edu_yun.frontstage.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.OnlineNumMapper;
import cn.bnsr.edu_yun.frontstage.base.po.OnlineNum;
import cn.bnsr.edu_yun.frontstage.base.service.OnlineNumService;

public class OnlineNumServiceImpl implements OnlineNumService {

	@Autowired
	private OnlineNumMapper onlineNumMapper;
	
	@Override
	public void insert(OnlineNum record) {
		onlineNumMapper.insertSelective(record);
	}

}
