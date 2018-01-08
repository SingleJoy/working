package cn.bnsr.edu_yun.util;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 
 * @author fangxiongwei
 * @date 2017年6月24日
 */
@Target(ElementType.METHOD)//注解会在class中存在，运行时可通过反射获取    
@Retention(RetentionPolicy.RUNTIME)   //目标是方法     
@Documented //文档生成时，该注解将被包含在javadoc中，可去掉   
@Inherited    
public @interface UserLog {  
	/** 
     * 日志描述 
     * @return 
     */  
    public String description() default "no description"; 
    /** 
     * 日志类型 
     * @return 
     * 1：用户登录日志；2：用户操作日志
     */  
    public int type() default 0;
    /** 
     * 日志请求URL
     * @return 
     */  
    public String do_url() default "no do_url";
    /** 
     * 日志来源
     * @return 
     * 1 PC，2 IOS，3 Android
     */  
    public String do_from() default "no do_from";
    /**
     * 操作id
     */
    public String do_id() default "";
    /**
     * 操作id类型：1-
     */
    public int do_type() default 0;
}  
