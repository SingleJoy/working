package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.tiku.service.TestPaperService;
import cn.bnsr.edu_yun.frontstage.train.mapper.CourseFileMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.CourseHourMapper;
import cn.bnsr.edu_yun.frontstage.train.po.CourseExamStandard;
import cn.bnsr.edu_yun.frontstage.train.po.CourseFile;
import cn.bnsr.edu_yun.frontstage.train.po.CourseHour;
import cn.bnsr.edu_yun.frontstage.train.service.CourseExamStandardService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourFileService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseHourService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourView;

public class CourseHourServiceImpl implements CourseHourService{
	@Autowired
	private CourseHourMapper courseHourMapper;
	@Autowired
	private CourseFileMapper courseFileMapper;
	@Autowired
	private CourseHourFileService courseHourFileService;
	@Autowired
	private CourseExamStandardService courseExamStandardService;
	@Autowired
	private TestPaperService testPaperService;
	
	@Override
	public long saveCourseHour(CourseHour courseHour) {
		courseHour.setIs_release(1);//@TODO  未发布 预留暂不处理
		courseHourMapper.insertSelective(courseHour);
		int type = courseHour.getAttribute_type();
		if((type==2 && "0".equals(courseHour.getFile_source()))&&courseHour.getHour_type()!=3){//课时  && 来源为课程文件  图文则不更新课程文件
			CourseFile cf = courseFileMapper.selectByPrimaryKey(courseHour.getCourse_file_id());
			cf.setIs_use(0);//文件状态，修改为使用
			cf.setIs_son(1);//课时文件，不是子文件
			courseFileMapper.updateByPrimaryKeySelective(cf);
		}
		if(type==3 || type==4 || type==0){//讨论-> 1|| 作业-> 0|| 考试-> 2
			CourseExamStandard ces = new CourseExamStandard();
			ces.setCourse_id(courseHour.getCourse_id());
			ces.setSource_id(courseHour.getId());
			if(type==3){
				ces.setSource_type(1);
			}else if(type==4){
				ces.setSource_type(0);
			}else if(type==0){
				ces.setSource_type(2);
			}
			ces.setSource_name(courseHour.getHour_title());
			courseExamStandardService.saveExamStandard(ces);
		}
		return courseHour.getId();
	}

	@Override
	public List<CourseHour> queryHourList(Long courseId, boolean flag) {
		return courseHourMapper.queryHourList(courseId,flag);
	}

	@Override
	public int searchSeq(String courseId, String parentId) {
		return courseHourMapper.searchSeq(courseId,parentId);
	}

	@Override
	public CourseHour getHour(String id) {
		return courseHourMapper.selectByPrimaryKey(Long.parseLong(id));
	}

	@Override
	public void updateCourseHour(CourseHour courseHour) {
		courseHourMapper.updateByPrimaryKeySelective(courseHour);
	}

	@Override
	public void deleteHour(String id,String attributeType) {
		if(attributeType.equals("1")){//章节
			//根据节点id查询所有课时
			List<CourseHour> sec = courseHourMapper.queryByParentId(id);
			for(CourseHour ch:sec){
				if(ch.getAttribute_type()!=2){
					courseExamStandardService.deleteExamStandard(ch.getId());
				}
				courseHourMapper.deleteByPrimaryKey(ch.getId());
				//根据课时id删除，课时子文件
				courseHourFileService.deleteByHourId(ch.getId().toString());
			}
		}else if(attributeType.equals("2")){//课时
			//根据课时id删除，课时子文件
			courseHourFileService.deleteByHourId(id);
		}else if(attributeType.equals("0") || attributeType.equals("3") 
				|| attributeType.equals("4")){//考试 ||讨论||作业  
			courseExamStandardService.deleteExamStandard(Long.parseLong(id));
			//去掉试卷和课时的关联
			if(attributeType.equals("0")){
				testPaperService.resetTestPaper(Long.parseLong(id));
			}
		}
		courseHourMapper.deleteByPrimaryKey(Long.parseLong(id));
	}

	@Override
	public List<CourseHour> queryAllHour(List<String> courseIds, boolean flag) {
		return courseHourMapper.queryAllHour(courseIds,flag);
	}

	@Override
	public List<CourseHourView> queryHourListUser(CourseHourView courseHourView) {
		
		return courseHourMapper.queryHourListUser(courseHourView);
	}

	@Override
	public int queryHourOfCourseCount(long courseId) {
		return courseHourMapper.queryHourOfCourseCount(courseId);
	}

	@Override
	public void sortCourseHour(String ids, String hourSeqs, String parent_ids) {
		String[] idss = ids.split(",");
		for(int i=0;i<idss.length;i++){
			CourseHour hour = new CourseHour();
			hour.setId(Long.parseLong(idss[i]));
			hour.setHour_seq(Integer.parseInt(hourSeqs.split(",")[i]));
			hour.setParent_id(Long.parseLong(parent_ids.split(",")[i]));
			courseHourMapper.updateByPrimaryKeySelective(hour);
		}
		
	}

	@Override
	public List<CourseHour> queryHourListByPid(Long parent_id) {
		
		return courseHourMapper.queryHourListByPid(parent_id);
	}

	@Override
	public List<CourseHour> queryHourListByType(long course_id, int attribute_type) {
		
		return courseHourMapper.queryHourListByType(course_id, attribute_type);
	}
}
