package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.CourseExamStandardMapper;
import cn.bnsr.edu_yun.frontstage.train.po.CourseExamStandard;
import cn.bnsr.edu_yun.frontstage.train.service.CourseExamStandardService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseExamStandardView;
import cn.bnsr.edu_yun.util.NumUtil;

public class CourseExamStandardServiceImpl implements CourseExamStandardService{

	@Autowired
	private CourseExamStandardMapper courseExamStandardMapper;

	@Override
	public List<CourseExamStandardView> queryStandard(CourseExamStandardView examStandardView) {
		return courseExamStandardMapper.queryStandard(examStandardView);
	}

	@Override
	public void update(CourseExamStandardView courseExamStandardView) {
		String ids = courseExamStandardView.getId();
		String ratios = courseExamStandardView.getRatio();
		if(ids!=null){
			for(int i=0;i<ids.split(",").length;i++){
				CourseExamStandard standard = new CourseExamStandard();
				standard.setId(Long.parseLong(NumUtil.isNotEmpty(ids, i).trim()));
				standard.setRatio(Integer.parseInt(NumUtil.isNotEmpty(ratios, i).trim()));
				courseExamStandardMapper.updateByPrimaryKeySelective(standard);
			}
			
		}
	}

	@Override
	public void saveExamStandard(CourseExamStandard ces) {
		courseExamStandardMapper.insertSelective(ces);	
	}

	@Override
	public void deleteExamStandard(Long course_hour_id) {
		courseExamStandardMapper.deleteExamStandard(course_hour_id);
	}

	@Override
	public int queryTotalRatioByCouId(Long course_id) {
		Integer result = courseExamStandardMapper.queryTotalRatioByCouId(course_id);
		return result==null?0:result;
	}


}
