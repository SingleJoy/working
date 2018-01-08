package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.Certificate;
import cn.bnsr.edu_yun.frontstage.train.view.CertificatesView;
import cn.bnsr.edu_yun.frontstage.train.view.UserCertificateView;

public interface CertificateService {

	List<CertificatesView> findAll(CertificatesView certificatesView);
	
	void saveOrUpdate(CertificatesView certificatesView);
	
	void deleteCertificates(String ids);
	
	/**查询我的课程成绩及证书*/
	List<UserCertificateView> findMyCourseCert(UserCertificateView userCertificateView);
	
	/**统计上下的个数*/
	Integer countUserCertificate(UserCertificateView userCertificateView);
	
	/**查询我的培训成绩及证书*/
	List<UserCertificateView> findMyTrainCert(UserCertificateView userCertificateView);
	
	/**查询普通培训的课程id（分选修和必修）*/
	List<Long> queryCommonTrainCourseId(UserCertificateView userCertificateView);
	
	/**根据user_id和course_id查询某一课程的成绩*/
	Integer queryMyCourseScore(UserCertificateView userCertificateView);
	
	/**查询阶段培训的课程id（分选修和必修）*/
	List<Long> queryPhaseTrainCourseId(UserCertificateView userCertificateView);
	
    List<UserCertificateView> findMyCert(UserCertificateView userCertificateView);
	
	Integer countMyCert(UserCertificateView userCertificateView);
	
	Certificate selectOne(Long id);
	/**培训证书*/
	void saveOrUpdate1(CertificatesView certificatesView);
	

}
