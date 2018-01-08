package cn.bnsr.edu_yun.frontstage.resource.mapper;

import java.util.List;

import cn.bnsr.edu_yun.backstage.resource.view.AmountView;
import cn.bnsr.edu_yun.frontstage.resource.po.FileAmount;

public interface FileAmountMapper {
    /**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table file_amount
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	int deleteByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table file_amount
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	int insert(FileAmount record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table file_amount
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	int insertSelective(FileAmount record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table file_amount
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	FileAmount selectByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table file_amount
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	int updateByPrimaryKeySelective(FileAmount record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table file_amount
	 * @mbggenerated  Tue Oct 18 14:28:06 CST 2016
	 */
	int updateByPrimaryKey(FileAmount record);

	public List<FileAmount> find(AmountView amountView);

	public Long count(AmountView amountView);

	List<FileAmount> findAllAmount();
}