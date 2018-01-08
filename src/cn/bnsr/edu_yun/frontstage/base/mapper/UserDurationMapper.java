package cn.bnsr.edu_yun.frontstage.base.mapper;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.UserDurationView;
import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.frontstage.base.po.UserDuration;

public interface UserDurationMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_duration
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_duration
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    int insert(UserDuration record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_duration
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    int insertSelective(UserDuration record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_duration
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    UserDuration selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_duration
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    int updateByPrimaryKeySelective(UserDuration record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_duration
     *
     * @mbggenerated Thu Sep 21 10:25:44 CST 2017
     */
    int updateByPrimaryKey(UserDuration record);
    
    UserDuration selectByUserId(UserDuration userDuration);
    /**
     * 
     * 用户平均访问时长
     * @param condition
     * @return
     */
    List<UserStatsView> meanVisitTrend(UserStatsView condition);
    /**
     * 
     * 新用户平均访问时长
     * @param condition
     * @return
     */
    List<UserStatsView> meanNewVisitTrend(UserStatsView condition);
    /**
     * 
     * 汇总用户平均访问时长
     * @param condition
     * @return
     */
    String collectmeanVisitTrend(UserStatsView condition);
    /**
     * 
     * 汇总用户平均访问时长
     * @param condition
     * @return
     */
    String collectmeanNewVisitTrend(UserStatsView condition);
    
    List<UserDurationView> selectViewByUserId(UserDurationView userDurationView);
    
    Integer selectViewByUserIdCount(UserDurationView userDurationView);
    /**
     * 
     * TODO 查询一段时间内的在线人数
     * @param condition
     * @return
     */
    int queryOnlineNum(UserStatsView condition);
    
    List<UserDurationView> queryOnlineUser(UserStatsView userStats);
    /**
     * 
     * 查询一段时间内的新老用户的平均访问时长和访客数
     * @param userStats
     * @return
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
     * 查询某访问时间范围内的访问开始距离上次访问截止的时间间隔的分布情况
     * @param userStats
     * @return
     */
    List<UserStatsView> querylastTimeOnlineInterval(UserStatsView userStats);
    
    
    /**
     * 
     * 查询某访问时间范围内的地区平均访问时长分布情况
     * @param userStats
     * @return
     */
    List<UserStatsView> queryArealDistribution(UserStatsView userStats);
    
}