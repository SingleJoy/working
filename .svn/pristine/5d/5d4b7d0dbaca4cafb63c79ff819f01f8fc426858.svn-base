package cn.bnsr.edu_yun.comparator;

import java.util.Comparator;

import cn.bnsr.edu_yun.backstage.base.view.OrderStatsView;
import cn.bnsr.edu_yun.util.TimeUtil;

/**
 * 订单统计排序
 * @author fangxiongwei
 * @date 2016年10月17日
 */
public class OrderStatsComparator implements Comparator<OrderStatsView> {

	@Override
	public int compare(OrderStatsView o1, OrderStatsView o2) {
		 /*  
         * 返回负数表示：o1 小于o2，  
         * 返回0 表示：o1和o2相等，  
         * 返回正数表示：o1大于o2。  
         */  
		return TimeUtil.compare_date(o1.getDays(), o2.getDays());
	}

}
