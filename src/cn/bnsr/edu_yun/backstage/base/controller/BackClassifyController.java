package cn.bnsr.edu_yun.backstage.base.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.ClassifyView;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.frontstage.base.po.Classify;
import cn.bnsr.edu_yun.frontstage.base.service.ClassifyService;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 分类设置
 * @author fangxiongwei
 * @date 2016年10月18日
 */
@Controller
@RequestMapping("/back_classify")
public class BackClassifyController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(BackClassifyController.class);

	@Autowired
	private ClassifyService  classifyService;


	/**
	 *跳转分类页面
	 */
	@RequestMapping("/to_classify")
	public ModelAndView toclassify(){
		ModelAndView mv = new ModelAndView("backstage/base/classify/classify"); 
		List<ClassifyView> list = classifyService.queryparam();
		mv.addObject("list", list);
		return mv;
	}
	
	
	/**
	 * 跳转分类添加页面
	 */
	@RequestMapping("/to_classify_add")
	public ModelAndView classifyAdd() {
		return new ModelAndView("backstage/base/classify/classify_add");
	}
	
	
	/**
	 *跳转分类编辑页面
	 */
	@RequestMapping("/to_classify_edit") 
	public ModelAndView classifyEdit() {
		return new ModelAndView("backstage/base/classify/classify_edit");
	}
	
	
	/**
	* 获得分类treegrid
	*/
	@RequestMapping("/treegrid")
	public void treegrid(HttpServletResponse response,Classify classify) {
	
		super.writeJson(classifyService.treegrid(classify),response);
	}
	
	/**
	 * 递归查询子节点
	 */
	@RequestMapping("/doNotNeedSession_tree_recursive")
	public void doNotNeedSession_treeRecursive(HttpServletResponse response,Classify classify) {
		super.writeJson(classifyService.tree(classify, true),response);
	}
	
	/**
	 * 分类添加
	 */
	@RequestMapping("/save_classify")
	public void add(HttpServletRequest request,HttpServletResponse response,Classify classify){
		Json j = new Json();
		try {
			String pid = request.getParameter("pid");
			if(classify.getParent_id()==null||classify.getParent_id().length()==0){
				classify.setParent_id(pid);
			}
			classifyService.save(classify);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			log.error("分类添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
		super.writeJson(j,response);
	}
	
	/**
	 * 分类编辑
	 */
	@RequestMapping("/edit_classify") 
	public void edit(HttpServletResponse response,Classify classify){
		Json j = new Json();
		try {
			classifyService.update(classify);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			log.error("分类编辑失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("编辑失败！");
		}
		super.writeJson(j,response);
	}
	/**
	 * 删除一个分类
	 */
	@RequestMapping("/delete_classify") 
	public void delete(HttpServletResponse response,Classify classify) {
		Json j = new Json();
		try {
			classifyService.delete(classify);
			j.setSuccess(true);
			j.setMsg("删除成功！");
			j.setObj(classify.getId());
		} catch (Exception e) {
			log.error("菜单删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		super.writeJson(j,response);
	}

}
