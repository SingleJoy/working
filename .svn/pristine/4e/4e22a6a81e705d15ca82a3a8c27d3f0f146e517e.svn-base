package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.User_attentMapper;
import cn.bnsr.edu_yun.frontstage.base.po.User_attent;
import cn.bnsr.edu_yun.frontstage.base.service.UserAttentService;

public class UserAttentServiceImpl implements UserAttentService {

	@Autowired 
	private User_attentMapper userAttentMapper;
	
	@Override
	public int insert(User_attent userAttent) {
		
		return userAttentMapper.insertSelective(userAttent);
	}

	@Override
	public User_attent selectattent(long user_id, long attent_user_id) {
		// TODO Auto-generated method stub
		return userAttentMapper.selectattent(user_id, attent_user_id);
	}

	@Override
	public List<User_attent> myAttenation(User_attent userAttent) {
		// TODO Auto-generated method stub
		return userAttentMapper.myAttenation(userAttent);
	}

	@Override
	public List<User_attent> myFans(User_attent userAttent) {
		// TODO Auto-generated method stub
		return userAttentMapper.myFans(userAttent);
	}

	@Override
	public int delete(long id) {
		// TODO Auto-generated method stub
		return userAttentMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int queryTotalAttention(long userId) {
		// TODO Auto-generated method stub
		return userAttentMapper.queryTotalAttention(userId);
	}

	@Override
	public int queryTotalFans(long userId) {
		// TODO Auto-generated method stub
		return userAttentMapper.queryTotalFans(userId);
	}

	@Override
	public User_attent selectById(Long UserId) {
		// TODO Auto-generated method stub
		return userAttentMapper.selectByPrimaryKey(UserId);
	}

}
