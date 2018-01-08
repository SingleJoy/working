package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.User_business_log;

public interface BusinessLogService {

	  public List<User_business_log> selectScoreByUserId(long user_id,long start,long pageSize);

	  public List<User_business_log> selectWealthByUserId(long user_id,long start,long pageSize);

	  public int deleteScore(long id);
	  
	  int insert(User_business_log log);
	  List<User_business_log>	selectWealthByUserIdCount(long user_id);
	  List<User_business_log>	selectScoreByUserIdCount(long user_id);
}
