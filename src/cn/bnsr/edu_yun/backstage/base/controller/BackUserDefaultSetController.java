package cn.bnsr.edu_yun.backstage.base.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.DefaultUserSetView;
import cn.bnsr.edu_yun.frontstage.base.po.DefaultText;
import cn.bnsr.edu_yun.frontstage.base.po.DefaultVarchar;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.service.DefaultTextService;
import cn.bnsr.edu_yun.frontstage.base.service.DefaultVarcharService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.util.ExceptionUtil;

@Controller
@RequestMapping("/back_user_default_set")
public class BackUserDefaultSetController {
	private final Logger log = LoggerFactory.getLogger(BackUserDefaultSetController.class);
	
	
	@Autowired
	private DefaultTextService  defaultTextService;
	@Autowired
	private DefaultVarcharService  defaultVarcharService;
	@Autowired
	private UserInfoService  userInfoService;
	/**
	 *跳转用户默认设置页面
	 */
	@RequestMapping("/to_user_default_set")
	public ModelAndView toUserDefaultSet(HttpServletRequest request,Integer type) {
		ModelAndView mv = new ModelAndView("backstage/base/user/user_default_set");
		String flag = request.getParameter("flag");
		DefaultUserSetView defaultUserSet = new DefaultUserSetView();
		if(type==0){//签名
			defaultUserSet.setType(0);
			defaultUserSet = defaultVarcharService.queryOne(defaultUserSet);
		}else if(type==1){
			defaultUserSet.setType(0);
			defaultUserSet = defaultTextService.queryOne(defaultUserSet);
		}
		mv.addObject("type", type);
		mv.addObject("flag", flag);
		mv.addObject("defaultUserSet", defaultUserSet);
		return mv;
	}
	
	
	/**
	 *更新默认用户设置
	 */
	@RequestMapping("/update_default_set")
	public ModelAndView updateDefaultImg(HttpServletRequest request,DefaultUserSetView defaultUserSet) {
		Integer type = defaultUserSet.getType();
		try {
			UserInfo userInfo = new UserInfo();
			if(type==0){//签名
				DefaultVarchar DefaultVarchar = new DefaultVarchar();
				DefaultVarchar.setId(defaultUserSet.getId());
				DefaultVarchar.setContent(defaultUserSet.getContent());
				defaultVarcharService.update(DefaultVarchar);
				userInfo.setSignature(defaultUserSet.getContent());
			}else if(type==1){//自我介绍
				DefaultText defaultText = new DefaultText();
				defaultText.setId(defaultUserSet.getId());
				defaultText.setContent(defaultUserSet.getContent());
				defaultTextService.update(defaultText);
				userInfo.setProfile(defaultUserSet.getContent());
			}
			userInfoService.updateDefaultSet(userInfo);
		} catch (Exception e) {
			log.error("查询默认图片失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/back_user_default_set/to_user_default_set.action?flag=1&type="+type);
	}
	
	

}
