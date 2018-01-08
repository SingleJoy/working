package cn.bnsr.edu_yun.frontstage.resource.controller;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.File_comment;
import cn.bnsr.edu_yun.frontstage.resource.po.File_property;
import cn.bnsr.edu_yun.frontstage.resource.service.FileCommentService;
import cn.bnsr.edu_yun.frontstage.resource.service.FilePropertyService;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("/comment")
public class FileCommentController {

	@Autowired
	private FileCommentService fileCommentService;
	@Autowired
	private File_baseService fileBaseService;
	@Autowired
	private FilePropertyService filePropertyService;
	@RequestMapping("/comment")
	public ModelAndView comment(HttpServletRequest request,HttpServletResponse response) throws Exception{
		JSONObject result=new JSONObject();
		String fileBase_id   =	request.getParameter("fileBase_id");
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("currentUser");
		if(user==null){
			result.put("msg", "请登录");
		}else{
			long file_id=Long.parseLong(fileBase_id);
			
			if(fileCommentService.selectCommentByFileIdAndUserId(file_id, user.getId()).size()>0){
				result.put("msg", "已经评论过了");
			
		}else{
		
			String content=request.getParameter("content");
			String score_value=request.getParameter("score_value");
			byte score=Byte.parseByte(score_value);
			File_comment fileComment=new File_comment();
			fileComment.setCallback_id((long) 0);
			fileComment.setComment_time(new Date());
			fileComment.setContent(content);
			fileComment.setFile_id(file_id);
			fileComment.setUser_id(user.getId());
			byte status=1;
			fileComment.setStatus(status);
			fileComment.setScore(score);
			fileCommentService.insert(fileComment);
			result.put("msg", "评论成功");
			List<File_comment> commentList=fileCommentService.selectCommentByFileId(file_id);
			File_base fileBase=fileBaseService.selectById(file_id);
			File_property property=fileBase.getFile_property();
			 property.setId(fileBase.getProperty_id());
		    double totalScore=0;
		    for(File_comment comment:commentList){
		    	totalScore+=comment.getScore();
		    }
		    double score1=totalScore/commentList.size();
		    DecimalFormat   df=new DecimalFormat("#.0"); 
		    score1=Double.parseDouble(df.format(score1));
			property.setScore(score1);
			filePropertyService.update(property);
			
		}
		}
		ResponseUtil.write(response, result);
		return null;

	
	}
}
