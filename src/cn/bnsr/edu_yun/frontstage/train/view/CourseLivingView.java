package cn.bnsr.edu_yun.frontstage.train.view;

import java.lang.reflect.Field;

public class CourseLivingView {

	private String user_cipher="d93d08d53dd0aeb05a3ab03d5ee8230e"; 	 	//密钥 	联系布卡客服获取 	不能为空
	private String teacher_phone_num;	 	//主讲手机号 		可以不填，不填则自己为主讲
	private String teacher_user_name; 	 	//主讲账号，主讲手机号为空时有效 		可以不填，不填则自己为主讲
	private String name; 	 	//房间名称 	用于显示 	不能为空
	private String description; 	 	//房间描述 		可以为空
	private int  type=1; 	//房间类型 	1、视频模式 2、ppt模式 	可以为空，默认为1
	private int encryption=3; 	 	//加密类型 	0、公开 1、密码验证 2、白名单验证 3、回调验证 	可以为空，默认为0
	private String role_encryption; 	 	//不同权限加密类型 	详细见下面备注 	可以为空
	private String password; 	 	//房间密码 	密码验证方式有效 	不能为空
	private String  callback_url="http://www.buka.tv/room/callback.do";		//回调地址 	回调验证方式有效 	不能为空
	
	
	public String getUser_cipher() {
		return user_cipher;
	}
	public void setUser_cipher(String user_cipher) {
		this.user_cipher = user_cipher;
	}
	public String getTeacher_phone_num() {
		return teacher_phone_num;
	}
	public void setTeacher_phone_num(String teacher_phone_num) {
		this.teacher_phone_num = teacher_phone_num;
	}
	public String getTeacher_user_name() {
		return teacher_user_name;
	}
	public void setTeacher_user_name(String teacher_user_name) {
		this.teacher_user_name = teacher_user_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getEncryption() {
		return encryption;
	}
	public void setEncryption(int encryption) {
		this.encryption = encryption;
	}
	public String getRole_encryption() {
		return role_encryption;
	}
	public void setRole_encryption(String role_encryption) {
		this.role_encryption = role_encryption;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCallback_url() {
		return callback_url;
	}
	public void setCallback_url(String callback_url) {
		this.callback_url = callback_url;
	}
	public String getStr(CourseLivingView courseLivingView){
		 String str="";
		  Field[] fields = courseLivingView.getClass().getDeclaredFields();  
	        for (int j = 0; j < fields.length; j++) {  
	        	fields[j].setAccessible(true);  
	            // 字段名  
	          try {
	        	  if(fields[j].get(courseLivingView)!=null){
	        			if(j!=0){
	   	        		 str+="&";
	   	        	}
	        		  str+=fields[j].getName()+"=";
	        		  str+=fields[j].get(courseLivingView);
	        	  }
	            	
				} catch (IllegalArgumentException | IllegalAccessException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}  
	           
	            // 其他类型。。。  
	        }  
	      
	    return str.trim();
		
	}
	
}
