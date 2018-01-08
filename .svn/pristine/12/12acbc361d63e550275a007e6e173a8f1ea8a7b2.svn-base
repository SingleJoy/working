package cn.bnsr.edu_yun.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import org.csource.common.NameValuePair;
import org.csource.fastdfs.ClientGlobal;
import org.csource.fastdfs.StorageClient1;
import org.csource.fastdfs.StorageServer;
import org.csource.fastdfs.TrackerClient;
import org.csource.fastdfs.TrackerServer;
import org.csource.fastdfs.UploadStream;
import org.springframework.core.io.ClassPathResource;

public class Test {

	
	
	
	public static void main(String[] args) throws Exception {
	
		 //fastDFS方式  
	
		ClassPathResource cpr = new ClassPathResource("fdfs_client.conf");  
        ClientGlobal.init(cpr.getClassLoader().getResource("fdfs_client.conf").getPath());  
        File file=new File("D:/aaa.pdf");
        long fileLength = file.length();
        InputStream inStream =new FileInputStream(file);
	    UploadStream uploadStream = new UploadStream(inStream, fileLength);
	   
       // byte[] fileBuff = file.getBytes();  
        String fileId = "";  
        String tempFileName="aaa.pdf";
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
        metaList[2] = new NameValuePair("fileLength", String.valueOf(fileLength));  
        
        //上传文件  
        fileId = client.upload_file1("group1", fileLength, uploadStream, fileExtName, metaList);
     System.out.println(fileId);

	}
}