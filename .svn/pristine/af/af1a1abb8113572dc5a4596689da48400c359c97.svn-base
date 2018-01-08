package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.User_attentMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.TeacherRelationMapper;
import cn.bnsr.edu_yun.frontstage.train.po.TeacherRelation;
import cn.bnsr.edu_yun.frontstage.train.service.TeacherRelationService;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherView;
import cn.bnsr.edu_yun.util.NumUtil;

public class TeacherRelationServiceImpl implements TeacherRelationService{
	
	@Autowired
	private TeacherRelationMapper teacherRelationMapper;
	
	@Autowired 
	private User_attentMapper userAttentMapper;
	
	@Override
	public void insertTeacherRelation(TeacherRelation TeacherRelation) {
		teacherRelationMapper.insertSelective(TeacherRelation);
	}

	@Override
	public List<TeacherRelationView> queryTeacherRelation(Long sourceId,Integer sourceType,Integer type) {
		return 	teacherRelationMapper.queryTeacherRelation(sourceId,sourceType,type);
	}

	@Override
	public void deleteAllCourseId(int type,Long source_id, int source_type) {
		teacherRelationMapper.deleteAllCourseId(type,source_id,source_type);	
	}

	@Override
	public void saveTeacherRelation(TeacherRelationView ctv,Long userId) {
		if(ctv.getUserId().contains(",")){//多个
			int lengths = ctv.getUserId().split(",").length;
			for(int i=0;i<lengths;i++){
				Long teacherId = Long.parseLong(NumUtil.isNotEmpty(ctv.getUserId(),i));
				if(userId != teacherId ){
					TeacherRelation teacher = new TeacherRelation();
					teacher.setSource_id(ctv.getSource_id());
					teacher.setSource_type(ctv.getSource_type());
					teacher.setSeq(1);
					teacher.setType(0);//教师
					teacher.setIs_display(Integer.parseInt(NumUtil.isNotEmpty(ctv.getIsDisplay(),i)));
					teacher.setUser_id(teacherId);
					this.insertTeacherRelation(teacher);
				}
			}
		}else{//单个
			if(userId != Long.parseLong(ctv.getUserId())){
				TeacherRelation teacher = new TeacherRelation();
				teacher.setSource_id(ctv.getSource_id());
				teacher.setSource_type(ctv.getSource_type());
				teacher.setSeq(1);
				teacher.setType(0);//教师
				teacher.setIs_display(Integer.parseInt(ctv.getIsDisplay()));
				teacher.setUser_id(Long.parseLong(ctv.getUserId()));
				this.insertTeacherRelation(teacher);
			}
		}
	}

	@Override
	public List<TeacherView> queryAssaint(TeacherRelation teacherRelation) {
		if(teacherRelation!=null){
			return teacherRelationMapper.queryTeacher(teacherRelation);
		}
		return null;
	}

	@Override
	public List<TeacherRelationView> queryAllTeacher(List<String> courseIds) {
		return teacherRelationMapper.queryAllTeacher(courseIds);
	}

	@Override
	public void deleteTeacher(String id) {
		teacherRelationMapper.deleteByPrimaryKey(Long.parseLong(id));
	}

	@Override
	public List<TeacherRelationView> queryTeacherOfClass(
			TeacherRelationView teacherRelationView) {
		return teacherRelationMapper.queryTeacherOfClass(teacherRelationView);
	}

	@Override
	public List<String> queryCourseTeachersRealName(int type, Long sourceId,
			Integer sourceType) {
		return teacherRelationMapper.queryCourseTeachersRealName(type, sourceId, sourceType);
	}
}






















