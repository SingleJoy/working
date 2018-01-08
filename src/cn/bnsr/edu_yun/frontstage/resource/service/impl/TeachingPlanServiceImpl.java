package cn.bnsr.edu_yun.frontstage.resource.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.resource.mapper.TeachingPlanFileMapper;
import cn.bnsr.edu_yun.frontstage.resource.mapper.TeachingPlanMapper;
import cn.bnsr.edu_yun.frontstage.resource.po.TeachingPlan;
import cn.bnsr.edu_yun.frontstage.resource.po.TeachingPlanFile;
import cn.bnsr.edu_yun.frontstage.resource.service.TeachingPlanService;
import cn.bnsr.edu_yun.frontstage.resource.view.TeachingPlanView;

public class TeachingPlanServiceImpl implements TeachingPlanService{

	@Autowired
	private TeachingPlanMapper teachingPlanMapper;
	@Autowired
	private TeachingPlanFileMapper teachingPlanFileMapper;
	
	@Override
	public int insert(TeachingPlan teachingPlan) {
		
		return teachingPlanMapper.insertSelective(teachingPlan);
	}

	@Override
	public int insertFile(TeachingPlanFile teachingPlanFile) {
		
		return teachingPlanFileMapper.insertSelective(teachingPlanFile);
	}

	@Override
	public TeachingPlan selectById(Long id) {
	
		return teachingPlanMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<TeachingPlanFile> selectByPlanId(Long id) {
		
		return teachingPlanFileMapper.selectByPlanId(id);
	}

	@Override
	public TeachingPlanView queryTeachingPlan(TeachingPlanView teachingPlanView) {
		
		return teachingPlanMapper.queryTeachingPlan(teachingPlanView);
	}

	@Override
	public TeachingPlanFile selectFile(Long id) {
		
		return teachingPlanFileMapper.selectByPrimaryKey(id);
	}

	@Override
	public int update(TeachingPlan teachingPlan) {
		
		return teachingPlanMapper.updateByPrimaryKeySelective(teachingPlan);
	}

	@Override
	public int deletePlanFile(Long id) {
		
		return teachingPlanFileMapper.deleteByPrimaryKey(id);
	}

}
