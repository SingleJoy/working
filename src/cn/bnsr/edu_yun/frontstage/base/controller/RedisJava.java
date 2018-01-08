package cn.bnsr.edu_yun.frontstage.base.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.service.UserFileService;
import cn.bnsr.edu_yun.frontstage.resource.view.RankView;
import cn.bnsr.edu_yun.util.RedisKey;
import cn.bnsr.edu_yun.util.RedisUtils;

@Controller
@RequestMapping("/redis")
public class RedisJava {
	@Autowired
	private UserFileService userFileService;
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/to_redis")
	public ModelAndView toRedis(HttpServletRequest request){
        int start = (int) System.currentTimeMillis();  
		ModelAndView modelAndView = new ModelAndView();
		List<RankView> rankViews=new ArrayList<RankView>();
		Object obj= RedisUtils.get(RedisKey.RANKING_LIST);
		if(obj==null){//没有缓存
			rankViews = userFileService.queryRankFile();
			RedisUtils.set(RedisKey.RANKING_LIST, rankViews);
		}else{
			rankViews = (List<RankView>) obj;
		}
		
        int end = (int) System.currentTimeMillis();  
        
        System.out.println(">用时：>"+(end-start)+"毫秒");
        
		modelAndView.addObject("rankViews", rankViews);
		modelAndView.setViewName("frontstage/base/redis");
		return modelAndView;
	}
	
	public static void main(String[] args) {
		RedisUtils.flushAll();
	 }
}
