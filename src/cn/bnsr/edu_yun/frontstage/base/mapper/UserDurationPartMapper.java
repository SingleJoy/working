package cn.bnsr.edu_yun.frontstage.base.mapper;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.frontstage.base.po.UserDurationPart;

public interface UserDurationPartMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table user_duration_part
	 * @mbggenerated  Fri Oct 13 17:04:05 CST 2017
	 */
	int deleteByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table user_duration_part
	 * @mbggenerated  Fri Oct 13 17:04:05 CST 2017
	 */
	int insert(UserDurationPart record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table user_duration_part
	 * @mbggenerated  Fri Oct 13 17:04:05 CST 2017
	 */
	int insertSelective(UserDurationPart record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table user_duration_part
	 * @mbggenerated  Fri Oct 13 17:04:05 CST 2017
	 */
	UserDurationPart selectByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table user_duration_part
	 * @mbggenerated  Fri Oct 13 17:04:05 CST 2017
	 */
	int updateByPrimaryKeySelective(UserDurationPart record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table user_duration_part
	 * @mbggenerated  Fri Oct 13 17:04:05 CST 2017
	 */
	int updateByPrimaryKey(UserDurationPart record);
	
	
	List<UserStatsView> queryActiveStats(UserStatsView condition);
}