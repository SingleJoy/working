package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.TrainCourseMapper;
import cn.bnsr.edu_yun.frontstage.train.po.TrainCourse;
import cn.bnsr.edu_yun.frontstage.train.service.TrainCourseService;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainCourseView;

public class TrainCourseServiceImpl implements TrainCourseService{
	@Autowired
	private TrainCourseMapper trainCourseMapper;

	@Override
	public List<TrainCourseView> queryTrainCourse(TrainCourseView tcView) {
		return trainCourseMapper.queryTrainCourse(tcView);
	}

	@Override
	public void saveTrainCourse(TrainCourseView tcView) {
		if(tcView.getIds()!=null && !tcView.getIds().equals("")){//修改
			String[] ids = tcView.getIds().split(",");
			for (int i=0;i<ids.length;i++) {
				TrainCourse tc = trainCourseMapper.selectByPrimaryKey(Long.parseLong(ids[i]));
				if(!tcView.getSeqs().equals("")){//排序
					tc.setSeq(Integer.parseInt(tcView.getSeqs().split(",")[i]));
				}else{//是否必修
					tc.setIs_required(Integer.parseInt(tcView.getRequireds().split(",")[i]));
				}
				trainCourseMapper.updateByPrimaryKeySelective(tc);
			}
		}else{//保存
			for (String courseId : tcView.getCourseIds().split(",")) {
				TrainCourse tc = new TrainCourse();
				tc.setSource_id(tcView.getSource_id());
				tc.setSource_type(tcView.getSource_type());
				tc.setCourse_id(Long.parseLong(courseId));
				tc.setSeq(0);
				tc.setCredit(0);
				tc.setIs_required(1);
				trainCourseMapper.insertSelective(tc);
			}
		}
	}

	@Override
	public void deleteTrainCourse(Long id) {
		trainCourseMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void insertSelective(TrainCourse tc) {
		trainCourseMapper.insertSelective(tc);	
	}

	@Override
	public List<CourseView> queryPhaseCourse(Long phaseId, int isRequired) {
		return trainCourseMapper.queryPhaseCourse(phaseId,isRequired);
	}

	@Override
	public void deletePhaseCourse(TrainCourseView tcView) {
		trainCourseMapper.deletePhaseCourse(tcView);
	}

	@Override
	public List<TrainCourseView> queryRequiredCourse(TrainCourseView tcv) {
		return trainCourseMapper.queryRequiredCourse(tcv);
	}

	@Override
	public List<CourseView> queryTrainCourseExam(Long id,int trainType,Long phaseId, int isRequired) {
		return trainCourseMapper.queryTrainCourseExam(id,trainType,phaseId, isRequired);
	}

	@Override
	public int queryTrainCourseOfTrainCount(ClassView classView) {
		return trainCourseMapper.queryTrainCourseOfTrainCount(classView);
	}

	@Override
	public List<TrainCourseView>  queryCourseStudy(TrainCourseView trainCourseView) {
		
		return trainCourseMapper.queryCourseStudy(trainCourseView);
	}

	@Override
	public int queryCount(TrainCourseView trainCourseView) {
		
		return trainCourseMapper.queryCount(trainCourseView);
	}

	@Override
	public List<TrainCourseView> queryUserCourseStudy(TrainCourseView trainCourseView) {
		
		return trainCourseMapper.queryUserCourseStudy(trainCourseView);
	}


}
