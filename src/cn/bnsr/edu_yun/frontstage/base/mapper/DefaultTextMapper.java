package cn.bnsr.edu_yun.frontstage.base.mapper;

import cn.bnsr.edu_yun.backstage.base.view.DefaultUserSetView;
import cn.bnsr.edu_yun.frontstage.base.po.DefaultText;

public interface DefaultTextMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table default_text
	 * @mbggenerated  Thu Sep 14 16:33:16 CST 2017
	 */
	int deleteByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table default_text
	 * @mbggenerated  Thu Sep 14 16:33:16 CST 2017
	 */
	int insert(DefaultText record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table default_text
	 * @mbggenerated  Thu Sep 14 16:33:16 CST 2017
	 */
	int insertSelective(DefaultText record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table default_text
	 * @mbggenerated  Thu Sep 14 16:33:16 CST 2017
	 */
	DefaultText selectByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table default_text
	 * @mbggenerated  Thu Sep 14 16:33:16 CST 2017
	 */
	int updateByPrimaryKeySelective(DefaultText record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table default_text
	 * @mbggenerated  Thu Sep 14 16:33:16 CST 2017
	 */
	int updateByPrimaryKeyWithBLOBs(DefaultText record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table default_text
	 * @mbggenerated  Thu Sep 14 16:33:16 CST 2017
	 */
	int updateByPrimaryKey(DefaultText record);
	
	DefaultUserSetView queryOne(DefaultUserSetView condition);
}