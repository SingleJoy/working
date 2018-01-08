package cn.bnsr.edu_yun.backstage.base.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.imageio.ImageIO;
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

import cn.bnsr.edu_yun.backstage.base.po.DefaultImg;
import cn.bnsr.edu_yun.backstage.base.service.DefaultImgService;
import cn.bnsr.edu_yun.backstage.base.view.DefaultImgView;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.SessionInfo;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;
import cn.bnsr.edu_yun.util.TimeUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/back_default_img")
public class BackDefaultImgController extends BaseController {

    private final Logger log = LoggerFactory.getLogger(BackDefaultImgController.class);
	
	@Autowired
	private DefaultImgService  defaultImgService;
	/**
	 *跳转课程管理页面
	 */
	@RequestMapping("/to_back_default_img")
	public ModelAndView toBackCourse(){
		return new ModelAndView("backstage/base/img/default_img");
	}
	
	/**
	 * 获得课程管理datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,
			HttpServletRequest request, DefaultImgView defaultImgView) {
		super.writeJson(defaultImgService.datagrid(defaultImgView),response);
	}
	
	
	/**
	 *跳转添加默认图片页面
	 */
	@RequestMapping("/to_default_img_add")
	public ModelAndView toWorkshopAdd(String see,Long id) {
		ModelAndView mv = new ModelAndView("backstage/base/img/default_img_add");
		if(id!=null){
			DefaultImg img = defaultImgService.selectOne(id);
			mv.addObject("defaultImg", img);
		}
		if(see!=null&&see.length()>0){
			mv.addObject("see", see);
		}
		return mv;
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
    		BufferedImage bufferedImg = ImageIO.read(new FileInputStream(f));
    		if(bufferedImg!=null){
    			Map<String, String> m = new HashMap<String,String>();
    			m.put("imgWidth", bufferedImg.getWidth()+"");
    			m.put("imgHeight", bufferedImg.getHeight()+"");
    			result.put("fileinfo",m);
    		}
			result.put("filepath", ConfigInfo.getString(realpath)+"/"+fileName);
			result.put("filename", orifileName);
			result.put("uploadtime",uploadtime);
			ResponseUtil.write(response, result);
		}catch(Exception e){
			e.printStackTrace();
			log.error("上传默认图片失败",ExceptionUtil.getExceptionMessage(e));
		}
	}
	
	/**
	 * 获取最大序号
	 * @throws Exception 
	 */
	@RequestMapping("/get_max_seq")
	public void getMaxSeq(HttpServletResponse response,DefaultImg img){
	    
		Json j = new Json();
		try{
			Integer seq = defaultImgService.getMaxSeq(img);
			if(seq!=null){
				j.setObj(seq+1);
			}else{
				j.setObj(1);
			}
			j.setSuccess(true);
			j.setMsg("操作成功！");
		} catch (Exception e) {
			log.error("获取序号操作失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("操作失败！");
		}
		super.writeJson(j,response);
	}
	
	
	/**
	 * 更新序号
	 * @throws Exception 
	 */
	@RequestMapping("/update_img")
	public void updateImg(HttpServletRequest request,HttpServletResponse response,DefaultImg img){
		SessionInfo sessionInfo = (cn.bnsr.edu_yun.backstage.base.view.SessionInfo) request.getSession().getAttribute("sessionInfo");
		Json j = new Json();
		try{
			if(sessionInfo!=null){
				img.setUser_id(sessionInfo.getUserId());
			}
			defaultImgService.updateImg(img);
			j.setSuccess(true);
			j.setMsg("更新成功！");
		} catch (Exception e) {
			log.error("更新失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("更新失败！");
		}
		super.writeJson(j,response);
	}
	
	
	/**
	 * 保存
	 * @throws Exception 
	 */
	@RequestMapping("/add_default_img")
	public void addDefaultImg(HttpServletRequest request,HttpServletResponse response,DefaultImg img){
		SessionInfo sessionInfo = (cn.bnsr.edu_yun.backstage.base.view.SessionInfo) request.getSession().getAttribute("sessionInfo");
		Json j = new Json();
		try{
			if(sessionInfo!=null){
				img.setUser_id(sessionInfo.getUserId());
			}
			img.setStatus(0);
			defaultImgService.saveImg(img);
			j.setSuccess(true);
			j.setMsg("保存成功！");
		} catch (Exception e) {
			log.error("保存失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("保存失败！");
		}
		super.writeJson(j,response);
	}
}
