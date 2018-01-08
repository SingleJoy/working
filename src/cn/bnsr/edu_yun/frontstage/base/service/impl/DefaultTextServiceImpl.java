package cn.bnsr.edu_yun.frontstage.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.DefaultUserSetView;
import cn.bnsr.edu_yun.frontstage.base.mapper.DefaultTextMapper;
import cn.bnsr.edu_yun.frontstage.base.po.DefaultText;
import cn.bnsr.edu_yun.frontstage.base.service.DefaultTextService;

public class DefaultTextServiceImpl implements DefaultTextService {

	@Autowired
	private DefaultTextMapper defaultTextMapper;

	@Override
	public DefaultText selectTheOne(Long id) {
		return defaultTextMapper.selectByPrimaryKey(id);
	}

	@Override
	public DefaultUserSetView queryOne(DefaultUserSetView record) {
		return defaultTextMapper.queryOne(record);
	}

	@Override
	public void update(DefaultText record) {
		defaultTextMapper.updateByPrimaryKeySelective(record);
		
	}

}
