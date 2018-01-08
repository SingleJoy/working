package cn.bnsr.edu_yun.comparator;

import java.util.Comparator;

import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.util.TimeUtil;

/**
 * 用户统计排序
 * @author fangxiongwei
 * @date 2016年10月14日
 */
public class UserStatsComparator implements Comparator<UserStatsView> {

	@Override
	public int compare(UserStatsView o1, UserStatsView o2) {
		 /*  
         * 返回负数表示：o1 小于o2，  
         * 返回0 表示：o1和o2相等，  
         * 返回正数表示：o1大于o2。  
         */  
		if(o1.getSort()==0){
			return TimeUtil.compare_hour(o1.getDays(), o2.getDays());
		}else{
			return TimeUtil.compare_date(o1.getDays(), o2.getDays());
		}
		
	}

}
