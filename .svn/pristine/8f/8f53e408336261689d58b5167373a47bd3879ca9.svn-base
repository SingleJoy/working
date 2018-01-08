package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.PlanMapper;
import cn.bnsr.edu_yun.frontstage.train.po.Plan;
import cn.bnsr.edu_yun.frontstage.train.service.PlanService;
import cn.bnsr.edu_yun.frontstage.train.view.PlanView;

public class PlanServiceImpl implements PlanService{
	@Autowired
	private PlanMapper planMapper;

	@Override
	public int deleteByPrimaryKey(Long id) {
		return planMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Plan record) {
		return planMapper.insert(record);
	}

	@Override
	public int insertSelective(Plan record) {
		return planMapper.insertSelective(record);
	}

	@Override
	public Plan selectByPrimaryKey(Long id) {
		return planMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Plan record) {
		return planMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Plan record) {
		return planMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Plan> queryPlansbyComId(PlanView planView) {
		return planMapper.queryPlansbyComId(planView);
	}

	@Override
	public void updatePlanStatus(long id, int status) {
		planMapper.updatePlanStatus(id, status);
	}

	@Override
	public void batchUpdatePlanStatus(long[] ids, int status) {
		for(int i=0;i<ids.length;i++){
			planMapper.updatePlanStatus(ids[i], status);
		}
	}

	@Override
	public int queryPlanTotalbyComId(PlanView planView) {
		return planMapper.queryPlanTotalbyComId(planView);
	}

	@Override
	public void batchDeleteByPrimaryKey(long[] ids) {
		if(ids.length<=0){
			return ;
		}
		for(int i=0;i<ids.length;i++){
			planMapper.deleteByPrimaryKey(ids[i]);
		}
	}
	
}
	
