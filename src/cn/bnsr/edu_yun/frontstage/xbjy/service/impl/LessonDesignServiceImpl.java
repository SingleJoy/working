package cn.bnsr.edu_yun.frontstage.xbjy.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.xbjy.mapper.LessonDesignMapper;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonDesign;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonDesignService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonDesignView;

public class LessonDesignServiceImpl implements LessonDesignService {

	@Autowired
	private LessonDesignMapper lessonDesignMapper;

	@Override
	public int save(LessonDesignView lessonDesignView,Integer tab) {
		LessonDesign record = getLessonDesign(lessonDesignView,tab);
		return lessonDesignMapper.insertSelective(record);
	}

	@Override
	public int update(LessonDesignView lessonDesignView,Integer tab) {
		LessonDesign record = getLessonDesign(lessonDesignView,tab);
		record.setId(lessonDesignView.getId());
		return lessonDesignMapper.updateByPrimaryKeyWithBLOBs(record);
	}

	private LessonDesign getLessonDesign(LessonDesignView lessonDesignView, Integer tab) {
		LessonDesign record = new LessonDesign();
		record.setCreate_time(new Date());
		record.setEdu_goal(lessonDesignView.getEdu_goal());
		record.setFocus_difficulty(lessonDesignView.getFocus_difficulty());
		record.setLesson_divide(lessonDesignView.getLesson_divide());
		record.setLesson_id(lessonDesignView.getLesson_id());
		record.setMaterials_analysis(lessonDesignView.getMaterials_analysis());
		record.setMedia_selection(lessonDesignView.getMedia_selection());
		record.setMedia_selection(lessonDesignView.getMedia_selection());
		//record.setStatus(lessonDesignView.getStatus());
		record.setStrategy_design(lessonDesignView.getStrategy_design());
		record.setStudent_analysis(lessonDesignView.getStudent_analysis());
		record.setTeaching_process(lessonDesignView.getTeaching_process());
		record.setTypography_design(lessonDesignView.getTypography_design());
		record.setUser_id(lessonDesignView.getUser_id());
		if(tab==3){
		record.setStatus(1);
		}
		if(tab==4){
			record.setStatus(2);	
		}
		if(lessonDesignView.getStatus()==1){
			LessonDesignView lessonDesignView2 = new LessonDesignView();
			lessonDesignView2.setOrder("desc");
			lessonDesignView2.setLesson_id(lessonDesignView.getLesson_id());
		if(lessonDesignMapper.queryVersion(lessonDesignView2)==null||lessonDesignMapper.queryVersion(lessonDesignView2).getVersion_num()==null){
			record.setVersion_num(1);	
		}else{
			record.setVersion_num(lessonDesignMapper.queryVersion(lessonDesignView2).getVersion_num()+1);	
		}
		}
		return record;
	}

	@Override
	public LessonDesignView queryVersion(LessonDesignView lessonDesignView) {
		
		return lessonDesignMapper.queryVersion(lessonDesignView);
	}

	@Override
	public LessonDesign selectById(Long id) {
		
		return lessonDesignMapper.selectByPrimaryKey(id);
	}

	@Override
	public LessonDesignView queryCompare(LessonDesignView lessonDesignView) {
		
		return lessonDesignMapper.queryCompare(lessonDesignView);
	}

	@Override
	public List<LessonDesignView> queryAll(LessonDesignView lessonDesignView) {
		
		return lessonDesignMapper.queryAll(lessonDesignView);
	}

	@Override
	public LessonDesignView queryById(Long id) {
		
		return lessonDesignMapper.queryById(id);
	}
}