package cn.bnsr.edu_yun.frontstage.base.controller;

import java.io.InputStream;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.csource.common.NameValuePair;
import org.csource.fastdfs.ClientGlobal;
import org.csource.fastdfs.StorageClient1;
import org.csource.fastdfs.StorageServer;
import org.csource.fastdfs.TrackerClient;
import org.csource.fastdfs.TrackerServer;
import org.csource.fastdfs.UploadStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import cn.bnsr.edu_yun.frontstage.base.po.UploadFile;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.service.UploadFileService;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;

/**
 * 上传文件管理
 * @author heliwei
 * @date 2017-12-06
 */
@Controller
@RequestMapping("/upload_file")
public class UploadFileController {
	private final Logger log = LoggerFactory.getLogger(UploadFileController.class);
	@Autowired
	private UploadFileService uploadFileService;
	/**
	 * 上传资源
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("upload_resource")
	public void uploadImgTxtFile(HttpServletRequest request,HttpServletResponse response)throws Exception{
		try{
			User user = (User)request.getSession().getAttribute("currentUser");
			Long source_id = Long.parseLong(request.getParameter("source_id"));
			Integer source_type = Integer.parseInt(request.getParameter("source_type"));
			CommonsMultipartResolver comMultResolver = new CommonsMultipartResolver(request.getServletContext());
			if(comMultResolver.isMultipart(request)){
				MultipartHttpServletRequest multRequest = (MultipartHttpServletRequest)request;
				Iterator<String> fileItera = multRequest.getFileNames();
				while(fileItera.hasNext()){
					MultipartFile multfile = multRequest.getFile(fileItera.next());
					if(!multfile.isEmpty()){
						String fileName = multfile.getOriginalFilename();
						ClassPathResource classPathRes = new ClassPathResource("fdfs_client.conf");
						String configRealPath = classPathRes.getClassLoader().getResource("fdfs_client.conf").getPath();
						ClientGlobal.init(configRealPath);
						long multFileSize = multfile.getSize();
						InputStream in = multfile.getInputStream();
						UploadStream uploadSteam = new UploadStream(in, multFileSize);
						String fileId = "";
						String fileExtName = fileName.substring(fileName.lastIndexOf("."));
						TrackerClient trackerClient = new TrackerClient();
						TrackerServer trackerService = trackerClient.getConnection();
						StorageServer storageServer = null;
						StorageClient1 storageClient1 = new StorageClient1(trackerService,storageServer);
						NameValuePair[] metaList = new NameValuePair[3];
						metaList[0] = new NameValuePair("fileName", fileName);
						metaList[1] = new NameValuePair("fileExtName",fileExtName);
						metaList[2] = new NameValuePair("fileLength",String.valueOf(multFileSize));
						fileId = storageClient1.upload_file1("group1", multFileSize, uploadSteam, fileExtName, metaList);
						int split_index = fileName.lastIndexOf(".");
						String file_name = fileName.substring(0,split_index);
						String file_extname = fileName.substring(split_index+1);
						UploadFile uploadFile = new UploadFile();
						uploadFile.setName(fileName);
						uploadFile.setSource_id(source_id);
						uploadFile.setSource_type(source_type);
						uploadFile.setPath(fileId);
						uploadFile.setUser_id(user.getId());
						uploadFile.setUpload_time(new Date());
						uploadFile.setSize(NumUtil.toSize(multFileSize));
						uploadFile.setFile_name(file_name);
						uploadFile.setFile_extname(file_extname);
						uploadFileService.save(uploadFile);
						JSONObject result = new JSONObject();
						result.put("errno", 0);
						String[] paths = new String[1];
						paths[0] = ConfigInfo.getString("file_server_path")+fileId;
						result.put("data", paths);
						ResponseUtil.write(response, result);
					}
				}
			}
		}catch(Exception e){
			log.error("上传资源："+ExceptionUtil.getExceptionMessage(e));
			JSONObject err_result = new JSONObject();
			err_result.put("errno", 1);
			ResponseUtil.write(response, err_result);
		}
	}
}
