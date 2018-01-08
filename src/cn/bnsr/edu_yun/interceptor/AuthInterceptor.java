package cn.bnsr.edu_yun.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import cn.bnsr.edu_yun.backstage.base.view.SessionInfo;
import cn.bnsr.edu_yun.util.RequestUtil;


/**
 * 权限拦截器
 * @author fangxiongwei
 * @date 2016年9月1日
 */
public class AuthInterceptor extends HandlerInterceptorAdapter{  
	private final Logger log = LoggerFactory.getLogger(AuthInterceptor.class);
	
	/**  
     * 在业务处理器处理请求之前被调用  
     * 如果返回false  
     *     从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链 
     * 如果返回true  
     *    执行下一个拦截器,直到所有的拦截器都执行完毕  
     *    再执行被拦截的Controller  
     *    然后进入拦截器链,  
     *    从最后一个拦截器往回执行所有的postHandle()  
     *    接着再从最后一个拦截器往回执行所有的afterCompletion()  
     */    
    @Override    
    public boolean preHandle(HttpServletRequest request,    
            HttpServletResponse response, Object handler) throws Exception {    
    	log.info("===========AuthInterceptor.preHandle============");    
    	
    	SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute("sessionInfo");
    	if(sessionInfo == null){//没登录不拦截
    		return true;
    	}
    	String requestPath = RequestUtil.getRequestPath(request);
    	log.info("requestPath:"+requestPath);    
    	
    	// 包含doNotNeedSession_不需要验证   ||  admin用户不需要验证权限
 		if (requestPath.indexOf("doNotNeedSession_") != -1||sessionInfo.getUserName().equals("admin")) {
 			return true;
 		}
    	
 		String authUrls = sessionInfo.getAuthUrls();
 		
 		// 判断用户权限url，是包含request请求url
 		if (authUrls.indexOf(requestPath) != -1) {
 		    return true;
 		}else{
            log.info("Interceptor：没有权限！");  
 			request.setAttribute("msg", "<p style='font-size:12px;'>您没有访问此功能的权限！</p><p style='font-size:12px;'>权限路径为[<font style='color:red'><strong>" + requestPath + "</strong></font>]<br/><br/>请联系管理员给你赋予相应权限。</p>");
            request.getRequestDispatcher("/backstage/error/no_auth.jsp").forward(request, response);  
 			return false;
 		}
    }    
    
    /** 
     * 在业务处理器处理请求执行完成后,生成视图之前执行的动作    
     * 可在modelAndView中加入数据，比如当前时间 
     */  
   /* @Override    
    public void postHandle(HttpServletRequest request,    
            HttpServletResponse response, Object handler,    
            ModelAndView modelAndView) throws Exception {     
        log.info("==============执行顺序: 2、postHandle================");    
        if(modelAndView != null){  //加入当前时间    
            modelAndView.addObject("var", "测试postHandle");    
        }    
    }    */
    
    /**  
     * 在DispatcherServlet完全处理完请求后被调用,可用于清理资源等   
     *   
     * 当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion()  
     */    
  /*  @Override    
    public void afterCompletion(HttpServletRequest request,    
            HttpServletResponse response, Object handler, Exception ex)    
            throws Exception {    
        log.info("==============执行顺序: 3、afterCompletion================");    
    }    */
}
