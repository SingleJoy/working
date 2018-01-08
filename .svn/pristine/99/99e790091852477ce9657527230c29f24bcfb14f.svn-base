package cn.bnsr.edu_yun.frontstage.resource.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.resource.view.SearchView;
import cn.bnsr.edu_yun.frontstage.train.service.CourseService;
import cn.bnsr.edu_yun.util.NumUtil;

@Controller
@RequestMapping("/search")
public class FileSearchController {
	
	@Autowired
	private CourseService courseService;
	
	@RequestMapping("/search")
	public ModelAndView search(HttpServletRequest request,SearchView searchView) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		if(searchView.getStr()!=null&&!searchView.getStr().equals("")){
		searchView.setRows(10);
		if(searchView.getPage()==0){
			searchView.setStartLine(0);
		}else{
			searchView.setStartLine(searchView.getPage()*searchView.getRows());
		}
		List<SearchView> searchViews = courseService.querySearch(searchView);
		int total = courseService.querySearchCount(searchView);//课程总数
		searchView.setTotal(total);
		//分页总页数
		searchView.setTotalPage(NumUtil.totalPage(total,searchView.getRows()));
		modelAndView.addObject("searchView",searchView);
		modelAndView.addObject("searchViews",searchViews);
		}
		modelAndView.setViewName("frontstage/base/new_search");
		return modelAndView;
		
		
		
		
		
	}

}
