package cn.bnsr.edu_yun.backstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.po.Menu;
import cn.bnsr.edu_yun.backstage.base.view.TreeNode;
import cn.bnsr.edu_yun.backstage.base.view.TreeView;

public interface MenuService {

	/**
	 * 获取菜单树
	 */
	public List<TreeNode> tree(Menu menu,Boolean b, String authNames);
	/**
	 * 递归查询子节点
	 */
	public List<TreeNode> tree(Menu menu,Boolean b);
	/**
	 * 获得菜单treegrid
	 */
	public List<TreeView> treegrid(Menu menu);
	
	public void delete(Menu menu);
	public void save(Menu menu);
	public void update(Menu menu);

}
