package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.StudentRelationMapper;
import cn.bnsr.edu_yun.frontstage.train.po.StudentRelation;
import cn.bnsr.edu_yun.frontstage.train.service.StudentRelationService;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;
import cn.bnsr.edu_yun.frontstage.train.view.StudentRelationView;

public class StudentRelationServiceImpl implements StudentRelationService {

	@Autowired
	private StudentRelationMapper studentRelationMapper;
	
	@Override
	public Integer countStudent(StudentRelationView student) {
		// TODO Auto-generated method stub
		return studentRelationMapper.countStudent(student);
	}

	@Override
	public void saveStudentRelation(StudentRelation student) {
		student.setCreate_time(new Date());
		studentRelationMapper.insertSelective(student);
		
	}

	@Override
	public void updateStudentRelation(StudentRelation student) {
		studentRelationMapper.updateByPrimaryKeySelective(student);
		
	}

	@Override
	public List<StudentRelationView> findAll(StudentRelationView student) {
		// TODO Auto-generated method stub
		return studentRelationMapper.findAll(student);
	}

	@Override
	public void delStudentRelation(Long id) {
		studentRelationMapper.deleteByPrimaryKey(id);
		
	}

	@Override
	public List<DataStatsView> studentDataStats(DataStatsView dataStatsView) {
		return studentRelationMapper.studentDataStats(dataStatsView);
	}
	
	@Override
	public List<StudentRelationView> exportStudent(Long source_id, Integer source_type,String ids) {
		return studentRelationMapper.exportStudent(source_id, source_type,ids);
	}

	@Override
	public void quitStudent(String source_id, String source_type,Long user_id) {
		studentRelationMapper.quitStudent(source_id,source_type,user_id);	
	}

	@Override
	public List<StudentRelationView> findWorkUSer(Long source_id) {
		
		return studentRelationMapper.findWorkUser(source_id);
	}

	@Override
	public List<StudentRelationView> findWorkExpert(Long source_id) {
		// TODO Auto-generated method stub
		return studentRelationMapper.findWorkExpert(source_id);
	}

	@Override
	public void clearStudent(Long source_id, int source_type, int role_type) {
		studentRelationMapper.clearStudent(source_id, source_type, role_type);
		
	}

	@Override
	public String getStuNames(Long source_id, int source_type, int role_type) {
		// TODO Auto-generated method stub
		return studentRelationMapper.getStuNames(source_id, source_type, role_type);
	}

	@Override
	public String getStuIds(Long source_id, int source_type, int role_type) {
		// TODO Auto-generated method stub
		return studentRelationMapper.getStuIds(source_id, source_type, role_type);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
