package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.ClassifyView;
import cn.bnsr.edu_yun.backstage.base.view.TreeNode;
import cn.bnsr.edu_yun.frontstage.base.po.Classify;

public interface ClassifyService {
	
	/**后台*/
	public void delete(Classify classify);
	
	public void save(Classify classify);
	
	public void update(Classify classify);
	
	public Classify selectById(int id);
	/**
	* 获得分类treegrid
	*/
	public List<ClassifyView> treegrid(Classify classify);
	
	/**
	 * 递归查询子节点
	 */
	public List<TreeNode> tree(Classify classify,Boolean b);
	
	
	/**
	 * 查询所有分类 ，0-资源；1-课程
	 * flag true 父；false 子
	 */
	public List<Classify> findAllClassify(int type, boolean flag);

	/**
	 * 根据父分类id查询子分类信息
	 */
	public List<Classify> queryByParentId(Long classifyId);
	/**
	 * 根据id查询当前分类及父分类信息
	 * @param id
	 * @return
	 */
	ClassifyView getClassifyViewById(int id);
	
	List<cn.bnsr.edu_yun.frontstage.base.view.ClassifyView> queryViewByParentId(Long classifyId);
	
	List<ClassifyView> queryparam();
}
