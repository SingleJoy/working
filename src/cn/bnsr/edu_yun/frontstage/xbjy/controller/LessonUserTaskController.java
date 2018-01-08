package cn.bnsr.edu_yun.frontstage.xbjy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonUserTask;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonUserTaskService;
import cn.bnsr.edu_yun.util.ResponseUtil;




@Controller
@RequestMapping("/lesson_user_task")
public class LessonUserTaskController {

	@Autowired
	private LessonUserTaskService lessonUserTaskService;
	
	


	@RequestMapping("/delTeacher")
	public void delTeacher(Long id,HttpServletResponse response,HttpServletRequest request) throws Exception{
		JSONObject result=new JSONObject();
		
		try {
			
			LessonUserTask lessonUserTask =lessonUserTaskService.getById(id);
			//通过主键进行删除
			if(lessonUserTask.getStatus()==0){
			lessonUserTaskService.delTeacher(id);
			result.element("num", 0);
			result.put("msg", "删除成功");
			}else{
			result.element("num", 1);
			result.put("msg", "删除失败");
			}
			
		} catch (Exception e) {
			 result.put("msg", "删除失败");
		}
		ResponseUtil.write(response, result);
	}
	
}
