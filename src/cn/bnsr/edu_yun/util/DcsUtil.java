package cn.bnsr.edu_yun.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.Date;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * 
 * @author Li Yajun 永中文档转换调用工具类
 */
public class DcsUtil {

	/**
	 * 
	 * @param url
	 *            原始url
	 * @return 生成url
	 */
	public static String getUrl(String url, String format,String fileUrl) {
		if(fileUrl==null)
		fileUrl = ConfigInfo.getString("file_server_path") + url;
		int convertType = 0;
		if (format.contains("doc") || format.contains("txt") || format.contains("xls") || format.contains("ppt")) {
			convertType = 0;
		} else if (format.contains("pdf")) {
			convertType = 20;
		}else if(format.contains("zip")||format.contains("rar")){
			convertType = 19;
		}else{
			return fileUrl;
		}
		String dcsUrl = ConfigInfo.getString("dcs_path") + "onlinefile?convertType=" + convertType + "&downloadUrl=" + fileUrl
				+ "&isShowList=1&htmlName=+";
		System.out.println(dcsUrl);
		InputStream is = null;
		String lastUrl = "";
		try {
			is = new URL(dcsUrl).openStream();
			BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			StringBuilder sb = new StringBuilder();
			int cp;
		
			while ((cp = rd.read()) != -1) {
				sb.append((char) cp);
			}
			String jsonText = sb.toString();
			JSONObject json = new JSONObject(jsonText);
			lastUrl = json.get("data").toString().replace("[\"", "").replace("\"]", "");
			if (lastUrl != null && !lastUrl.equals("")) {
				RedisUtils.set(url, lastUrl,60*24);
			}
		
			System.out.println(lastUrl);
		} catch (MalformedURLException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		} catch (JSONException e) {

			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {

				e.printStackTrace();
			}

		}
		return lastUrl;
	}

	public static String getUrlRedis(String url, String format) {
		Object redisObject = RedisUtils.get(url);
		if (redisObject != null) {
			System.out.println("已经缓存在Redis了");
			return (String) redisObject;
		} else {
			System.out.println("没有缓存在Redis");
			return getUrl(url, format,null);
		}
	}
	public static String getUrlRedis(String url, String format,String fileUrl) {
		Object redisObject = RedisUtils.get(url);
		if (redisObject != null) {
			System.out.println("已经缓存在Redis了");
			return (String) redisObject;
		} else {
			System.out.println("没有缓存在Redis");
			return getUrl(url, format,fileUrl);
		}
	}
	
}
