package cn.bnsr.edu_yun.frontstage.base.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.view.MyCollectView;

public interface MyCollectMapper {
	public List<MyCollectView> showCollert(MyCollectView collectModel);
	public int queryTotalContribution(MyCollectView myCollectView);//我的收藏总条数  

}
