package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.tiku.mapper.TestPaperMapper;
import cn.bnsr.edu_yun.frontstage.tiku.service.ExamService;
import cn.bnsr.edu_yun.frontstage.tiku.view.ExamView;
import cn.bnsr.edu_yun.frontstage.tiku.view.TestPaperView;
import cn.bnsr.edu_yun.frontstage.train.mapper.CertificateMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.CourseMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.TrainMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.UserCertMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.UserClassHourMapper;
import cn.bnsr.edu_yun.frontstage.train.po.Course;
import cn.bnsr.edu_yun.frontstage.train.po.Train;
import cn.bnsr.edu_yun.frontstage.train.po.UserCert;
import cn.bnsr.edu_yun.frontstage.train.po.UserClassHour;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudy;
import cn.bnsr.edu_yun.frontstage.train.po.UserTrainClass;
import cn.bnsr.edu_yun.frontstage.train.service.TrainExamStandardService;
import cn.bnsr.edu_yun.frontstage.train.service.UserClassHourService;
import cn.bnsr.edu_yun.frontstage.train.service.UserTrainClassService;
import cn.bnsr.edu_yun.frontstage.train.view.CertificatesView;
import cn.bnsr.edu_yun.frontstage.train.view.ClassView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseRankView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainExamStandardView;
import cn.bnsr.edu_yun.frontstage.train.view.UserClassHourView;
import cn.bnsr.edu_yun.frontstage.train.view.UserTotalScoreView;

public class UserClassHourServiceImpl implements UserClassHourService {

	@Autowired
	private UserClassHourMapper userClassHourMapper;
	@Autowired
	private UserCertMapper userCertMapper;
	@Autowired
	private CertificateMapper certificateMapper;
	@Autowired
	private CourseMapper courseMapper;
	@Autowired
	private UserTrainClassService userTrainClassService;
	@Autowired
	private TrainExamStandardService trainExamStandardService;
	@Autowired
	private TrainMapper trainMapper;
	@Autowired
	private TestPaperMapper testPaperMapper;
	@Autowired
	private ExamService examService;

	@Override
	public int insert(UserClassHour userClassHour) {

		return userClassHourMapper.insertSelective(userClassHour);
	}

	@Override
	public UserClassHour selectByNextStudy(UserClassHour userClassHour) {

		return userClassHourMapper.selectByNextStudy(userClassHour);
	}

	@Override
	public int selectCountByCourseIdAndUserId(UserClassHour userClassHour) {

		return userClassHourMapper.selectCountByCourseIdAndUserId(userClassHour);
	}

	@Override
	public int selectCountByCourseIdAndUserIdStudy(UserClassHour userClassHour) {

		return userClassHourMapper.selectCountByCourseIdAndUserIdStudy(userClassHour);
	}

	@Override
	public UserClassHour selectByUpAndDown(long type, long course_hour_id, long learn_id, long user_id, long source_id, int source_type) {

		return userClassHourMapper.selectByUpAndDown(type, course_hour_id, learn_id, user_id, source_id, source_type);
	}

	@Override
	public int update(UserClassHour userClassHour) {

		return userClassHourMapper.updateByPrimaryKeySelective(userClassHour);
	}

	@Override
	public UserClassHour selectByHourId(UserClassHour userClassHour) {

		return userClassHourMapper.selectByHourId(userClassHour);
	}

	@Override
	public UserClassHour selectById(long id) {

		return userClassHourMapper.selectByPrimaryKey(id);
	}

	@Override
	public int countIsNotStudy(UserClassHourView uchv) {
		return userClassHourMapper.countIsNotStudy(uchv);
	}

	@Override
	public int queryIsNotStudy(UserClassHourView userClassHourView) {
		return userClassHourMapper.queryIsNotStudy(userClassHourView);
	}

	@Override
	public int queryData(UserClassHourView userClassHourView) {

		return userClassHourMapper.queryData(userClassHourView);
	}

	@Override
	public int countCompleteCourseHour(ClassView ClassView) {

		return userClassHourMapper.countCompleteCourseHour(ClassView);
	}

	@Override
	public List<User> queryUnfinish(CourseHourView courseHourView) {

		return userClassHourMapper.queryUnfinish(courseHourView);
	}

	@Override
	public List<UserClassHourView> queryCourseStudyed(Long userId, Long courseId,Long classId) {
		return userClassHourMapper.queryCourseStudyed(userId, courseId,classId);
	}

	@Override
	public List<UserClassHour> queryAll(Long classId) {
		// TODO Auto-generated method stub
		return userClassHourMapper.queryAll(classId);
	}

	@Override
	public void saveCert(UserClassHourView userClassHourView, UserStudy userStudy) {
		UserCert userCert = new UserCert();
		userCert.setClasses(userClassHourView.getClass_id() + "");
		userCert.setComplete_time(new Date());
		userCert.setUser_study_id(userStudy.getId());
		userCert.setUser_id(userClassHourView.getUser_id());
		// 培训获得证书
		if (userStudy.getSource_type() == 1) {
			// 必修课是否全学完
			UserTrainClass userTrainClass = new UserTrainClass();
			userTrainClass.setUser_id(userClassHourView.getUser_id());
			userTrainClass.setUser_study_id(userStudy.getId());
			userTrainClass.setClass_id(userClassHourView.getClass_id());
			userTrainClass.setTrain_required(0);
			int allClass = userTrainClassService.selectCountByCourseIdAndUserId(userTrainClass);
			int studyClass = userTrainClassService.selectCountByCourseIdAndUserIdStudy(userTrainClass);
			int realTime = 0;
			List<UserTrainClass> userTrainClasses = userTrainClassService.queryUserTrainCourse(userTrainClass);
			for (UserTrainClass userTrainClass2 : userTrainClasses) {
				Long courseId = userTrainClass2.getCourse_id();
				TestPaperView testPaperView = new TestPaperView();
				testPaperView.setCourseId(courseId);
				boolean flag = true;
				List<TestPaperView> testPaperViews = testPaperMapper.queryTestPaper(testPaperView);
				//考试是否合格
				if (testPaperViews != null)
					for (TestPaperView tPaperView : testPaperViews) {
						ExamView examView = new ExamView();
						examView.setUser_id(userClassHourView.getUser_id());
						examView.setTest_paper_id(tPaperView.getId());
						examView.setClass_id(userClassHourView.getClass_id());
						Integer grade = examService.queryExamGrade(examView);
						if (grade==null||grade == 3) {
							flag = false;
							break;
						}
					}
				if (flag)
					realTime += Integer.parseInt(courseMapper.selectByPrimaryKey(courseId).getHours());
			}
			double score = realTime;
			userCert.setScore(score);
			if (allClass == studyClass) {
				// 需要的学时 train_exam_standard
				TrainExamStandardView trainExamStandardView = trainExamStandardService.queryByTrainId(userStudy.getLearn_id());
				int totalTime = trainExamStandardView.getTotal_required();// 总学时
				// 实际达到的学时
				// 培训里所有的课程
				if (realTime >= totalTime) {
					// 实际学时大于等于要求学时才给证书
					userCert.setStudy_type(1);
					Train train = trainMapper.selectByPrimaryKey(userStudy.getLearn_id());
					userCert.setStudy_name(train.getName());
					CertificatesView certificatesView = new CertificatesView();
					certificatesView.setSource_id(userStudy.getLearn_id() + "");
					certificatesView.setSource_type(0 + "");
					String s = certificateMapper.findAll(certificatesView).get(0).getCertificate_id();
					Long cert_id = Long.parseLong(s);
					userCert.setCert_id(cert_id);

				}
			}
			if (userCertMapper.selectByUserCert(userCert).size() < 1) {
				userCertMapper.insertSelective(userCert);
			} else {
				long id = userCertMapper.selectByUserCert(userCert).get(0).getId();
				userCert.setId(id);
				userCertMapper.updateByPrimaryKeySelective(userCert);
			}
		} else {
			// 课程获得证书
			double score = 0;
			UserTotalScoreView userTotalScoreView = userClassHourMapper.queryUserScore(userClassHourView);
			if (userTotalScoreView != null && userTotalScoreView.getScore() != null) {
				String scoreStr = userTotalScoreView.getScore();
				score = Double.parseDouble(scoreStr);
				score = Math.round(score);
			}
			Course course = courseMapper.selectByPrimaryKey(userClassHourView.getCourse_id());
			userCert.setStudy_name(course.getTitle());
			userCert.setScore(score);
			userCert.setStudy_type(0);
			CertificatesView certificatesView = new CertificatesView();
			certificatesView.setSource_id(userClassHourView.getCourse_id() + "");
			certificatesView.setSource_type(1 + "");
			List<CertificatesView> certificatesViews = certificateMapper.findAll(certificatesView);
			for (CertificatesView certificatesView2 : certificatesViews) {
				double up_score = Double.parseDouble(certificatesView2.getUp_score());// 上限分数
				double down_score = Double.parseDouble(certificatesView2.getDown_score());// 下限分数
				if (score >= down_score && (score <= up_score)) {
					String s = certificatesView2.getCertificate_id();
					Long cert_id = Long.parseLong(s);
					userCert.setCert_id(cert_id);
					break;
				}
			}
			if (userCertMapper.selectByUserCert(userCert).size() < 1) {
				userCertMapper.insertSelective(userCert);
			} else {
				long id = userCertMapper.selectByUserCert(userCert).get(0).getId();
				userCert.setId(id);
				userCertMapper.updateByPrimaryKeySelective(userCert);
			}
		}

	}

	@Override
	public void deleteClassHour(Long user_id, Long class_id) {
		userClassHourMapper.deleteClassHour(user_id, class_id);
		
	}

	@Override
	public List<CourseRankView> paceRank(CourseRankView courseRankView) {
		// TODO Auto-generated method stub
		return userClassHourMapper.paceRank(courseRankView);
	}

	@Override
	public List<CourseRankView> durationRank(CourseRankView courseRankView) {
		// TODO Auto-generated method stub
		return userClassHourMapper.durationRank(courseRankView);
	}
}
