package cn.bnsr.edu_yun.comparator;

import java.util.Comparator;

import cn.bnsr.edu_yun.backstage.resource.view.ResourceStatsView;
import cn.bnsr.edu_yun.util.TimeUtil;

/**
 * 系统资源排序
 * @author fangxiongwei
 * @date 2016年9月1日
 */
public class FileStatsComparator implements Comparator<ResourceStatsView> {

	@Override
	public int compare(ResourceStatsView o1, ResourceStatsView o2) {
		 /*  
         * 返回负数表示：o1 小于o2，  
         * 返回0 表示：o1和o2相等，  
         * 返回正数表示：o1大于o2。  
         */  
		return TimeUtil.compare_date(o1.getDays(), o2.getDays());
	}

}
