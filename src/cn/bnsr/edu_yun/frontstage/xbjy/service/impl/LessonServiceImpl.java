package cn.bnsr.edu_yun.frontstage.xbjy.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.frontstage.train.po.CertModelPicture;
import cn.bnsr.edu_yun.frontstage.train.service.CertModelPictureService;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;
import cn.bnsr.edu_yun.frontstage.xbjy.mapper.LessonMapper;
import cn.bnsr.edu_yun.frontstage.xbjy.po.Lesson;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.SubjectLessonView;
import cn.bnsr.edu_yun.util.NumUtil;



public class LessonServiceImpl implements LessonService{

	
	@Autowired
	private LessonMapper lessonMapper;
	@Autowired
	private CertModelPictureService  certModelPictureService;
	
	@Override
	public List<LessonView> queryLesson(LessonView lessonView) {
		return lessonMapper.queryLesson(lessonView);
	}
	
	@Override
	public int queryTotalLesson(LessonView lessonView) {
		return lessonMapper.queryTotalLesson(lessonView);
	}
	
	@Override
	public void saveLesson(LessonView lessonView) {
		Lesson lesson = new Lesson();
		BeanUtils.copyProperties(lessonView, lesson);
		if(lessonView.getId()>0 && !lessonView.equals("")){
			lesson.setUpdate_time(new Date());
			lessonMapper.updateByPrimaryKeySelective(lesson);
		}else{
			lesson.setCreate_time(new Date());
			CertModelPicture defaultImg = certModelPictureService.getDefaultImg(5);
			lesson.setLesson_pic(defaultImg.getPath());
			lesson.setIs_default_img(0);
			lessonMapper.insertSelective(lesson);
		}
		lessonView.setId(lesson.getId());
	}
	
	@Override
	public LessonView findPK(Long userId) {
		return lessonMapper.findPK(userId);
	}
	
	@Override
	public Lesson getById(Long id) {
		Lesson lesson = lessonMapper.selectByPrimaryKey(id);
		if(lesson.getIs_default_img()==0){//是默认图片
			CertModelPicture defaultImg = certModelPictureService.getDefaultImg(5);
			lesson.setLesson_pic(defaultImg.getPath());
		}
		return lesson;
	}

	@Override
	public LessonView queryLessonView(Long id) {
		
		return lessonMapper.queryLessonView(id);
	}
	
	
	@Override
	public void updateExcellent(LessonView lessonView) {
			lessonMapper.updateExcellent(lessonView);
	}
	
	
	@Override
	public void updateStatus(LessonView lessonView) {
			lessonMapper.updateStatus(lessonView);
	}
	
	@Override
	public void saveLessonSelf(LessonView lessonView) {
			lessonMapper.saveLessonSelf(lessonView);
	}

	@Override
	public List<LessonView> queryLessonMain(LessonView lessonView) {
		
		return lessonMapper.queryLessonMain(lessonView);
	}

	@Override
	public int queryLessonMainCount(LessonView lessonView) {
		
		return lessonMapper.queryLessonMainCount(lessonView);
	}

	@Override
	public int update(Lesson lesson) {
		
		return lessonMapper.updateByPrimaryKeySelective(lesson);
	}
	
	@Override
	public List<LessonView> queryUserLesson(LessonView lessonView) {
		
		return lessonMapper.queryUserLesson(lessonView);
	}
	
	@Override
	public int countUserLesson(LessonView lessonView) {
		
		return lessonMapper.countUserLesson(lessonView);
	}

	@Override
	public List<LessonView> queryCommunityLesson(CommunityCenterView communityCenterView) {
		
		return lessonMapper.queryCommunityLesson(communityCenterView);
	}

	@Override
	public int queryTotalCommunityLesson(CommunityCenterView communityCenterView) {
		
		return lessonMapper.queryTotalCommunityLesson(communityCenterView);
	}

	@Override
	public List<DataStatsView> lessonDataStats(DataStatsView dataStatsView) {
		return lessonMapper.lessonDataStats(dataStatsView);
	}

	@Override
	public List<LessonView> queryUserLessonCreate(LessonView lessonView) {
		
		return lessonMapper.queryUserLessonCreate(lessonView);
	}

	@Override
	public int countUserLessonCreate(LessonView lessonView) {
		
		return lessonMapper.countUserLessonCreate(lessonView);
	}

	@Override
	public LessonView queryLessonOne(LessonView lessonView) {
		
		return lessonMapper.queryLessonOne(lessonView);
	}

	@Override
	public List<LessonView> queryLessonByArea(LessonView lessonView) {
		
		return lessonMapper.queryLessonByArea(lessonView);
	}

	@Override
	public List<SubjectLessonView> queryLessonHome(SubjectLessonView subjectLessonView) {
		
		return lessonMapper.queryLessonHome(subjectLessonView);
	}

	@Override
	public DataGrid datagrid(LessonView lessonView) {
		DataGrid j = new DataGrid();
		lessonView.setPage(NumUtil.startingNum(lessonView.getPage(),lessonView.getRows()));
		j.setRows(find(lessonView));
		j.setTotal(total(lessonView));
		return j;
	}
	
    public List<LessonView> find(LessonView lessonView){
    	return lessonMapper.search(lessonView);
    }
    
    public Long total(LessonView lessonView){
    	return lessonMapper.total(lessonView);
    }

	@Override
	public Long getMaxSeq(Long workshop_id) {
		return lessonMapper.getMaxSeq(workshop_id);
	}
	
}
