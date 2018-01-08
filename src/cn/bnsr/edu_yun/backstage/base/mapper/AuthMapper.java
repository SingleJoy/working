package cn.bnsr.edu_yun.backstage.base.mapper;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.po.Auth;
import cn.bnsr.edu_yun.backstage.base.view.TreeView;

public interface AuthMapper {
    /**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table auth
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	int deleteByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table auth
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	int insert(Auth record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table auth
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	int insertSelective(Auth record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table auth
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	Auth selectByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table auth
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	int updateByPrimaryKeySelective(Auth record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table auth
	 * @mbggenerated  Tue Aug 30 09:06:27 CST 2016
	 */
	int updateByPrimaryKey(Auth record);

	public List<Auth> queryTree(Auth auth);

	public List<TreeView> queryTreeGrid(Auth auth);

	public Long countChildren(String pid);

	public List<Auth> getByUserId(Long userId);
}