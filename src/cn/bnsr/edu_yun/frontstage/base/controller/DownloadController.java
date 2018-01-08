package cn.bnsr.edu_yun.frontstage.base.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.File_property;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file;
import cn.bnsr.edu_yun.frontstage.resource.service.FilePropertyService;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.train.po.CourseFile;
import cn.bnsr.edu_yun.frontstage.train.service.CourseFileService;
import cn.bnsr.edu_yun.util.ConfigInfo;
/**
 * 文件下载
 * @author fangxiongwei
 * @date 2017年8月15日
 */
@Controller
@RequestMapping("/download")
public class DownloadController {
	private final Logger log = LoggerFactory.getLogger(DownloadController.class);

	@Autowired
	private File_baseService fileBaseService;
	@Autowired
	private CourseFileService courseFileService;
	@Autowired
	private UserService userService;
	@Autowired
	private FilePropertyService filePropertyService;
	
	/**
	 * 下载远程服务器文件
	 */	
    @RequestMapping("/download_file")
	public void downloadFile(HttpServletRequest request,HttpServletResponse response){
    	OutputStream os = null;
    	ReadableByteChannel  rbc = null;
		try{
			User user = (User) request.getSession().getAttribute("currentUser");
			String id = request.getParameter("id");
			String type = request.getParameter("type");
			if(id != null && type != null && !id.equals("")   && !type.equals("")){
				//获取文件名
	            String fileExtName = "";
				//根据条件得到文件路径
	            String fileurl = "";
				if(type.equals("0")){//资源文件
					File_base filebase = fileBaseService.getById(id);
					if(filebase != null){
						fileExtName = filebase.getFilename()+"."+filebase.getFormat();
						fileurl = filebase.getPath();
					}
				}else if(type.equals("1")){//课程文件
					CourseFile cf = courseFileService.selectByKey(Long.parseLong(id));
					if(cf != null){
						fileExtName = cf.getName();
						fileurl = cf.getPath();
					}
				}
				
				if(!fileExtName.equals("")){
					os = response.getOutputStream();
		            log.info("===========文件路径==========="+fileurl);
		            //获取远程文件
					URL website = new URL(ConfigInfo.getString("file_server_path")+fileurl);
					//获取数据通道
					rbc = Channels.newChannel(website.openStream());
					//获得浏览器代理信息
					final String userAgent = request.getHeader("USER-AGENT");
					//判断浏览器代理并分别设置响应给浏览器的编码格式
					String finalFileName = null;
		            if(StringUtils.contains(userAgent, "MSIE")||StringUtils.contains(userAgent,"Trident")){//IE浏览器
		                finalFileName = URLEncoder.encode(fileExtName,"UTF8");
		            }else if(StringUtils.contains(userAgent, "Mozilla")){//google,火狐浏览器
		                finalFileName = new String(fileExtName.getBytes(), "ISO8859-1");
		            }else{
		                finalFileName = URLEncoder.encode(fileExtName,"UTF8");//其他浏览器
		            }
		            //设置HTTP响应头
		            response.reset();//重置 响应头
		            response.setContentType("application/x-download");//告知浏览器下载文件，而不是直接打开，浏览器默认为打开
		            response.addHeader("Content-Disposition" ,"attachment;filename=\"" +finalFileName+ "\"");//下载文件的名称
		            //读取数据
		            ByteBuffer bb = ByteBuffer.allocate(1024);
		            int index = -1;
		            // 循环取出流中的数据
		            while ((index = rbc.read(bb)) > 0){
		            	
		                if (index <= 0) {
		                     break;
		               }
		               bb.position(0);
		           
		               byte[] b = new byte[index];
		               bb.get(b);
		               //将数据输出
		              
		               os.write(b, 0, index);
		               bb.clear();//缓冲区不会被自动覆盖，需要主动调用该方法
		           } 
		           //存储下载记录
		           User_file userFile=new User_file();
		           userFile.setFile_id(Long.parseLong(id));
		           userFile.setTime(new Date());
		           userFile.setType((byte) 5);
		           userFile.setFile_type(Integer.parseInt(type));
		           userFile.setUser_id(user.getId());
		           userService.insertUserFile(userFile);
		           if(type.equals("0")){//资源文件
		        	   File_base fileBase = fileBaseService.selectById(Long.parseLong(id));
		        	   File_property property=new File_property();
		       	    property.setId(fileBase.getProperty_id());
		       	  
		       	    property.setDownload_times(fileBase.getFile_property().getDownload_times()+1);
		       	    filePropertyService.update(property);
		           }
		          
				}else{
					log.info("找不到该文件！");
				}
			}else{
				log.info("参数异常！");
			}
    	  }catch(MalformedURLException e){
    		e.printStackTrace();
			log.debug("获取文件错误！", e);
    	  } catch (IOException e) {
			e.printStackTrace();
			log.debug("下载异常！", e);
		  }finally{
			  try {
				if(rbc != null){
					rbc.close();
				}
				if(os != null){
					os.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
				log.debug("流关闭异常！", e);
			}
		  }
	}
}
