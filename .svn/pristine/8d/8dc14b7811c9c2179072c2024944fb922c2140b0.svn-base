package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.UserCollect;
import cn.bnsr.edu_yun.frontstage.train.view.UserCollectView;

public interface UserCollectService {
	/**
	 * 查询是否收藏
	 * @param course_id
	 * @param user_id
	 * @return
	 */
	UserCollect selectByCourseIdAndUserId(UserCollect userCollect);
	/**
	 * 收藏
	 * @param courseCollect
	 * @return
	 */
	int insert(UserCollect userCollect);
	/**
	 * 取消收藏
	 * @param courseCollect
	 * @return
	 */
	int delete(long id);
	
	List<UserCollectView> queryMyCollect(UserCollectView userCollectView);
	
    int countMyCollect(UserCollectView userCollectView);
    
    int countMyAllCollect(Long user_id);
	
}
