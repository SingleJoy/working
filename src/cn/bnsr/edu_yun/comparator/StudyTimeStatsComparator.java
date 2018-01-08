package cn.bnsr.edu_yun.comparator;

import java.util.Comparator;

import cn.bnsr.edu_yun.backstage.train.view.StudyTimeStatsView;
import cn.bnsr.edu_yun.util.TimeUtil;

public class StudyTimeStatsComparator implements Comparator<StudyTimeStatsView> {

	@Override
	public int compare(StudyTimeStatsView o1, StudyTimeStatsView o2) {
		// TODO Auto-generated method stub
		if(o1.getTimeType()==4){
			return TimeUtil.compare_hour(o1.getDays(), o2.getDays());
		}else{
			return TimeUtil.compare_date(o1.getDays(), o2.getDays());
		}
	}

}
