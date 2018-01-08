package cn.bnsr.edu_yun.frontstage.base.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.view.MyResourcesView;

public interface MyResourcesMapper {
	/**
	 * 展示我的资源
	 * @param myResourcesView
	 * @return
	 */
	public List<MyResourcesView> showMyResources(MyResourcesView myResourcesView);
	/**
	 * 我的资源总数
	 * @param myResourcesView
	 * @return
	 */
	public int queryTotalResources(MyResourcesView myResourcesView);

}
