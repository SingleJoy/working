package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.PubverListMapper;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.service.PubverListService;

public class PubverListServiceImpl implements PubverListService{
	@Autowired
	private PubverListMapper pubverListMapper;
	
	
	@Override
	public List<PubverList> queryPubver(String pubId) {
		return pubverListMapper.queryPubver(pubId);
	}


	@Override
	public PubverList selectByPubverListId(String id) {
		// TODO Auto-generated method stub
		return pubverListMapper.selectByPubverListId(id);
	}


	@Override
	public PubverList selectById(String id) {
		// TODO Auto-generated method stub
		return pubverListMapper.selectByPrimaryKey(id);
	}

}
