package cn.bnsr.edu_yun.backstage.base.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.LetterView;
import cn.bnsr.edu_yun.backstage.base.view.UserView;
import cn.bnsr.edu_yun.frontstage.base.service.PrivateLetterService;
import cn.bnsr.edu_yun.util.ExceptionUtil;

@Controller
@RequestMapping("/back_private_letter")
public class BackPrivateLetterController extends BaseController{
	
	private final Logger log = LoggerFactory.getLogger(BackPrivateLetterController.class);

	@Autowired
	private PrivateLetterService  privateLetterService;
	
	/**
	 *跳转私信管理页面
	 */
	@RequestMapping("/to_private_letter")
	public ModelAndView toPrivateletter(HttpServletRequest request,Long openId){
		request.setAttribute("openId", openId);
		return new ModelAndView("backstage/base/privateLetter/private_letter");
	}
	
	
	/**
	* 获得分类treegrid
	*/
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,LetterView letterView) {
		super.writeJson(privateLetterService.datagrid(letterView),response);
	}

	/**
	 * 删除一条私信
	 */
	@RequestMapping("/delete_private_letter") 
	public void delete(HttpServletResponse response,LetterView letterView) {
		Json j = new Json();
		try {
			privateLetterService.delete(letterView.getIds());
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("私信删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		super.writeJson(j,response);
	}

}
