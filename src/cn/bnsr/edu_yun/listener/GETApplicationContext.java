package cn.bnsr.edu_yun.listener;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component 
/*
 *这个注解是一定要的不然当spring初始化的时候不会注入ApplicationContext对象的，
 *当然也可以配置在spring中的bean中*/
public class GETApplicationContext implements ApplicationContextAware{
	private static ApplicationContext applicationContext;
	
	
	public static ApplicationContext getApplicationContext(){
		return applicationContext;
	}
	@Override
	public void setApplicationContext(ApplicationContext arg0) throws BeansException {
		
		applicationContext = arg0;
	}
}