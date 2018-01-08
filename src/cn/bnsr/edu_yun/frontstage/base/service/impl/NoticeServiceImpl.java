package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.NoticeMapper;
import cn.bnsr.edu_yun.frontstage.base.po.Notice;
import cn.bnsr.edu_yun.frontstage.base.service.NoticeService;
import cn.bnsr.edu_yun.frontstage.base.view.NoticeView;

public class NoticeServiceImpl implements NoticeService{
	@Autowired 
	private NoticeMapper noticeMapper;

	@Override
	public int insertNotice(Notice notice) {
		// TODO Auto-generated method stub
		return noticeMapper.insert(notice);
	}

	@Override
	public List<Notice> selectNoticeBuUserId(NoticeView noticeView) {
		// TODO Auto-generated method stub
		return noticeMapper.selectNoticeBuUserId(noticeView);
	}

	@Override
	public int queryTotalNotice(NoticeView noticeView) {
		// TODO Auto-generated method stub
		return noticeMapper.queryTotalNotice(noticeView);
	}

}
