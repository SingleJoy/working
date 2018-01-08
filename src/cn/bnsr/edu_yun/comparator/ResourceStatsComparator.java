package cn.bnsr.edu_yun.comparator;

import java.util.Comparator;

import cn.bnsr.edu_yun.backstage.resource.view.FileStatsView;
import cn.bnsr.edu_yun.util.TimeUtil;

public class ResourceStatsComparator implements Comparator<FileStatsView> {

	@Override
	public int compare(FileStatsView o1, FileStatsView o2) {
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
