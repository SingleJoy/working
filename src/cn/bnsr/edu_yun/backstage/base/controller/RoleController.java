package cn.bnsr.edu_yun.backstage.base.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.service.RoleService;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.RoleView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 角色管理
 * @author fangxiongwei
 * @date 2016年8月30日
 */
@Controller
@RequestMapping("/back_role")
public class RoleController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(RoleController.class);

	@Autowired
	private RoleService  roleService;


	/**
	 *跳转角色页面
	 */
	@RequestMapping("/to_role")
	public ModelAndView toRole(){
		return new ModelAndView("backstage/base/role/role");
	}
	
	/**
	 * 获得角色datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,RoleView roleView) {
		super.writeJson(roleService.datagrid(roleView),response);
	}
	
	/**
	 * 跳转角色添加页面
	 */
	@RequestMapping("/to_role_add")
	public ModelAndView roleAdd() {
		return new ModelAndView("backstage/base/role/role_add");
	}
	
	/**
	 * 角色添加
	 */
	@RequestMapping("/save_role")
	public void add(HttpServletResponse response,RoleView roleView){
		Json j = new Json();
		try {
			roleService.save(roleView);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			log.error("角色添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
		super.writeJson(j,response);
	}

	/**
	 * 角色删除
	 */
	@RequestMapping("/delete_role") 
	public void delete(HttpServletResponse response,RoleView roleView){
		Json j = new Json();
		try{
			roleService.delete(roleView.getIds());
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("角色删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
		
		super.writeJson(j,response);
	}
	
	/**
	 *跳转角色编辑页面
	 */
	@RequestMapping("/to_role_edit") 
	public ModelAndView roleEdit() {
		return new ModelAndView("backstage/base/role/role_edit");
	}
	
	/**
	 * 角色编辑
	 */
	@RequestMapping("/edit_role") 
	public void edit(HttpServletResponse response,RoleView roleView){
		Json j = new Json();
		try {
			roleService.update(roleView);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			log.error("角色编辑失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("编辑失败！");
		}
		super.writeJson(j,response);
	}


	/**
	 * 获得角色下拉列表
	 */
	@RequestMapping("/doNotNeedSession_combobox")
	public void doNotNeedSession_combobox(HttpServletRequest request,HttpServletResponse response) {
		String level = request.getParameter("level");
		super.writeJson(roleService.combobox(level),response);
	}

}