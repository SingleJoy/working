package cn.bnsr.edu_yun.frontstage.train.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.CourseHourFile;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourFileView;

public interface CourseHourFileMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_hour_file
	 * @mbggenerated  Wed Nov 09 10:51:11 CST 2016
	 */
	int deleteByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_hour_file
	 * @mbggenerated  Wed Nov 09 10:51:11 CST 2016
	 */
	int insert(CourseHourFile record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_hour_file
	 * @mbggenerated  Wed Nov 09 10:51:11 CST 2016
	 */
	int insertSelective(CourseHourFile record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_hour_file
	 * @mbggenerated  Wed Nov 09 10:51:11 CST 2016
	 */
	CourseHourFile selectByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_hour_file
	 * @mbggenerated  Wed Nov 09 10:51:11 CST 2016
	 */
	int updateByPrimaryKeySelective(CourseHourFile record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_hour_file
	 * @mbggenerated  Wed Nov 09 10:51:11 CST 2016
	 */
	int updateByPrimaryKey(CourseHourFile record);

	List<CourseHourFileView> getHourFile(String hourId);

	void deleteByHourId(String hourId);
	
}