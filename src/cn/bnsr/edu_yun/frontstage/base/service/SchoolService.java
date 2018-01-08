package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.School;

public interface SchoolService {

	int insert(School school);
	List<School> selectByCountyId(String countyId);//按县区id查询学校
	List<School> selectByProvinceId(String provinceId);
	List<School> selectByCityId(String cityId);
	School selectById(Long id);//根据id查询学校信息
	int selectAll(String schoolName,String provinceId,String cityId,String countyId);
	List<School> selectByPage(String schoolName,String provinceId,String cityId,String countyId,long start,long pageSize);
	int update(School school);
	int delete(long id);
}
