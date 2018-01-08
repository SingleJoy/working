package cn.bnsr.edu_yun.frontstage.train.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.bnsr.edu_yun.frontstage.train.po.CommunityRelation;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityRelationView;

public interface CommunityRelationMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table community_relation
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	int deleteByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table community_relation
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	int insert(CommunityRelation record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table community_relation
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	int insertSelective(CommunityRelation record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table community_relation
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	CommunityRelation selectByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table community_relation
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	int updateByPrimaryKeySelective(CommunityRelation record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table community_relation
	 * @mbggenerated  Thu May 18 14:51:32 CST 2017
	 */
	int updateByPrimaryKey(CommunityRelation record);

	List<CommunityRelationView> searchSubjects(@Param("communityId") Long communityId);

	void deleteByCommunityId(@Param("communityId")Long communityId);
}