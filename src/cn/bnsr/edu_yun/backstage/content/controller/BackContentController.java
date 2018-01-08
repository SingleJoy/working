package cn.bnsr.edu_yun.backstage.content.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.content.service.BackContentService;
import cn.bnsr.edu_yun.backstage.content.view.ContentStatiView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 后台内容
 * @author heliwei
 *
 */
@Controller
@RequestMapping("/back_content")
public class BackContentController extends BaseController{
	private final Logger log =LoggerFactory.getLogger(BackContentController.class);
	@Autowired
	private BackContentService backContentService;
	
	/**
	 * 跳转内容统计页面
	 * @return
	 */
	@RequestMapping("/to_content_stati")
	public ModelAndView toContentStati(ContentStatiView contentStatiView){
		ModelAndView mv = new ModelAndView();
		try{
			mv.addObject("contentStatiView",contentStatiView);
			mv.setViewName("backstage/content/content_stati_info");
		}catch(Exception e){
			log.error("跳转内容统计页面失败",ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	@RequestMapping("query_content_stati")
	public void queryContentStati(HttpServletResponse response,ContentStatiView contentStatiView){
		Json j = new Json();
		try{
			List<ContentStatiView> contentStatiList = backContentService.queryContentStati(contentStatiView);
			j.setSuccess(true);
			j.setObj(contentStatiList);
			j.setMsg("查询内容统计信息成功！");
		}catch(Exception e){
			log.error("查询内容统计信息失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("查询内容统计信息失败！");
			e.printStackTrace();
		}
		super.writeJson(j, response);
	}
}
