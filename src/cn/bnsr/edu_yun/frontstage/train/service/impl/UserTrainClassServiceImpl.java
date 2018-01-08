package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.train.mapper.UserTrainClassMapper;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudy;
import cn.bnsr.edu_yun.frontstage.train.po.UserTrainClass;
import cn.bnsr.edu_yun.frontstage.train.service.UserTrainClassService;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainCourseView;
import cn.bnsr.edu_yun.frontstage.train.view.UserStudyView;
import cn.bnsr.edu_yun.frontstage.train.view.UserTrainClassView;

public class UserTrainClassServiceImpl implements UserTrainClassService {

	@Autowired
	private UserTrainClassMapper userTrainClassMapper;

	@Override
	public void saveOrUpdate(UserTrainClass userTrainClass) {
		if (userTrainClass.getId() != null) {
			userTrainClassMapper.updateByPrimaryKeySelective(userTrainClass);
		} else {
			userTrainClassMapper.insertSelective(userTrainClass);
		}
	}

	@Override
	public List<UserStudy> searchCourseClassId(UserStudyView userStudyView) {
		return userTrainClassMapper.searchCourseClassId(userStudyView);
	}

	@Override
	public List<CourseView> queryTrainCourse(Long sourceId, Long userId,Long classId, List<String> list) {
		return userTrainClassMapper.queryTrainCourse(sourceId, userId,classId, list);
	}

	@Override
	public List<TrainCourseView> searchIsStudy(TrainCourseView tcv) {
		return userTrainClassMapper.searchIsStudy(tcv);
	}

	@Override
	public List<UserStudyView> searchTrainClassStudent(Long classId, int trainType) {
		return userTrainClassMapper.searchTrainClassStudent(classId, trainType);
	}

	@Override
	public List<UserTrainClass> queryUserTrainClass(UserTrainClass userTrainClass) {

		return userTrainClassMapper.queryUserTrainClass(userTrainClass);
	}

	@Override
	public int selectCountByCourseIdAndUserId(UserTrainClass userTrainClass) {

		return userTrainClassMapper.selectCountByCourseIdAndUserId(userTrainClass);
	}

	@Override
	public int selectCountByCourseIdAndUserIdStudy(UserTrainClass userTrainClass) {

		return userTrainClassMapper.selectCountByCourseIdAndUserIdStudy(userTrainClass);
	}

	@Override
	public List<UserTrainClass> queryUserTrainCourse(UserTrainClass userTrainClass) {
		
		return userTrainClassMapper.queryUserTrainCourse(userTrainClass);
	}

	@Override
	public List<UserTrainClassView> queryUserTrainCourseCount(
			UserTrainClassView userTrainClassView) {
		return userTrainClassMapper.queryUserTrainCourseCount(userTrainClassView);
	}

	@Override
	public List<User> queryUnfinish(UserTrainClass userTrainClass) {
		return userTrainClassMapper.queryUnfinish(userTrainClass);
	}

	@Override
	public List<UserTrainClassView> queryPerTrainFinCourseCount(
			UserTrainClassView userTrainClassView) {
		return userTrainClassMapper.queryPerTrainFinCourseCount(userTrainClassView);
	}

	@Override
	public UserTrainClassView querystudyedPhaseCourseHour(
			UserTrainClassView userTrainClassView) {
		return userTrainClassMapper.querystudyedPhaseCourseHour(userTrainClassView);
	}

}
