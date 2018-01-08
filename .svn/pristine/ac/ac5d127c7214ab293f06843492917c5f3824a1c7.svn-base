package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.Notice;
import cn.bnsr.edu_yun.frontstage.base.view.NoticeView;

/**
 * 通知的service
 * @author apple
 *
 */
public interface NoticeService {
	/**
	 * 添加通知
	 * @param notice
	 * @return int
	 */
	public int insertNotice(Notice notice);
	/**
	 * 按user_id查询通知
	 */
	public List<Notice> selectNoticeBuUserId(NoticeView noticeView);
	/**
	 * 查询符合条件的notice总条数
	 * @param noticeView
	 * @return
	 */
	public int queryTotalNotice(NoticeView noticeView);
}
