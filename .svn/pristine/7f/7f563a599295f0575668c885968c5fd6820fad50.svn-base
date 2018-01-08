package cn.bnsr.edu_yun.frontstage.resource.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.resource.mapper.User_file_logMapper;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file_log;
import cn.bnsr.edu_yun.frontstage.resource.service.LogService;

public class LogServiceImpl implements LogService {
	@Autowired
	private User_file_logMapper userFileLogMapper;
	@Override
	public int insertUserFileLog(User_file_log userFileLog) {
		// TODO Auto-generated method stub
		return userFileLogMapper.insertSelective(userFileLog);
	}
	@Override
	public List<User_file_log> selectByUserId(String str, long user_id) {
		// TODO Auto-generated method stub
		return userFileLogMapper.selectByUserId(str, user_id);
	}
	@Override
	public List<Long> selectDistinctUser(String str) {
		// TODO Auto-generated method stub
		return userFileLogMapper.selectDistinctUser(str);
	}

}
