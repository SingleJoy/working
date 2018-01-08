package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.view.MyResourcesView;
/**
 *我的资源Service
 * @author apple
 *
 */
public interface MyResourcesService {
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
