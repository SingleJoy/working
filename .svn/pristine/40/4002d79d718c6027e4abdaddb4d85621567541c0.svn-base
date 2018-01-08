package cn.bnsr.edu_yun.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
/**
 * request 工具类
 * 处理一些数据
 * @author fangxiongwei
 * @date 2016年9月1日
 */
public class RequestUtil {
	/**
	 * 获得请求路径
	 * 
	 * @param request
	 * @return
	 */
	public static String getRequestPath(HttpServletRequest request) {
		String requestPath = request.getRequestURI();
		requestPath = requestPath.substring(request.getContextPath().length());// 去掉项目路径
		return requestPath;
	}
	
	/**
	 * 
	 * 获取str在string中第n次出现的位置
	 * @param string
	 * @param str
	 * @param n
	 * @return
	 */
	public static int getCharacterPosition(String string,String str,int n){
	    Matcher slashMatcher = Pattern.compile(str).matcher(string);
	    int mIdx = 0;
	    while(slashMatcher.find()) {
	       mIdx++;
	       //当str第n次出现的位置
	       if(mIdx == n){
	          break;
	       }
	    }
	    return slashMatcher.start();
	 }

	/**
	 * 获取request
	 */
	public static HttpServletRequest getHttpServletRequest(){
	    RequestAttributes ra = RequestContextHolder.getRequestAttributes();  
	    ServletRequestAttributes sra = (ServletRequestAttributes)ra;  
	    HttpServletRequest request = sra.getRequest();
	    return request;
	}
}
