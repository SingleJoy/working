package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.MessageFile;
import cn.bnsr.edu_yun.frontstage.train.view.MessageView;

public interface MessageService {

	void saveMessage(MessageView messageView);
	
	void updateMessage(MessageView messageView);
	
	List<MessageView> showAllMessage(MessageView messageView);
	
	int countMessage(MessageView messageView);
	
	void batchUpdateMessage(MessageView messageView);
	
	MessageView selectOne(Long id);
	
	/**
	 * 获取当前社区最新的通知
	 * @param messageView
	 * @return
	 */
	MessageView showLastMessage(MessageView messageView);
	/* 查询班级公告 */
	List<MessageView> queryClassNotices(MessageView messageView);
	/* 删除单条公告 */
	void delClassNotice(long id);
	/* 批量删除公告 */
	public void batchDelClassNotice(long[] ids);
	/* 查询班级公告总数 */
	int queryClassNoticesCount(MessageView messageView);
	/* 查询班级公告详情 */
	MessageView queryClassNoticeDetail(long id);
	
	MessageFile selectMessageFile(long id);
}
