package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.UserCertificatedMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.UserInfoMapper;
import cn.bnsr.edu_yun.frontstage.base.po.UserCertificated;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.view.CertificateView;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherView;



public class UserInfoServiceImpl implements UserInfoService{
	@Autowired
	private UserInfoMapper userInfoMapper;
	@Autowired 
	private UserCertificatedMapper userCertificatedMapper;
	@Override
	public UserInfo getByUserId(Long userId) {
		return userInfoMapper.getByUserId(userId);
	}
	@Override
	public int insert(UserInfo info) {
		// TODO Auto-generated method stub
		return userInfoMapper.insertSelective(info);
	}
	@Override
	public int updateUserInfo(UserInfo userInfo) {
		// TODO Auto-generated method stub
		return userInfoMapper.updateByPrimaryKeySelective(userInfo);
	}
	
	@Override
	public UserInfo selectById(long id) {
		// TODO Auto-generated method stub
		return userInfoMapper.selectByPrimaryKey(id);
	}
	@Override
	public int insertUserCertificated(UserCertificated userCertificated) {
		// TODO Auto-generated method stub
		return userCertificatedMapper.insertSelective(userCertificated);
	}
	@Override
	public List<UserInfo> selectByBack(CertificateView certificateView) {
		// 
		return userInfoMapper.selectByBack(certificateView);
	}
	
	@Override
	public int selectCountByBack(CertificateView view) {
		// TODO Auto-generated method stub
		return userInfoMapper.selectCountByBack(view);
	}
	@Override
	public int updateUserCertificated(UserCertificated userCertificated) {
		// TODO Auto-generated method stub
		return userCertificatedMapper.updateByPrimaryKeySelective(userCertificated);
	}
	@Override
	public List<TeacherView> findTeacher(TeacherView teacherView) {
		return userInfoMapper.findTeacher(teacherView);
	}
	@Override
	public Integer countTeacher(TeacherView teacherView) {
		return userInfoMapper.countTeacher(teacherView);
	}
	@Override
	public List<String> findTitles(Long userId) {
		List<String> list = new ArrayList<String>();
		List<String> titles = userInfoMapper.findTitles(userId);
		if(titles!=null&&titles.size()>0){
			for(String title : titles){
				if(title!=null){
					list.add(title);
				}
			}
		}
		return list;
	}
	
	@Override
	public void updateDefaultSet(UserInfo userInfo) {
		userInfoMapper.updateDefaultSet(userInfo);
	}

}
