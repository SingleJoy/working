package cn.bnsr.edu_yun.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.json.JSONException;
import org.json.JSONObject;



import cn.bnsr.edu_yun.frontstage.tiku.po.Question;


public class Test2 {

	public static void main(String[] args) {
	String url="http://192.168.10.42:8080/dcs.web/onlinefile?convertType=0&downloadUrl=http://222.128.104.201:8090/group1/M00/00/11/wKgK-1hiCp-ADo6dAAIUzf5FwGw94..doc&isShowList=1&isCopy=1&htmlName=+";
	InputStream is=null;
	try {
		    	  is = new URL(url).openStream();
		      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
		      StringBuilder sb = new StringBuilder();
		      int cp;
		      while ((cp = rd.read()) != -1) {
		        sb.append((char) cp);
		      }
		      String jsonText = sb.toString();
		      JSONObject json = new JSONObject(jsonText);
		      System.out.println(json.toString());
		      System.out.println( json.get("data"));
		    } catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
		      try {
				is.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		     // System.out.println("同时 从这里也能看出 即便return了，仍然会执行finally的！");
		    }
	}
	
	}
