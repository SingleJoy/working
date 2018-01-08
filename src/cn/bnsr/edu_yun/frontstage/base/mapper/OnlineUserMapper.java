package cn.bnsr.edu_yun.frontstage.base.mapper;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.frontstage.base.po.OnlineUser;

public interface OnlineUserMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table online_user
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	int deleteByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table online_user
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	int insert(OnlineUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table online_user
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	int insertSelective(OnlineUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table online_user
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	OnlineUser selectByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table online_user
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	int updateByPrimaryKeySelective(OnlineUser record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table online_user
	 * @mbggenerated  Mon Oct 23 16:51:54 CST 2017
	 */
	int updateByPrimaryKey(OnlineUser record);
	
	/**
	 * 
	 * 查询平均同时在线人数、在线峰值
	 * @param condition
	 * @return
	 */
	List<UserStatsView> queryAvgOnline(UserStatsView condition);
	
}