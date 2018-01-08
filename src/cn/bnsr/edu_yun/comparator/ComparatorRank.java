package cn.bnsr.edu_yun.comparator;

import java.util.Comparator;

import cn.bnsr.edu_yun.frontstage.resource.view.RankView;

public class ComparatorRank implements Comparator<Object>{

	@Override
	public int compare(Object o1, Object o2) {
		RankView r1=(RankView) o1;
		RankView r2=(RankView) o2;
	
		if(r1.getUploadCount()>r2.getUploadCount()){
		    return -1;
		}
		if(r1.getUploadCount()<r2.getUploadCount()){
		    return 1;
		}else{
			return 0;
		}
	}

}
