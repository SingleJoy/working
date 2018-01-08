package cn.bnsr.edu_yun.frontstage.base.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.PrivateLetter;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.service.PrivateLetterService;
import cn.bnsr.edu_yun.frontstage.base.view.PrivateLetterView;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("private_letter")
public class PrivateLetterController {
	private final Logger log = LoggerFactory.getLogger(PrivateLetterController.class);
	@Autowired
	private PrivateLetterService privateLetterService;
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param privateLetter
	 * @throws Exception
	 */
	@RequestMapping("/send")
	public void send(HttpServletRequest request,HttpServletResponse response,PrivateLetter privateLetter)
			throws Exception{
		User user = (User) request.getSession().getAttribute("currentUser");
		privateLetter.setUser_id(user.getId());
		privateLetterService.insert(privateLetter);
		JSONObject result=new JSONObject();
		ResponseUtil.write(response, result);
	}
	@RequestMapping("/to_letter")
	public ModelAndView toLetter(HttpServletRequest request,PrivateLetterView privateLetterView){
		ModelAndView modelAndView=new ModelAndView("frontstage/base/private_letter");
		User user = (User) request.getSession().getAttribute("currentUser");
		privateLetterView.setUser_id(user.getId());
		privateLetterView.setRows(10);
		if(privateLetterView.getPage()==0){
			privateLetterView.setStartLine(0);
		}else{
			privateLetterView.setStartLine(privateLetterView.getPage()*privateLetterView.getRows());
		}
		int total=(int) privateLetterService.queryPrivateLetterCount(privateLetterView);
		privateLetterView.setTotal(total);
		privateLetterView.setTotalPage(NumUtil.totalPage(total,10));
		List<PrivateLetterView> privateLetterViews= privateLetterService.queryPrivateLetter(privateLetterView);
		modelAndView.addObject("privateLetterViews", privateLetterViews);
		modelAndView.addObject("privateLetterView", privateLetterView);
		modelAndView.addObject("head_title", "我的私信");
		return modelAndView;
		
	}
	@RequestMapping("/to_letter_detail")
	public ModelAndView toLetterDetail(HttpServletRequest request,PrivateLetterView privateLetterView){
		ModelAndView modelAndView=new ModelAndView("frontstage/base/private_letter_detail");
		User user = (User) request.getSession().getAttribute("currentUser");
		privateLetterView.setUser_id(user.getId());
		privateLetterView.setRows(10);
		if(privateLetterView.getPage()==0){
			privateLetterView.setStartLine(0);
		}else{
			privateLetterView.setStartLine(privateLetterView.getPage()*privateLetterView.getRows());
		}
		int total=(int) privateLetterService.queryPrivateLetterDetailCount(privateLetterView);
		privateLetterView.setTotal(total);
		privateLetterView.setTotalPage(NumUtil.totalPage(total,10));
		List<PrivateLetterView> privateLetterViews= privateLetterService.queryPrivateLetterDetail(privateLetterView);
		modelAndView.addObject("privateLetterViews", privateLetterViews);
		if(privateLetterViews.size()>0){
		privateLetterView.setTo_user_name(privateLetterViews.get(0).getTo_user_name());
		}
		modelAndView.addObject("privateLetterView", privateLetterView);
		modelAndView.addObject("head_title", "发送私信");
		return modelAndView;
		
	}
	@RequestMapping("/delete_all")
	public void deleteAll(HttpServletRequest request,HttpServletResponse response,PrivateLetterView privateLetterView)
			throws Exception{
		User user = (User) request.getSession().getAttribute("currentUser");
		privateLetterView.setUser_id(user.getId());
		privateLetterService.deleteAll(privateLetterView);
		JSONObject result=new JSONObject();
		ResponseUtil.write(response, result);
	}
	@RequestMapping("/delete")
	public void delete(HttpServletRequest request,HttpServletResponse response,long id)
			throws Exception{
		privateLetterService.delete(id);
		JSONObject result=new JSONObject();
		ResponseUtil.write(response, result);
	}
}
