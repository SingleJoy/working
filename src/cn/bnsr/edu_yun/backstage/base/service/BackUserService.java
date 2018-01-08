package cn.bnsr.edu_yun.backstage.base.service;

import java.text.ParseException;
import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.PageBase;
import cn.bnsr.edu_yun.backstage.base.view.UserDurationView;
import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.backstage.base.view.UserTrackView;
import cn.bnsr.edu_yun.backstage.base.view.UserView;
import cn.bnsr.edu_yun.frontstage.base.po.User;

public interface BackUserService {

	DataGrid datagrid(UserView userView) throws ParseException;
	
	void save(UserView userView);

	void update(UserView userView);
	
//	void resetPassword(Long id);

	void delete(String ids);

	User login(User user);

	String checkExis(UserView userView);

	void doChangeStatus(UserView userView);

	void saveRoleEdit(UserView userView);

	List<UserStatsView> queryUserStats(UserStatsView userStats)throws ParseException ;
	
	/*
	 * 后台查询用户（、）留存趋势
	 */
	List<UserStatsView> queryRemainStats(UserStatsView userStats)throws ParseException ;
	//查询用户统计数据
	List<UserStatsView> queryUserTrend(UserStatsView userStats)throws ParseException ;
	//查询用户留存数据
	List<UserStatsView> queryUserRemain(UserStatsView userStats)throws ParseException ;
	//查询用户活跃数据
	List<UserStatsView> queryUserActive(UserStatsView userStats)throws ParseException ;

	List<UserTrackView> slectAllTrack(UserTrackView userTrackView)  throws Exception;
	
	Long totalTrack();
	
	DataGrid datagridTrack(UserTrackView userTrackView) throws Exception;

	DataGrid datagridTrackIndex(long user_id, int index, PageBase p) throws Exception;
	
	//查询用户活跃数据
	List<UserStatsView> queryOnlineNum(UserStatsView userStats)throws ParseException ;
	
	List<UserDurationView> queryOnlineUser(UserStatsView userStats);
	
	List<UserStatsView> queryAvgOnline(UserStatsView condition) throws ParseException;
	
	List<UserStatsView> ageDistribution(UserStatsView condition);
	
	Integer querySexNum(UserStatsView condition);
	
	/*
     * 查询一段时间内的新老用户的平均访问时长和访客数
     */
    UserStatsView queryAvgVisitTime(UserStatsView userStats);
    
    /**
     * 
     * 查询某访问时间范围内的次数
     * @param userStats
     * @return
     */
    List<UserStatsView> querytimesByduaration(UserStatsView userStats);
    
    /**
	 * 
	 * 查询一段时间内的登录频次
	 * @param userStats
	 * @return
	 */
    List<UserStatsView> queryLoginFrequency(UserStatsView userStats);
    
    
    List<UserStatsView> querylastTimeOnlineInterval(UserStatsView userStats);
    
    List<UserStatsView> queryArealDistribution(UserStatsView userStats);
    
    UserView queryme(Long id);
}
