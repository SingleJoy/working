package cn.bnsr.edu_yun.frontstage.train.controller;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.frontstage.train.po.CertModel;
import cn.bnsr.edu_yun.frontstage.train.po.CertModelPicture;
import cn.bnsr.edu_yun.frontstage.train.service.CertModelPictureService;
import cn.bnsr.edu_yun.frontstage.train.service.CertModelService;
import cn.bnsr.edu_yun.frontstage.train.view.CertModelPictureView;
import cn.bnsr.edu_yun.frontstage.train.view.CertModelView;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;
import cn.bnsr.edu_yun.util.TimeUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/cert_model")
public class CertModelController {

	private final Logger log = LoggerFactory.getLogger(CertModelController.class);
	@Autowired
	private UserService userService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private CertModelPictureService certModelPictureService;
	@Autowired
	private CertModelService certModelService;
	
	/**
	 * 证书管理
	 */
	@RequestMapping("/to_cert_model_manager")
	public ModelAndView toCertModelManager(HttpServletRequest request,CertModelView certModelView){
		User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		String state = request.getParameter("state");//二级分类标识
		String stamp = request.getParameter("stamp");//一级分类标识
		try {
			certModelView.setRows(6);
			if(certModelView.getPage()==0){
				certModelView.setStartLine(0);
			}else{
				certModelView.setStartLine(certModelView.getPage()*certModelView.getRows());
			}
			certModelView.setUser_id(user.getId());
			int total = certModelService.countCertModelView(certModelView);//提问总数
			certModelView.setTotal(total);
			//分页总页数
			certModelView.setTotalPage(NumUtil.totalPage(total,certModelView.getRows()));
			List<CertModelView>  certModelList = certModelService.selectAll(certModelView);
			modelAndView.addObject("certModelView",certModelView);
			modelAndView.addObject("certModelList",certModelList);
			
			UserInfo userInfo = userInfoService.getByUserId(user.getId());
			request.setAttribute("user", user);
			request.setAttribute("userInfo", userInfo);
			//个人中心统计数据  
			UserCenterView userCenter = userService.queryUserCenter(user.getId());
			modelAndView.addObject("userCenter", userCenter);
			modelAndView.addObject("head_title", "证书管理");
			request.setAttribute("state", state);
			request.setAttribute("stamp", stamp);
			modelAndView.setViewName("frontstage/train/cert_model/cert_model_manager");
		} catch (Exception e) {
			log.error("证书模板查询失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
	/**
	 * 创建编辑证书
	 */
	@RequestMapping("/to_create_cert_model")
	public ModelAndView toCreateCertModel(HttpServletRequest request,CertModelView certModelView){
		User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		String state = request.getParameter("state");//二级分类标识
		String stamp = request.getParameter("stamp");//一级分类标识
		String modelId = request.getParameter("id");
		UserCenterView userCenter = userService.queryUserCenter(user.getId());
		modelAndView.addObject("userCenter", userCenter);
		try {
			CertModelPicture cp1 = new CertModelPicture();
			CertModelPicture cp2 = new CertModelPicture();
			if(modelId!=null){
				certModelView = certModelService.queryCertModel(Long.parseLong(modelId));
				cp1 = certModelPictureService.selectOne(certModelView.getNegative_id());
				cp2 = certModelPictureService.selectOne(certModelView.getStamp_id());
			}else{
//				certModelView.setContent("<p style='text-align:center'><span style='font-size:21.0000pt'>[项目名称]</span></p>"+
//                "<p style='text-align:center'><span style='font-size:27.0000pt'><span style='color:#ff8c00'>荣誉证书</span></span></p>"+
//                "<p style='text-align:justify'><span style='font-size:12.0000pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='font-size:12.0000pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 证书编号:[证书编号]</span></p>"+
//                "<p><span style='font-size:12.0000pt'>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</span><span style='font-size:21.0000pt'>&nbsp;&nbsp;&nbsp; [姓名]老师于[起始时间]至[截止时间]参加 [项目名称]学习,共计[学时]</span><span style='font-size:21.0000pt'>学时,成绩[状态],表现突出,特发此证!</span></p>"+
//                "<p>&nbsp;</p>"+
//                "<p style='text-align:justify'><strong><span style='font-size:13.5000pt'><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [颁发部门]</strong></span></strong></p>"+
//                "<p style='text-align:center'><strong><span style='font-size:13.5000pt'><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [颁发时间]</strong></span></strong></p>"
//                );
				cp1 = certModelPictureService.getDefaultImg(0);
				cp2 = certModelPictureService.getDefaultImg(1);
			}
			modelAndView.addObject("cp1", cp1);
			modelAndView.addObject("cp2", cp2);
			modelAndView.addObject("certModel", certModelView);
			//TODO 后期优化 累赘 影响效率
			long user_propertyId=user.getProperty_id();
			UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
		    UserInfo userInfo=	userInfoService.getByUserId(user.getId());
		    request.setAttribute("user", user);
		    request.setAttribute("userProperty", userProperty);
		    request.setAttribute("userInfo", userInfo);
		    modelAndView.addObject("head_title", "新建证书");
			request.setAttribute("state", state);
			request.setAttribute("stamp", stamp);
			modelAndView.setViewName("frontstage/train/cert_model/create_cert_model");
		} catch (Exception e) {
			log.error("跳转创建证书模板失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
	/**
	 * 证书模板图片
	 */
	@RequestMapping("/to_cert_model_picture")
	public ModelAndView toCertModel(HttpServletRequest request,CertModelPictureView certModelPictureView){
		User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		String state = request.getParameter("state");//二级分类标识
		String stamp = request.getParameter("stamp");//一级分类标识
		UserCenterView userCenter = userService.queryUserCenter(user.getId());
		modelAndView.addObject("userCenter", userCenter);
		try {
			certModelPictureView.setUser_id(user.getId());
			certModelPictureView.setRows(10);
			if(certModelPictureView.getPage()==0){
				certModelPictureView.setStartLine(0);
			}else{
				certModelPictureView.setStartLine(certModelPictureView.getPage()*certModelPictureView.getRows());
			}
			int total = certModelPictureService.countCertModelPicture(certModelPictureView);//提问总数
			certModelPictureView.setTotal(total);
			//分页总页数
			certModelPictureView.setTotalPage(NumUtil.totalPage(total,certModelPictureView.getRows()));
			List<CertModelPictureView> certModelPictureList = certModelPictureService.selectAllPicture(certModelPictureView);
			modelAndView.addObject("certModelPictureView",certModelPictureView);
			modelAndView.addObject("certModelPictureList",certModelPictureList);
			//TODO 后期优化 累赘 影响效率
			long user_propertyId=user.getProperty_id();
			UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
		    UserInfo userInfo=	userInfoService.getByUserId(user.getId());
		    request.setAttribute("user", user);
		    request.setAttribute("userProperty", userProperty);
		    request.setAttribute("userInfo", userInfo);
		    modelAndView.addObject("head_title", "模板管理");
			request.setAttribute("state", state);
			request.setAttribute("stamp", stamp);
			modelAndView.setViewName("frontstage/train/cert_model/cert_model_picture");
		} catch (Exception e) {
			log.error("证书模板图片信息查询失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
	@RequestMapping("/upload_img")
	public void uploadImg(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,HttpServletResponse response){
		try{
			String realpath = request.getParameter("realpath");
			//上传的路径
			String path = request.getSession().getServletContext().getRealPath(ConfigInfo.getString(realpath));
			System.out.println(path);
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
			log.error("上传证书模板图片失败",ExceptionUtil.getExceptionMessage(e));
		}
	}
	
	@RequestMapping("/save_cert_model_picture")
	public ModelAndView saveCertModelPicture(HttpServletRequest request,CertModelPicture certModelPicture){
		User user = (User) request.getSession().getAttribute("currentUser");
		certModelPicture.setStatus(0);
		certModelPicture.setUser_id(user.getId());
		try{
			certModelPictureService.saveCertModelPicture(certModelPicture);
		}catch(Exception e){
			e.printStackTrace();
			log.error("保存证书模板图片信息失败",ExceptionUtil.getExceptionMessage(e));
		}
		return new ModelAndView("redirect:/cert_model/to_cert_model_picture.action?stamp=1&state=29&type="+certModelPicture.getType()
				);
	}
	
	@RequestMapping("/query_cert_model_picture")
	@ResponseBody
	public void queryCertModelPicture(HttpServletRequest request,HttpServletResponse response,CertModelPictureView certModelPictureView){
		User user = (User) request.getSession().getAttribute("currentUser");
		try{
			certModelPictureView.setUser_id(user.getId());
			certModelPictureView.setRows(5);
			if(certModelPictureView.getPage()==0){
				certModelPictureView.setStartLine(0);
			}else{
				certModelPictureView.setStartLine(certModelPictureView.getPage()*certModelPictureView.getRows());
			}
			int total = certModelPictureService.countCertModelPicture(certModelPictureView);//提问总数
			certModelPictureView.setTotal(total);
			//分页总页数
			certModelPictureView.setTotalPage(NumUtil.totalPage(total,certModelPictureView.getRows()));
			List<CertModelPictureView> certModelPictureList = certModelPictureService.selectAllPicture(certModelPictureView);
			JSONObject result = new JSONObject();
			result.put("certModelPictureView", certModelPictureView);
			result.element("certModelPictures", certModelPictureList);
			ResponseUtil.write(response, result);
		}catch(Exception e){
			e.printStackTrace();
			log.error("查询证书模板图片信息失败",ExceptionUtil.getExceptionMessage(e));
		}
	}
	
	@RequestMapping("/save_cert_model")
	public ModelAndView saveCertModel(HttpServletRequest request,CertModel certModel){
		User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		String negativeId = request.getParameter("negativeId");
        String negativeTime = request.getParameter("negativeTime");
        String negativeName = request.getParameter("negativeName");
        String negativeImg = request.getParameter("negativeImg");
        String stampId = request.getParameter("stampId");
        String stampTime = request.getParameter("stampTime");
        String stampName = request.getParameter("stampName");
        String stampImg = request.getParameter("stampImg");
		try{
			if(negativeTime==null||negativeName==null||negativeImg==null){
				CertModelPicture cp0 = certModelPictureService.getDefaultImg(0);
				certModel.setNegative_id(cp0.getId());
			}else{
				if(negativeId.length()>0){
					certModel.setNegative_id(Long.parseLong(negativeId));
				}else{
					CertModelPicture cp1 = new CertModelPicture();
					cp1.setName(negativeName);
					cp1.setPath(negativeImg);
					cp1.setUpload_time(TimeUtil.stringFormatDate3(negativeTime));
					cp1.setStatus(0);
					cp1.setType(0);
					cp1.setUser_id(user.getId());
					cp1.setDefaulted(1);
					certModelPictureService.saveCertModelPicture(cp1);
					certModel.setNegative_id(cp1.getId());
				}
			}
			if(stampTime==null||stampName==null||stampImg==null){
				CertModelPicture cp0 = certModelPictureService.getDefaultImg(1);
				certModel.setNegative_id(cp0.getId());
			}else{
				if(stampId.length()>0){
					certModel.setStamp_id(Long.parseLong(stampId));
				}else{
					CertModelPicture cp2 = new CertModelPicture();
					cp2.setName(stampName);
					cp2.setPath(stampImg);
					cp2.setUpload_time(TimeUtil.stringFormatDate3(stampTime));
					cp2.setStatus(0);
					cp2.setType(1);
					cp2.setUser_id(user.getId());
					cp2.setDefaulted(1);
					certModelPictureService.saveCertModelPicture(cp2);
					certModel.setStamp_id(cp2.getId());
				}
				
			}
			certModel.setUpdate_time(new Date());
			if(certModel.getId()!=null){
				certModelService.updateCertModel(certModel);
			}else{
				certModel.setType(1);
				certModel.setUser_id(user.getId());
				certModelService.saveCertModel(certModel);
			}
			modelAndView.setViewName("redirect:/cert_model/to_cert_model_manager.action?stamp=1&state=29");
		}catch(Exception e){
			e.printStackTrace();
			log.error("保存证书模板信息失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
	/**
	 * 展示证书模板
	 */
	@RequestMapping("/to_cert_model_show")
	public ModelAndView toCertModelShow(HttpServletRequest request,CertModelView certModel){
		ModelAndView modelAndView = new ModelAndView();
		String flag = request.getParameter("flag");
		try {
			if(!"1".equals(flag)&&certModel.getId()!=null){
				certModel = certModelService.queryCertModel(certModel.getId());
			}
			modelAndView.addObject("certModel", certModel);
			modelAndView.addObject("head_title", "证书预览");
			modelAndView.setViewName("frontstage/train/cert_model/cert_model_show");
		} catch (Exception e) {
			log.error("证书模板图片信息查询失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
	@RequestMapping("/del_cert_model")
	public ModelAndView delCertModel(HttpServletRequest request,Long id){
		ModelAndView modelAndView = new ModelAndView();
		try{
			certModelService.deleteCertModel(id);
			modelAndView.setViewName("redirect:/cert_model/to_cert_model_manager.action?stamp=1&state=29");
			
		}catch(Exception e){
			e.printStackTrace();
			log.error("删除证书模板信息失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
	@RequestMapping("/del_cert_model_picture")
	public ModelAndView delCertModelPicture(HttpServletRequest request,Long id,int type){
		ModelAndView modelAndView = new ModelAndView();
		try{
			certModelPictureService.deleteCertModelPicture(id);
			modelAndView.setViewName("redirect:/cert_model/to_cert_model_picture.action?type="+type+"&stamp=1&state=29");
		}catch(Exception e){
			e.printStackTrace();
			log.error("删除证书图片失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
	@RequestMapping("/query_cert_model")
	@ResponseBody
	public void queryCertModel(HttpServletRequest request,HttpServletResponse response,CertModelView certModelView){
		User user = (User) request.getSession().getAttribute("currentUser");
		try{
			certModelView.setUser_id(user.getId());
			certModelView.setRows(5);
			if(certModelView.getPage()==0){
				certModelView.setStartLine(0);
			}else{
				certModelView.setStartLine(certModelView.getPage()*certModelView.getRows());
			}
			int total = certModelService.countCertModelView(certModelView);
			certModelView.setTotal(total);
			//分页总页数
			certModelView.setTotalPage(NumUtil.totalPage(total,certModelView.getRows()));
			List<CertModelView> certModelList = certModelService.selectAll(certModelView);
			JSONObject result = new JSONObject();
			result.put("certModelView", certModelView);
			result.element("certModelList", certModelList);
			ResponseUtil.write(response, result);
		}catch(Exception e){
			e.printStackTrace();
			log.error("查询证书模板图片信息失败",ExceptionUtil.getExceptionMessage(e));
		}
	}
	
	@RequestMapping("/review_cert_model")
	@ResponseBody
	public void reviewCertModel(HttpServletResponse response,Long id){
		try{
			JSONObject result = new JSONObject();
			CertModelView certModel = certModelService.queryCertModel(id);
			result.put("certModel", certModel);
			ResponseUtil.write(response, result);
		}catch(Exception e){
			e.printStackTrace();
			log.error("预览证书模板信息失败",ExceptionUtil.getExceptionMessage(e));
		}
	}
	
	/**
	 * 展示证书底板印章
	 */
	@RequestMapping("/to_cert_model_img_show")
	public ModelAndView toCertModelImgShow(HttpServletRequest request,Long id){
		ModelAndView modelAndView = new ModelAndView();
		try {
			CertModelPicture modelimg = certModelPictureService.selectOne(id);
			modelAndView.addObject("picture", modelimg);
			modelAndView.setViewName("frontstage/train/cert_model/cert_model_img_show");
			modelAndView.addObject("head_title", "证书底板印章");
		} catch (Exception e) {
			log.error("证书模板图片信息查询失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelAndView;
	}
	
}
