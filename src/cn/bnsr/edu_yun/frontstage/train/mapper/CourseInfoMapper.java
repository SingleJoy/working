package cn.bnsr.edu_yun.frontstage.train.mapper;

import cn.bnsr.edu_yun.frontstage.train.po.CourseInfo;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;

public interface CourseInfoMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_info
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	int deleteByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_info
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	int insert(CourseInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_info
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	int insertSelective(CourseInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_info
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	CourseInfo selectByPrimaryKey(Long id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_info
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	int updateByPrimaryKeySelective(CourseInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_info
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	int updateByPrimaryKeyWithBLOBs(CourseInfo record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table course_info
	 * @mbggenerated  Fri Oct 28 15:52:36 CST 2016
	 */
	int updateByPrimaryKey(CourseInfo record);

	CourseView queryCourseDetail(Long courseId);

	int getMaxSeq();

}