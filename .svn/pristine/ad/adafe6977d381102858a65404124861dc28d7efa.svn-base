package cn.bnsr.edu_yun.frontstage.base.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.csource.common.NameValuePair;
import org.csource.fastdfs.ClientGlobal;
import org.csource.fastdfs.StorageClient1;
import org.csource.fastdfs.StorageServer;
import org.csource.fastdfs.TrackerClient;
import org.csource.fastdfs.TrackerServer;
import org.csource.fastdfs.UploadStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.File_catalog;
import cn.bnsr.edu_yun.frontstage.resource.po.File_label;
import cn.bnsr.edu_yun.frontstage.resource.po.File_property;
import cn.bnsr.edu_yun.frontstage.resource.po.File_value;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file_log;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.resource.service.File_catalogService;
import cn.bnsr.edu_yun.frontstage.resource.service.LogService;
/**
 * 文件上传Controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/upload")
public class UploadController {
	@Autowired
	private File_catalogService catalogService;
	@Autowired
	private File_baseService  file_baseService;
	@Autowired
	private UserService userService;
	@Autowired
	private LogService logService;
	/**
	 * 文件上传
	 * @param request
	 * @return
	 * @throws Exception 
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	    @RequestMapping("/upload")
		public void upLoad(HttpServletRequest request) throws FileNotFoundException, IOException, Exception{
			//上传部分，IO操作
			//创建一个通用的多部分解析器  
		    CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
		    //判断 request 是否有文件上传,即多部分请求  
		    if(multipartResolver.isMultipart(request)){  
		        //转换成多部分request    
		    	   MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;  
		        //取得request中的所有文件名  
		        Iterator<String> iter = multiRequest.getFileNames();  
		        
		        System.out.println(iter.hasNext());
		        while(iter.hasNext()){  
		            //取得上传文件
		            MultipartFile file = multiRequest.getFile(iter.next());  
		            int pre = (int) System.currentTimeMillis();  
		     
		     //       UploadResponse res = new UploadResponse();  
		           
		                if(file.isEmpty()){  
		                //    res.setRet_code(UserCodeEnum.ERR_FILE_NULL.getCode());  
		            //        res.setRet_msg(UserCodeEnum.ERR_FILE_NULL.getDesc());  
		                
		                }else{  
		                     String tempFileName = file.getOriginalFilename();  
		                     System.out.println("第一个路径"+tempFileName);
		                     //fastDFS方式  
		                     ClassPathResource cpr = new ClassPathResource("fdfs_client.conf");  
		                     ClientGlobal.init(cpr.getClassLoader().getResource("fdfs_client.conf").getPath());  
		                     long fileLength = file.getSize();
		                     InputStream inStream = file.getInputStream();
		             		UploadStream uploadStream = new UploadStream(inStream, fileLength);
		                    // byte[] fileBuff = file.getBytes();  
		                     String fileId = "";  
		                     String fileExtName = tempFileName.substring(tempFileName.lastIndexOf("."));  
		                     System.out.println("第二个路径"+fileExtName);
		                     //建立连接  
		                     TrackerClient tracker = new TrackerClient();  
		                     TrackerServer trackerServer = tracker.getConnection();  
		                     StorageServer storageServer = null;  
		                     StorageClient1 client = new StorageClient1(trackerServer, storageServer);  
		                       
		                     //设置元信息  
		                     NameValuePair[] metaList = new NameValuePair[3];  
		                     metaList[0] = new NameValuePair("fileName", tempFileName);  
		                     metaList[1] = new NameValuePair("fileExtName", fileExtName);  
		                     metaList[2] = new NameValuePair("fileLength", String.valueOf(file.getSize()));  
		                       
		                     //上传文件  
		                     fileId = client.upload_file1("group1", fileLength, uploadStream, fileExtName, metaList);
		                       
		                     System.out.println(fileId);
		                     int finaltime = (int) System.currentTimeMillis();  
		                     System.out.print("用时：");
		                     System.out.println(finaltime - pre); 
		                     String title=request.getParameter("title");
		         		    String profile=request.getParameter("profile");
		         		    String label=request.getParameter("label");
		         		    String column_id=request.getParameter("column_id");
		         		    String type=request.getParameter("type");
		         		    
		         			//存入数据库部分，insert
		         			
		         		    //property
		         		    File_property fileProperty=new File_property();
		         		    fileProperty.setClick_times(0);
		         		    fileProperty.setCollection_times(0);
		         		    fileProperty.setDownload_times(0);
		         		    file_baseService.insertFileProperty(fileProperty);
		         		  
		         		    //value
		         		    File_value fileValue=new File_value();
		         		    long value=0;
		         		    fileValue.setFile_amount(value);
		         		    fileValue.setFile_score(value);
		         		    file_baseService.insertFileValue(fileValue);
		         		 //filebase
		         		    File_base fileBase=new File_base();
		         		    fileBase.setFilename(tempFileName);
		         		   fileBase.setPath("http://192.168.10.253:8080/"+fileId);
		         		  long length=file.getSize();
		                    fileBase.setLength(length);
		                     if(length<1024){
		                    	fileBase.setSize(length+"B");
		                    }else if(length<1024*1024){
		                    	fileBase.setSize(length*100/1024/100.0+"KB");
		                    }else if(length<1024*1024*1024){
		                    	fileBase.setSize(length*100/1024/1024/100.0+"MB");
		                    }else{
		                    	fileBase.setSize(length*100/1024/1024/1024/100.0+"GB");
		                    }
		                     Date date =new Date();
		                   fileBase.setUpload_time(date);
		                   //测试用户
		                   long userId=28;
		                   fileBase.setUpload_user(userId);
		                   int index=tempFileName.lastIndexOf(".");
		               	String format=fileBase.getFilename().substring(index+1);
		               	fileBase.setFormat(format);
		         		file_baseService.insert(fileBase);
		         		  //catalog
		         		File_catalog catalog=new File_catalog();
		         		catalog.setTitle(title);
		         		catalog.setProfile(profile);
		         		catalog.setClassfication_id("YJ002001001");
		         		catalog.setColumn_id(Integer.parseInt(column_id));
		         		catalog.setType(Byte.parseByte(type));
		         		long folder_id=0;
		         		catalog.setFolder_id(folder_id);
		         		catalogService.insert(catalog);
		         		fileBase.setCatalog_id(catalog.getId());
		         		file_baseService.update(fileBase);
		         			//file_label
		         		File_label fileLabel=new File_label();
		         		fileLabel.setFile_id(fileBase.getId());
		         		fileLabel.setLabel_id(1);
		         		catalogService.insertLabel(fileLabel);
		         			//user_property
		         		User user=userService.selectByUserId(userId);
		         		UserProperty userProperty=userService.selectProperty(user.getProperty_id());
		         		userProperty.setUpload_count(userProperty.getUpload_count()+1);
		         		if(type.equals("2")){
		         			userProperty.setPublic_file_count(userProperty.getPublic_file_count()+1);
		         		}
		         		if(type.equals("3")){
		         			userProperty.setPrivate_file_count(userProperty.getPrivate_file_count()+1);
		         		}
		         		userService.updateProperty(userProperty);
		         			//user_file
		         		User_file userFile=new User_file();
		         		userFile.setFile_id(fileBase.getId());
		         		userFile.setTime(date);
		         		Byte type1=1;
		         		userFile.setType(type1);
		         		userFile.setUser_id(userId);
		         		userService.insertUserFile(userFile);
		         			//上传日志
		         		 User_file_log log=new User_file_log();
		         		 log.setFile_id(fileBase.getId());
		         		 log.setUser_id(userId);
		         		 log.setOperation_time(date);
		         		 log.setOperation_description("上传了文件"+tempFileName);
		         		 log.setOperation_type(type1);
		         		 logService.insertUserFileLog(log);
		                }  
		                
		            }
		    }
		   
			
			
			
		}

		public static void main(String[] args) {
			int [] numbers={1,2,3,14,34};
			System.out.println(Arrays.binarySearch(numbers, 34));
		}
}
		  