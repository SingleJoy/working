package cn.bnsr.edu_yun.comparator;

import java.util.Comparator;

import cn.bnsr.edu_yun.backstage.base.view.StudyTimeView;
import cn.bnsr.edu_yun.backstage.train.view.StudyTimeStatsView;
import cn.bnsr.edu_yun.util.TimeUtil;

public class StudyTimeViewComparator implements Comparator<StudyTimeView> {

	@Override
	public int compare(StudyTimeView o1, StudyTimeView o2) {
		
		   if(o1.getDays()!=null){
			   return TimeUtil.compare_date(o1.getDays(), o2.getDays());   
		   }else if(o1.getHours()!=null){
			   return TimeUtil.compare_date(o1.getHours(), o2.getHours()); 
		   }else{
			   return TimeUtil.compare_date(o1.getWeeks(), o2.getWeeks()); 
		   }
		
			
		
	}

}
