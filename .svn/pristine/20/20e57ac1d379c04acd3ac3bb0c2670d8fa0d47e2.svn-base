package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.frontstage.base.po.UserDuration;

public interface UserDurationService {

	int insert(UserDuration userDuration);

	int update(UserDuration userDuration);

	UserDuration selectByUserId(UserDuration userDuration);
	
    String collectmeanVisitTrend(UserStatsView condition);
    
    String collectmeanNewVisitTrend(UserStatsView condition);
    
    /**
     * 
     * 查询某访问时间范围内的总的平均访问时长
     * @param userStats
     * @return
     */
    String queryArealDistribution(UserStatsView userStats);
    
}
