package cn.bnsr.edu_yun.backstage.app.controller;

import java.io.File;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.base.view.PageBase;
import cn.bnsr.edu_yun.frontstage.app.po.AppVersion;
import cn.bnsr.edu_yun.frontstage.app.service.AppVersionService;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;
import cn.bnsr.edu_yun.util.TimeUtil;

@Controller
@RequestMapping("/back_app")
public class BackAppController extends BaseController {

	@Autowired
	private AppVersionService appVersionService;

	@RequestMapping("/to_app_version")
	public ModelAndView app_version(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("backstage/app/app_version");
	}

	/**
	 * 获得datagrid
	 * 
	 * @throws Exception
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response, PageBase pageBase) throws Exception {
		super.writeJson(appVersionService.datagrid(pageBase), response);
	}

	@RequestMapping("/upload_app")
	public void uploadImg(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response,
			String type, String describe) {
		try {
			AppVersion appVersion = appVersionService.selectNew();
			if(appVersion==null){
				appVersion=new AppVersion();
				appVersion.setMajor(0);
				appVersion.setMinor(0);
				appVersion.setMaintenance(0);
			}
			appVersion.setDescribe(describe);
			if (type.equals("1")) {
				//主
				int major=appVersion.getMajor();
				appVersion.setMajor(major+1);
				appVersion.setMinor(0);
				appVersion.setMaintenance(0);
			} else if (type.equals("2")) {
				//次
				int minor=appVersion.getMinor();
				appVersion.setMinor(minor+1);
				appVersion.setMaintenance(0);
			} else if (type.equals("3")) {
				//维护
				int maintenance=appVersion.getMaintenance();
				appVersion.setMaintenance(maintenance+1);
			}
			String version_name=appVersion.getMajor()+"."+appVersion.getMinor()+"."+appVersion.getMaintenance();
			appVersion.setVersion_name(version_name);
			String realpath = "appUrl";
			String appName = ConfigInfo.getString("appName");
			// 上传的路径
			String path = request.getSession().getServletContext().getRealPath(ConfigInfo.getString(realpath));
			String fileName = appName +version_name+ ".apk";
			appVersion.setVersion_time(new Date());
			appVersionService.insert(appVersion);
			// 获取文件--创建一个新文件，添加路径和名称
			File f = new File(path, fileName);
			if (!f.exists()) {
				f.mkdirs();
			}
			// 保存
			try {
				file.transferTo(f);
			} catch (Exception e) {
				e.printStackTrace();
			}
			JSONObject result = new JSONObject();

			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();

		}
	}
}