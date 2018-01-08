package cn.bnsr.edu_yun.backstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.po.Auth;
import cn.bnsr.edu_yun.backstage.base.view.TreeNode;
import cn.bnsr.edu_yun.backstage.base.view.TreeView;

public interface AuthService {
	/**
	 * 获取权限树
	 */
	public List<TreeNode> tree(Auth auth,Boolean b);
	/**权限菜单treegrid
	 */
	public List<TreeView> treegrid(Auth auth);
	
	public void delete(Auth auth);
	public void save(Auth auth);
	public void update(Auth auth);
	
	/**
	 * 根据用户id查询用户所有权限
	 */
	public List<Auth> getByUserId(Long userId);
}
