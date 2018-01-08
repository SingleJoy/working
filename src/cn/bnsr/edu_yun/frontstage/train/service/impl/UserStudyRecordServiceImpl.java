package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.content.view.ContentStatiView;
import cn.bnsr.edu_yun.frontstage.train.mapper.UserStudyRecordMapper;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudyRecord;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyRecordService;
import cn.bnsr.edu_yun.frontstage.train.view.UserStudyRecordView;

public class UserStudyRecordServiceImpl implements UserStudyRecordService {

	@Autowired
	private UserStudyRecordMapper userStudyRecordMapper;
	
	@Override
	public List<UserStudyRecordView> queryStudyRecordDynamic(UserStudyRecordView record) {
		return userStudyRecordMapper.queryStudyRecordDynamic(record);
	}

	@Override
	public void saveUserStudyRecord(UserStudyRecord record) {
		userStudyRecordMapper.insertSelective(record);
		
	}

	@Override
	public List<ContentStatiView> queryUserStudyRecordStati(
			ContentStatiView contentStatiView) {
		return userStudyRecordMapper.queryUserStudyRecordStati(contentStatiView);
	}

}
