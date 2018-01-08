package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.User_business_logMapper;
import cn.bnsr.edu_yun.frontstage.base.po.User_business_log;
import cn.bnsr.edu_yun.frontstage.base.service.BusinessLogService;

public class BusinessLogServiceImpl implements BusinessLogService {

	@Autowired 
	private User_business_logMapper userBusinessLogMapper;
	@Override
	public List<User_business_log> selectScoreByUserId(long user_id, long start,
			long pageSize) {
		
		return userBusinessLogMapper.selectScoreByUserId(user_id, start, pageSize);
	}
	@Override
	public List<User_business_log> selectWealthByUserId(long user_id,
			long start, long pageSize) {
		// TODO Auto-generated method stub
		return userBusinessLogMapper.selectWealthByUserId(user_id, start, pageSize);
	}
	@Override
	public int deleteScore(long id) {
		// TODO Auto-generated method stub
		return userBusinessLogMapper.deleteByPrimaryKey(id);
	}
	@Override
	public int insert(User_business_log log) {
		// TODO Auto-generated method stub
		return userBusinessLogMapper.insertSelective(log);
	}
	@Override
	public List<User_business_log> selectWealthByUserIdCount(long user_id) {
		// TODO Auto-generated method stub
		return userBusinessLogMapper.selectWealthByUserIdCount(user_id);
	}
	@Override
	public List<User_business_log> selectScoreByUserIdCount(long user_id) {
		// TODO Auto-generated method stub
		return userBusinessLogMapper.selectScoreByUserIdCount(user_id);
	}

}
