package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.UserCertificated;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.view.CertificateView;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherView;



public interface UserInfoService {
	
	/**根据用户id查询老师信息*/
	public UserInfo getByUserId(Long userId);

	/**
	 * 注册时生成老师信息
	 * @param info
	 * @return
	 */
	public int insert(UserInfo info);
	/**
	 * 根据id修改老师信息
	 * @param userInfo
	 * @return
	 */
	public int updateUserInfo(UserInfo userInfo);
	/**
	 * 申请老师或管理员的用户列表
	 * @param sort
	 * @param order
	 * @param start
	 * @param pageSize
	 * @return
	 */
	 public List<UserInfo>  selectByBack(CertificateView certificateView);
/**
 * 申请老师或管理员的总数
 * @return
 */
	 int selectCountByBack(CertificateView view);
	 
	 
	 UserInfo selectById(long id);
	 int insertUserCertificated(UserCertificated userCertificated);
	 int updateUserCertificated(UserCertificated userCertificated);
	 
	 /**
	  * 
	  * TODO 查询老师
	  * @param teacherView
	  * @return
	  */
	 List<TeacherView> findTeacher(TeacherView teacherView);
	 /**
	  * 
	  * TODO 查询老师总数
	  * @param teacherView
	  * @return
	  */
	 Integer countTeacher(TeacherView teacherView);
	 
	 List<String> findTitles(Long userId);
	/**
	 * 
	 *跟新默认用户设置
	 * @param userInfo
	 */
	 void updateDefaultSet(UserInfo userInfo);
	 
}
