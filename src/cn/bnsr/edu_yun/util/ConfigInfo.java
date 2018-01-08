package cn.bnsr.edu_yun.util;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.ResourceBundle;

import org.apache.commons.lang.NumberUtils;


/**
 * 读取配置文件属性工具类
 * @author fangxiongwei
 * @date 2016年12月8日
 */
public class ConfigInfo {
	private static Hashtable<String, String> configInfo;

	  public static String getValue(String key)
	  {
	    if (configInfo == null) {
	      initConfigInfo();
	    }
	    return (String)configInfo.get(key);
	  }

	  public static String getString(String key) {
	    return getValue(key);
	  }

	  public static Integer getInteger(String key) {
	    return NumberUtils.createInteger(getValue(key));
	  }

	  public static Long getLong(String key) {
	    return NumberUtils.createLong(getValue(key));
	  }

	  public static boolean getBoolean(String key){
		    return Boolean.parseBoolean(getValue(key));
	  }
	  private static void initConfigInfo() {
	    ResourceBundle messages = ResourceBundle.getBundle("config");
	    Enumeration<String> e = messages.getKeys();
	    configInfo = new Hashtable<String, String>();
	    while (e.hasMoreElements()) {
	      String key = (String)e.nextElement();
	      String value = messages.getString(key);
	      configInfo.put(key, value);
	    }
	  }
}
