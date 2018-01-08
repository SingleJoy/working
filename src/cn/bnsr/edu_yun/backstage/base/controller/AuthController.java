package cn.bnsr.edu_yun.backstage.base.controller;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.po.Auth;
import cn.bnsr.edu_yun.backstage.base.service.AuthService;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 权限管理
 * @author fangxiongwei
 * @date 2016年8月29日
 */
@Controller
@RequestMapping("/back_auth")
public class AuthController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(AuthController.class);

	@Autowired
	private AuthService  authService;
	
	/**
	 *跳转权限页面
	 */
	@RequestMapping("/to_auth")
	public ModelAndView toAuth(){
		return new ModelAndView("backstage/base/auth/auth");
	}
	
	/**
	 * 跳转权限添加页面
	 */
	@RequestMapping("/to_auth_add")
	public ModelAndView authAdd() {
		return new ModelAndView("backstage/base/auth/auth_add");
	}
	
	/**
	 * 权限添加
	 */
	@RequestMapping("/save_auth")
	public void add(HttpServletResponse response,Auth auth){
		Json j = new Json();
		try {
			authService.save(auth);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			log.error("权限添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
		super.writeJson(j,response);
	}

	/**
	 * 删除一个权限
	 */
	@RequestMapping("/delete_auth") 
	public void delete(HttpServletResponse response,Auth auth) {
		Json j = new Json();
		try {
			authService.delete(auth);
			j.setSuccess(true);
			j.setMsg("删除成功！");
			j.setObj(auth.getId());
		} catch (Exception e) {
			log.error("权限删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		super.writeJson(j,response);
	}

	/**
	 *跳转权限编辑页面
	 */
	@RequestMapping("/to_auth_edit") 
	public ModelAndView authEdit() {
		return new ModelAndView("backstage/base/auth/auth_edit");
	}

	/**
	 * 权限编辑
	 */
	@RequestMapping("/edit_auth") 
	public void edit(HttpServletResponse response,Auth auth) {
		Json j = new Json();
		try {
			authService.update(auth);
			j.setSuccess(true);
			j.setMsg("编辑成功!");
		} catch (Exception e) {
			log.error("权限编辑失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("编辑失败！");
		}
		super.writeJson(j,response);
	}
	
	
	/**
	 * 获得权限treegrid
	 */
	@RequestMapping("/treegrid")
	public void treegrid(HttpServletResponse response,Auth auth) {
		super.writeJson(authService.treegrid(auth),response);
	}
	
	/**
	 * 首页获得权限树
	 */
	@RequestMapping("/doNotNeedSession_tree")
	public void doNotNeedSession_tree(HttpServletResponse response,Auth auth) {
		super.writeJson(authService.tree(auth,false),response);
	}
	
	/**
	 * 递归查询子节点
	 */
	@RequestMapping("/doNotNeedSession_tree_recursive")
	public void doNotNeedSession_treeRecursive(HttpServletResponse response,Auth auth) {
		super.writeJson(authService.tree(auth, true),response);
	}
	
	

}
