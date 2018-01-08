package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.view.MyCollectView;

public interface MyCollectService {
	public List<MyCollectView> showCollert(MyCollectView model);//我的收藏的service
	public int queryTotalContribution(MyCollectView myCollectView);//我的收藏总条数        
}
