package cn.bnsr.edu_yun.backstage.base.controller;

import java.io.File;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.SessionInfo;
import cn.bnsr.edu_yun.frontstage.train.po.CertModelPicture;
import cn.bnsr.edu_yun.frontstage.train.service.CertModelPictureService;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;
import cn.bnsr.edu_yun.util.TimeUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/back_img")
public class BackImgController extends BaseController {
	private final Logger log = LoggerFactory.getLogger(BackImgController.class);
	
	@Autowired
	private CertModelPictureService  certModelPictureService;
	/**
	 *跳转默认图片
	 */
	@RequestMapping("/to_img")
	public ModelAndView toImg(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("backstage/base/img/img");
		try {
			Integer type = Integer.parseInt(request.getParameter("type"));
			CertModelPicture defaultImg = certModelPictureService.getDefaultImg(type);
			mv.addObject("defaultImg", defaultImg);
		} catch (Exception e) {
			log.error("查询默认图片失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return mv;
	}
	
	/**
	 *更新默认图片
	 */
	@RequestMapping("/update_default_img")
	public ModelAndView updateDefaultImg(HttpServletRequest request,CertModelPicture certModelPicture) {
		Integer type = certModelPicture.getType();
		try {
			SessionInfo sessionInfo = (SessionInfo) request.getSession().getAttribute("sessionInfo");
			certModelPicture.setUser_id(sessionInfo.getUserId());
			certModelPicture.setUpload_time(new Date());
			String oldpath = request.getParameter("oldpath");
			certModelPictureService.updateCertModelPicture(certModelPicture);
			String absolutePath = request.getServletContext().getRealPath(oldpath);
			//取出文件的绝对路径，然后用File方法删除相应文件。
			File file = new File(absolutePath);
			if (file.exists()) {
			    file.delete();//删除图片
			}
		} catch (Exception e) {
			log.error("查询默认图片失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/back_img/to_img.action?type="+type);
	}
	
	/**
	 * 删除图片
	 */
	@RequestMapping("/delete_img") 
	public void delete(HttpServletResponse response,HttpServletRequest request) {
		Json j = new Json();
		try {
			String imgpath = request.getParameter("imgpath");
			String absolutePath = request.getServletContext().getRealPath(imgpath);
			//取出文件的绝对路径，然后用File方法删除相应文件。
			File file = new File(absolutePath);
			if (file.exists()) {
			    file.delete();//删除图片
			}
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("图片删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		super.writeJson(j,response);
	}
	
	@RequestMapping("/upload_img")
	public void uploadImg(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,HttpServletResponse response){
		try{
			String realpath = request.getParameter("realpath");
			//上传的路径
			String path = request.getSession().getServletContext().getRealPath(ConfigInfo.getString(realpath));
			Date date=new Date();
			long time=date.getTime();
			String uploadtime = TimeUtil.dateToString2(date);
			String orifileName = file.getOriginalFilename();
		    String fileName = orifileName.substring(0, orifileName.lastIndexOf("."));
			String format=orifileName.substring(orifileName.lastIndexOf("."));
		    Random ra =new Random();
		    fileName = "file"+time+ra.nextInt(10) + format;
			//获取文件--创建一个新文件，添加路径和名称
			File f = new File(path,fileName);
			if(!f.exists()){
				f.mkdirs();
			}
			//保存  
	        try {  
	            file.transferTo(f);  
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
			JSONObject result=new JSONObject();
			result.put("filepath", ConfigInfo.getString(realpath)+"/"+fileName);
			result.put("filename", orifileName);
			result.put("uploadtime",uploadtime);
			ResponseUtil.write(response, result);
		}catch(Exception e){
			e.printStackTrace();
			log.error("上传默认图片失败",ExceptionUtil.getExceptionMessage(e));
		}
	}

}
