package cn.bnsr.edu_yun.frontstage.xbjy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonUserIdentity;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonUserIdentityService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonUserIdentityView;
import cn.bnsr.edu_yun.util.ResponseUtil;




@Controller
@RequestMapping("/lesson_user_identity")
public class LessonUserIdentityController {

	@Autowired
	private LessonUserIdentityService lessonUserIdentityService;
	
	

	@RequestMapping("/delete_note")
	public Map<String, Object> deleteNote(String checkedId){
		Map<String, Object> map=new HashMap<String, Object>(); 
		
			lessonUserIdentityService.deleteUser(checkedId);
			map.put("message", "删除成功");  
		    return map; 
	}
	
	
	@RequestMapping("/delete_user")
	public void deleteUser(String checkedId,HttpServletResponse response,HttpServletRequest request) throws Exception{
		JSONObject result=new JSONObject();
		
		try {
			//通过主键对组员进行删除
			lessonUserIdentityService.deleteUser(checkedId);
			result.put("msg", "删除成功");
		} catch (Exception e) {
			 result.put("msg", "删除失败");
		}
		ResponseUtil.write(response, result);
	}
	
	
	//设置撤销指组长
	@RequestMapping("/set_userZz")
	public void setUserZz(String checkedId, LessonUserIdentityView lessonUserIdentityView,HttpServletResponse response,HttpServletRequest request) throws Exception{
		JSONObject result=new JSONObject();
		long id = Long.parseLong(checkedId);
		try {
			
			lessonUserIdentityView.setId(id);
			List<LessonUserIdentityView> lessonUserIdentityViews =lessonUserIdentityService.findUserByIdentity(lessonUserIdentityView);
			if(lessonUserIdentityViews.size()<1){
				
				lessonUserIdentityService.setUserIdentity(lessonUserIdentityView);
			}
			else if(id!=lessonUserIdentityViews.get(0).getId()){
				//将之前的组长撤销后设置新的
				lessonUserIdentityViews.get(0).setIdentity(3);
				lessonUserIdentityService.setUserIdentity(lessonUserIdentityViews.get(0));
				lessonUserIdentityService.setUserIdentity(lessonUserIdentityView);
			}
			else{
				//所选用户已经是组长时撤销
				lessonUserIdentityView.setIdentity(3);
				lessonUserIdentityService.setUserIdentity(lessonUserIdentityView);
			}
			
			result.put("msg", "设置成功");
		} catch (Exception e) {
			 result.put("msg", "设置失败");
		}
		ResponseUtil.write(response, result);
	}
	
	
	//设置撤销指导教师
	@RequestMapping("/set_userZd")
	public void setUserZd(String checkedId, LessonUserIdentityView lessonUserIdentityView,HttpServletResponse response,HttpServletRequest request) throws Exception{
		JSONObject result=new JSONObject();
		String ids[] =checkedId.split(",");
		LessonUserIdentity lessonUserIdentity =new LessonUserIdentity();
		long id;
		try {
			//遍历选中的全部用户
			for(int i = 0;i<ids.length;i++){
				id =Long.parseLong(ids[i]);
				lessonUserIdentityView.setId(id);
				//得到用户在身分表中的身份信息
				lessonUserIdentity=lessonUserIdentityService.getById(Long.parseLong(ids[i]));
				
				//如果用户已经是指导教师，则将用户设成组员，如果用户不是指导教师，则设置为指导教师
				if(lessonUserIdentity.getIdentity()==2){
					lessonUserIdentityView.setIdentity(3);
					lessonUserIdentityService.setUserIdentity(lessonUserIdentityView);
				}else{
					lessonUserIdentityView.setIdentity(2);
					lessonUserIdentityService.setUserIdentity(lessonUserIdentityView);

				}
			}
			result.put("msg", "设置成功");
		} catch (Exception e) {
			 result.put("msg", "设置失败");
		}
		ResponseUtil.write(response, result);
	}
	
	//验证是否存在组长和指导教师
		@RequestMapping("/search_userIdentity")
		public void searchUserIdentity(LessonUserIdentityView lessonUserIdentityView,HttpServletResponse response,HttpServletRequest request) throws Exception{
			JSONObject result=new JSONObject();
			try {
				lessonUserIdentityView.setIdentity(0);
				List<LessonUserIdentityView> lessonUserIdentityZzs =lessonUserIdentityService.findUserByIdentity(lessonUserIdentityView);
				lessonUserIdentityView.setIdentity(2);
				List<LessonUserIdentityView> lessonUserIdentityZds =lessonUserIdentityService.findUserByIdentity(lessonUserIdentityView);

				//至少有一个组长和指导教师
				if(lessonUserIdentityZzs.size()>0&&lessonUserIdentityZds.size()>0){
					result.put("msg", "0");
				}else{
					result.put("msg", "1");
				}
			} catch (Exception e) {
				 result.put("msg", "设置失败");
			}
			ResponseUtil.write(response, result);
		}
	
}
