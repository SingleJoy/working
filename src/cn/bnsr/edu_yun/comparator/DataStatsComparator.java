package cn.bnsr.edu_yun.comparator;

import java.util.Comparator;

import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;
import cn.bnsr.edu_yun.util.TimeUtil;

/**
 * 社区、工作坊排序
 * @author fangxiongwei
 * @date 2017年5月24日
 */
public class DataStatsComparator implements Comparator<DataStatsView>{
	@Override
	public int compare(DataStatsView o1, DataStatsView o2) {
		 /*  
         * 返回负数表示：o1 小于o2，  
         * 返回0 表示：o1和o2相等，  
         * 返回正数表示：o1大于o2。  
         */  
		return TimeUtil.compare_date(o1.getDays(), o2.getDays());
	}
}