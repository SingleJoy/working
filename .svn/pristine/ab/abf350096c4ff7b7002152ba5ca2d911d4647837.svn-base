package cn.bnsr.edu_yun.frontstage.app.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.bnsr.edu_yun.frontstage.app.po.AppVersion;
import cn.bnsr.edu_yun.frontstage.app.service.AppVersionService;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("/app")
public class AppController {

	@Autowired
	private AppVersionService appVersionService;
	
	@RequestMapping("/app_version")
	public void app_version(HttpServletRequest request,HttpServletResponse response) throws Exception {
		AppVersion appVersion = appVersionService.selectNew();
		JSONObject result = new JSONObject();
		if(appVersion!=null){
			String version_name=appVersion.getVersion_name();
			result.put("version", version_name);
			//url
			appVersion.setVersion_name(version_name);
			String realpath = "appUrl";
			String appName = ConfigInfo.getString("appName");
			// 上传的路径
			String path = ConfigInfo.getString(realpath);
			String url =path+"/"+appName +version_name+ ".apk";
			result.put("url", url);
		}
		
		
		ResponseUtil.write(response, result);
	}
}
