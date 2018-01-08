package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.NotificationMapper;
import cn.bnsr.edu_yun.frontstage.base.po.Notification;
import cn.bnsr.edu_yun.frontstage.base.service.NotificationService;
import cn.bnsr.edu_yun.frontstage.base.view.NotificationView;

public class NotificationServiceImpl implements NotificationService{

	@Autowired
	private NotificationMapper notificationMapper;
	@Override
	public void insert(Notification notification) {
		
		notificationMapper.insertSelective(notification);
		
	}
	@Override
	public  List<NotificationView> queryNotification(NotificationView notificationView) {
		
		List<NotificationView> notificationViews=notificationMapper.queryNotification(notificationView);
		
		for(NotificationView view:notificationViews){
			if(view.getIs_read()==1){
				Notification notification=new Notification();
				notification.setId(view.getId());
				notification.setIs_read(0);
				notificationMapper.updateByPrimaryKeySelective(notification);
			}
		}
		
		return notificationViews;
	}
	@Override
	public long queryNotificationCount(NotificationView notificationView) {
		// TODO Auto-generated method stub
		return notificationMapper.queryNotificationCount(notificationView);
	}
	@Override
	public long queryNoReadCount(NotificationView notificationView) {
		// TODO Auto-generated method stub
		return notificationMapper.queryNoReadCount(notificationView);
	}

}
