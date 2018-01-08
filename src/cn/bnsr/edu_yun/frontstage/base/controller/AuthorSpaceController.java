package cn.bnsr.edu_yun.frontstage.base.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.User_attent;
import cn.bnsr.edu_yun.frontstage.base.service.AuthorSpaceService;
import cn.bnsr.edu_yun.frontstage.base.service.UserAttentService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.service.FilePropertyService;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.resource.view.FileView;
import cn.bnsr.edu_yun.util.NumUtil;

/**
 * 作者空间（教师主页）
 * @author fangxiongwei
 * @date 2016年8月15日
 */
@Controller
@RequestMapping("/author_space")
public class AuthorSpaceController {

	@Autowired
	private AuthorSpaceService authorSpaceService;
	@Autowired
	private File_baseService fileBaseService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private FilePropertyService filePropertyService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserAttentService userAttentService;
	
	/**
	 * 跳转教师主页
	 */
	@RequestMapping("/to_author_space")
	public ModelAndView toAutherSpace(HttpServletRequest request) throws Exception {
		
		String userId= request.getParameter("userId");
		ModelAndView modelAndView = new ModelAndView();
		FileView fileView = new FileView();
		User user = userService.selectByUserId(Long.parseLong(userId));
		fileView.setUserId(userId);
		fileView.setUserIcon(user.getIcon());
		fileView.setUserName(user.getUsername());
		fileView.setPage(0);
		fileView.setRows(8);
		fileView.setType("0");
		fileView.setIsNot("true");
		
		User sessionUser = (User) request.getSession().getAttribute("currentUser");
		if(sessionUser != null){
			User_attent userAttent = userAttentService.selectattent(sessionUser.getId(), Long.parseLong(userId));
			modelAndView.addObject("attented",userAttent);
		}

		modelAndView.addObject("fileView", fileView);
		modelAndView.setViewName("frontstage/base/author_space/author_space");
		
		return modelAndView;
	}
	
	@RequestMapping("/query_user_file")
	public ModelAndView queryUserFile(HttpServletRequest request,FileView fileView) throws Exception{
		Long userId = Long.parseLong(fileView.getUserId());
		//教师信息
		UserInfo userInfo = userInfoService.getByUserId(userId);
		if(fileView.getPage()==0){
			fileView.setStartLine(0);
		}else{
			fileView.setStartLine(fileView.getPage()*fileView.getRows());
		}
		//教师主页文档列表
		List<FileView> fileList = fileBaseService.queryUserFile(fileView);
		//热门文档
		List<File_base> fileBaseList = fileBaseService.queryHotFile();
		//最新关注
		List<User> userList = userService.queryNewAttent(userId);
		if(fileList.size()>0){
			List<String> proIds = new ArrayList<String>();
			for(FileView fv : fileList){
				if(fv.getPropertyId()!=null){
					proIds.add(fv.getPropertyId());
				}
			}
			if(proIds.size()>0){
				//根据附加属性ids查询用户所有文件下载、浏览量
				FileView fview = filePropertyService.queryCount(proIds);
				fileView.setBrowseNum(fview.getBrowseNum());
				fileView.setDownloadNum(fview.getDownloadNum());
			}else{
				fileView.setBrowseNum(0);
				fileView.setDownloadNum(0);
			}
			int total = fileBaseService.getTotalFile(fileView);//文件总数
			fileView.setTotal(total);
			//分页总页数
			fileView.setTotalPage(NumUtil.totalPage(total,20));
			fileView.setIsNot("false");
		}
		//综合评分
		double scoreNum = filePropertyService.querScoreNum(userId);
		fileView.setScoreNum(scoreNum);
		
		ModelAndView modelAndView = new ModelAndView();

		User sessionUser = (User) request.getSession().getAttribute("currentUser");
		if(sessionUser != null){
			User_attent userAttent = userAttentService.selectattent(sessionUser.getId(),userId);
			modelAndView.addObject("attented",userAttent);
		}
		modelAndView.addObject("userInfo",userInfo);
		modelAndView.addObject("fileView", fileView);
		modelAndView.addObject("fileList",fileList);
		modelAndView.addObject("userList",userList);
		modelAndView.addObject("fileBaseList",fileBaseList);
		modelAndView.setViewName("frontstage/base/author_space/author_space");
		return modelAndView; 
	}
}

