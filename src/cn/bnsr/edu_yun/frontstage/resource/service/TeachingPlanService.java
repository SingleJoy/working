package cn.bnsr.edu_yun.frontstage.resource.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.resource.po.TeachingPlan;
import cn.bnsr.edu_yun.frontstage.resource.po.TeachingPlanFile;
import cn.bnsr.edu_yun.frontstage.resource.view.TeachingPlanView;

public interface TeachingPlanService {

	int insert(TeachingPlan teachingPlan);
	
	int insertFile(TeachingPlanFile teachingPlanFile);
	
	TeachingPlan selectById(Long id);
	
	List<TeachingPlanFile>  selectByPlanId(Long id);
	
	TeachingPlanView queryTeachingPlan(TeachingPlanView teachingPlanView);
	
	TeachingPlanFile selectFile(Long id);

	int update(TeachingPlan teachingPlan);

	int deletePlanFile(Long id);
}
