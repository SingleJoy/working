package cn.bnsr.edu_yun.frontstage.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.DefaultUserSetView;
import cn.bnsr.edu_yun.frontstage.base.mapper.DefaultVarcharMapper;
import cn.bnsr.edu_yun.frontstage.base.po.DefaultVarchar;
import cn.bnsr.edu_yun.frontstage.base.service.DefaultVarcharService;

public class DefaultVarcharServiceImpl implements DefaultVarcharService {

	
	@Autowired
	private DefaultVarcharMapper defaultVarcharMapper;
	@Override
	public DefaultVarchar selectTheOne(Long id) {
		return defaultVarcharMapper.selectByPrimaryKey(id);
	}

	@Override
	public DefaultUserSetView queryOne(DefaultUserSetView condition) {
		return defaultVarcharMapper.queryOne(condition);
	}

	@Override
	public void update(DefaultVarchar record) {
		defaultVarcharMapper.updateByPrimaryKeySelective(record);
	}

}
