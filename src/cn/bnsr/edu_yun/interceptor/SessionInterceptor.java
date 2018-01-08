package cn.bnsr.edu_yun.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.service.NotificationService;
import cn.bnsr.edu_yun.frontstage.base.service.PrivateLetterService;
import cn.bnsr.edu_yun.frontstage.base.view.NotificationView;
import cn.bnsr.edu_yun.frontstage.base.view.PrivateLetterView;
import cn.bnsr.edu_yun.util.RequestUtil;

/**
 * session拦截器
 * @author fangxiongwei
 * @date 2016年9月4日
 */
public class SessionInterceptor extends HandlerInterceptorAdapter{  
	private final Logger log = LoggerFactory.getLogger(SessionInterceptor.class);
    @Autowired
    private NotificationService notificationService;
    @Autowired
	private PrivateLetterService privateLetterService;
    @Override    
    public boolean preHandle(HttpServletRequest request,    
            HttpServletResponse response, Object handler) throws Exception {    
    	log.info("===========SessionInterceptor.preHandle============");    
    	String requestPath = RequestUtil.getRequestPath(request);
    	System.out.println(requestPath);
    	User currentUser = (User) request.getSession().getAttribute("currentUser");
    	if(currentUser == null){//没登录拦截
    		log.info("Interceptor：没有登录！");  
    		
    		//不包含拦截/to_train_center to_train_detail to_community_index to_workshop_index
    		boolean flag=true;
    		String[] str={"course_study/studyed","to_course_study","to_course_center","user_study/ajax_","to_train_home","to_train_center","to_train_detail","to_community_index","to_community_home","ajax_","to_workshop_home","userFile/to_file","see.action","class/selectOne","to_course_center_m","to_classify_m","to_course_m", "to_course_m_profile", "to_class_m", "to_course_hour_m","to_course_apprise_m","appraise_m","join_study_m","to_user_study_m","to_study_m","to_question_m","put_question_m","read_question_m","note_m","hour_list_m","agree_m","get_note_m",
    				"put_answer_m","user_study_m","my_exam_m","my_note_m","my_topic_m","user_m","collect_m","notice_m","search_m","save_discuss","finish_homework","to_study_again_m","get_dcs","do_late","ajax_insert","/app/"};
            for(String s:str){
            	if(requestPath.indexOf(s)>0){
            		flag=false;
            		break;
            	}
            }
    		if(flag){
    			 request.getRequestDispatcher("../return.jsp").forward(request, response); 
    			 return false;
    		 }
    	}else{
    		NotificationView notificationView=new NotificationView();
    		notificationView.setUser_id(currentUser.getId());
    		HttpSession session=request.getSession();
			session.setAttribute("notification_num", notificationService.queryNoReadCount(notificationView));
			PrivateLetterView privateLetterView=new PrivateLetterView();
			privateLetterView.setUser_id(currentUser.getId());
			session.setAttribute("privateLetter_num", privateLetterService.queryPrivateLetterNotReaddCount(privateLetterView));
			
			
    	}
            
 		return true;
    }   
    public static void main(String[] args) {
    	String[] str={"course_study/studyed","to_course_study","to_course_center","user_study/ajax_","to_train_home","to_train_center","to_train_detail","to_community_index","to_community_home","ajax_","to_workshop_home","userFile/to_file","see.action","class/selectOne","to_course_center_m","to_classify_m","to_course_m", "to_course_m_profile", "to_class_m", "to_course_hour_m","to_course_apprise_m","appraise_m","join_study_m","to_user_study_m","to_study_m","to_question_m","put_question_m","read_question_m","note_m","hour_list_m","agree_m","get_note_m",
    			"put_answer_m","user_study_m","my_exam_m","my_note_m","my_topic_m","user_m","collect_m","notice_m","search_m","save_discuss","finish_homework","to_study_again_m","get_dcs","do_late","ajax_insert","/app/"};
    	String requestPath="/user_study_time/ajax_insert.action";
    boolean flag = true;
    	for(String s:str){
        	
    		if(requestPath.indexOf(s)>0){
        		flag=false;
        		break;
        	}
        }
    	System.out.println(flag);
	}
  
}

