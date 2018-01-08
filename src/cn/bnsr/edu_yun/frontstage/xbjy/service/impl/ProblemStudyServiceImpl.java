package cn.bnsr.edu_yun.frontstage.xbjy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.xbjy.mapper.ProblemStudyMapper;
import cn.bnsr.edu_yun.frontstage.xbjy.po.ProblemStudy;
import cn.bnsr.edu_yun.frontstage.xbjy.service.ProblemStudyService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.ProblemStudyView;

public class ProblemStudyServiceImpl implements ProblemStudyService{

	@Autowired
	private ProblemStudyMapper problemStudyMapper;

	@Override
	public Integer countDiscussion(ProblemStudyView problemStudyView) {
		return problemStudyMapper.countDiscussion(problemStudyView);
	}

	@Override
	public int insert(ProblemStudy problemStudy) {
		
		return problemStudyMapper.insertSelective(problemStudy);
	}

	@Override
	public List<ProblemStudyView> selectProblemList(ProblemStudyView problemStudyView) {
		
		List<ProblemStudyView> problemStudyViews=problemStudyMapper.selectProblemList(problemStudyView);
		
		for(ProblemStudyView problemStudyView2:problemStudyViews){
			problemStudyView2.setRoot_id(problemStudyView2.getId());
			
			problemStudyView2.setSonView(problemStudyMapper.selectProblemList(problemStudyView2));
			
		}
		
		return problemStudyViews;
	}

	@Override
	public int delete(Long id) {
		
		return problemStudyMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int selectProblemListCount(ProblemStudyView problemStudyView) {
		
		return problemStudyMapper.selectProblemListCount(problemStudyView);
	}

	@Override
	public ProblemStudy selectById(Long id) {
	
		return problemStudyMapper.selectByPrimaryKey(id);
	}
	
}
