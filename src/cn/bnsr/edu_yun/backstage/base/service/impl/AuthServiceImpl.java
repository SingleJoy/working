package cn.bnsr.edu_yun.backstage.base.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.mapper.AuthMapper;
import cn.bnsr.edu_yun.backstage.base.mapper.RoleAuthMapper;
import cn.bnsr.edu_yun.backstage.base.po.Auth;
import cn.bnsr.edu_yun.backstage.base.service.AuthService;
import cn.bnsr.edu_yun.backstage.base.view.TreeNode;
import cn.bnsr.edu_yun.backstage.base.view.TreeView;
import cn.bnsr.edu_yun.comparator.AuthComparator;

public class AuthServiceImpl implements AuthService{
	@Autowired 
	private AuthMapper authMapper;
	
	@Autowired
	private RoleAuthMapper roleAuthMapper;
	
	@Override
	public List<TreeNode> tree(Auth Auth, Boolean b) {
		return tree(Auth, b, "");
	}
	
	public List<TreeNode> tree(Auth Auth,Boolean b,String authNames) {
		List<Auth> authList = authMapper.queryTree(Auth);
		List<TreeNode> tree = new ArrayList<TreeNode>();
		for (Auth a : authList) {
			tree.add(this.treeNode(a,b));
		}
		return tree;
	}
	
	private TreeNode treeNode(Auth t, boolean recursive) {
		TreeNode node = new TreeNode();
		node.setId(t.getId()+"");
		node.setText(t.getName());
		Map<String, Object> attributes = new HashMap<String, Object>();
		attributes.put("url", t.getUrl());
		node.setAttributes(attributes);
		List<Auth> l = authMapper.queryTree(t);
		if (l != null && l.size()>0) {
			if(t.getPid()!=null){
				node.setState("closed");
			}
			if (recursive) {// 递归查询子节点
				Collections.sort(l, new AuthComparator());// 排序
				List<TreeNode> children = new ArrayList<TreeNode>();
				for (Auth r : l) {
					TreeNode tn = treeNode(r, true);
					children.add(tn);
				}
				node.setChildren(children);
//				node.setState("closed");
			}
		}
		return node;
	}

	@Override
	public List<TreeView> treegrid(Auth Auth) {
		List<TreeView> treeList = authMapper.queryTreeGrid(Auth);
		if (treeList != null && treeList.size() > 0) {
			for(TreeView tv : treeList){
				if (countChildren(tv.getId()) > 0) {
					tv.setState("closed");
				}
			}
		}
		return treeList;
	}

	@Override
	public void save(Auth Auth) {
		if(Auth.getPid()==null){
			Auth.setPid(1L);
		}
		authMapper.insertSelective(Auth);
	}

	@Override
	public void delete(Auth Auth) {
		authMapper.deleteByPrimaryKey(Auth.getId());
		roleAuthMapper.deleteByAuthId(Auth.getId());
	}
	
	@Override
	public void update(Auth Auth) {
		authMapper.updateByPrimaryKeySelective(Auth);
	}
	/**
	 * 统计有多少子节点
	 */
	private Long countChildren(String pid) {
		return authMapper.countChildren(pid);
	}

	@Override
	public List<Auth> getByUserId(Long userId) {
		return authMapper.getByUserId(userId);
	}


}
