package cn.bnsr.edu_yun.frontstage.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.IpInterceptMapper;
import cn.bnsr.edu_yun.frontstage.base.po.IpIntercept;
import cn.bnsr.edu_yun.frontstage.base.service.IpInterceptService;
import cn.bnsr.edu_yun.frontstage.base.view.IpIntercepterView;

public class IpInterceptServiceImpl implements IpInterceptService {

	@Autowired
	private IpInterceptMapper ipInterceptServiceMapper;
	
	@Override
	public IpIntercept queryIpInfoByIp(IpIntercepterView condition) {
		return ipInterceptServiceMapper.queryIpInfoByIp(condition);
	}

	@Override
	public void insert(IpIntercept record) {
		ipInterceptServiceMapper.insertSelective(record);
		
	}

	@Override
	public void deleteAll() {
		ipInterceptServiceMapper.deleteAll();
	}

}
