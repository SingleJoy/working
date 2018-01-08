package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.SchoolMapper;
import cn.bnsr.edu_yun.frontstage.base.po.School;
import cn.bnsr.edu_yun.frontstage.base.service.SchoolService;

public class SchoolServiceImpl  implements SchoolService{

	@Autowired
	private SchoolMapper mapper;
	@Override
	public int insert(School school) {
		// TODO Auto-generated method stub
		return mapper.insertSelective(school);
	}
	@Override
	public List<School> selectByCountyId(String countyId) {
		// TODO Auto-generated method stub
		return mapper.selectByCountyId(countyId);
	}
	@Override
	public List<School> selectByProvinceId(String provinceId) {
		// TODO Auto-generated method stub
		return mapper.selectByProvinceId(provinceId);
	}
	@Override
	public List<School> selectByCityId(String cityId) {
		// TODO Auto-generated method stub
		return mapper.selectByCityId(cityId);
	}
	@Override
	public School selectById(Long id) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(id);
	}
	@Override
	public int selectAll(String schoolName,String provinceId,String cityId,String countyId) {
		// TODO Auto-generated method stub
		return mapper.selectAll(schoolName,provinceId,cityId,countyId);
	}
	@Override
	public List<School> selectByPage(String schoolName,String provinceId,String cityId,String countyId,long start, long pageSize) {
		// TODO Auto-generated method stub
		return mapper.selectByPage(schoolName,provinceId,cityId,countyId,start, pageSize);
	}
	@Override
	public int update(School school) {
		// TODO Auto-generated method stub
		return mapper.updateByPrimaryKeySelective(school);
	}
	@Override
	public int delete(long id) {
		// TODO Auto-generated method stub
		return mapper.deleteByPrimaryKey(id);
	}

}
