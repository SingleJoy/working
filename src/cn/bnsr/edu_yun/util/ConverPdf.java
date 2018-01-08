package cn.bnsr.edu_yun.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.ConnectException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;

/**
 * 转换PDF
 * @author fangxiongwei
 * @date 2016年9月9日
 */
public class ConverPdf {
	private final Logger log = LoggerFactory.getLogger(ConverPdf.class);

    /** 
     * @param filePath  上传文件所在文件夹的绝对路径 
     * @param fileName  文件名称 
     * @return 生成pdf路径\文件名 
     */  
    public String beginConvert(String filePath,  String fileName,String fastName) {  
        final String DOC = ".doc";  
        final String DOCX = ".docx";  
        final String XLS = ".xls";  
        final String XLSX = ".xlsx";  
        final String PDF = ".pdf";  
        final String PPT=".ppt";
        final String PPTX=".pptx";
        final String TXT=".txt";
        String fileExt = "";  
        if (null != fileName && fileName.indexOf(".") > 0) {  
            int index = fileName.lastIndexOf(".");
            fileExt = fileName.substring(index).toLowerCase();  
        }  
        String inputFile = filePath + File.separator + fileName;  
        String outputFile = "";  
        int i = 0;
        //如果是office文档，先转为pdf文件  
        if (fileExt.equals(DOC) || fileExt.equals(DOCX) || fileExt.equals(XLS)  
                || fileExt.equals(XLSX)|| fileExt.equals(PPT)  
                || fileExt.equals(PPTX)){ 
        	
           outputFile = filePath + File.separator + fastName + PDF;  
           log.info("====源文件！===="+inputFile);
           log.info("====转换后文件！===="+outputFile);
           i= office2PDF(inputFile, outputFile);  
        }  
        if(fileExt.equals(TXT)||fileExt.equals(".java")){
      	  	File input=new File(inputFile);
	      	ChangeFileCode changeFileCode = new ChangeFileCode();  
	        String fileCode = changeFileCode.getFileEnCode(inputFile); 
	        if(fileCode!=null && !"".equals(fileCode)) {
		        changeFileCode.setFileIn(input.getPath(), fileCode);//如果文件编码为ANSI用GBK来读，如果是UTF-8用UTF-8来读  
		        changeFileCode.setFileOut(input.getPath(), "UTF-8");//UTF-8则文件编码为UTF-8， 如果为GBK，编码为ANSI  
		        changeFileCode.start();  
	        }
      	    inputFile=filePath + File.separator + fastName + ".odt";  
      	    input.renameTo(new File(inputFile));
      	    outputFile=filePath + File.separator + fastName + PDF;  
      	    log.info("====源文件！===="+inputFile);
      	    log.info("====转换后文件！===="+outputFile);
      	    i=office2PDF(inputFile, outputFile);
        }
        if(fileExt.equals(PDF)){//如果是pdf不需要转换 复制改名
            outputFile = filePath + File.separator + fastName + PDF;  
            i=copy(new File(inputFile),new File(outputFile));
        }
    
        if(i==0){
        	return outputFile;
        }else{
        	return "0";
        }
    } 
	/**
	 * 复制文件
	 */
    private int copy(File fromFile, File toFile){ 
    	try {
    		if (!fromFile.exists()){
    			  log.info("====来源文件为空！====");
    		   }
    		   if (!toFile.exists()){
     			  log.info("====创建新文件！====");
    			  toFile.createNewFile();
    		   }
    		   FileInputStream  fis = new FileInputStream(fromFile);
 			   log.info("fromFile :" + fromFile.getAbsolutePath());
    	       FileOutputStream fos = new FileOutputStream(toFile);
 			   log.info("toFile :" + toFile.getAbsolutePath());
    	 
    	       int len = 0; 
    	       byte[] buf = new byte[1024]; 
    	       while((len = fis.read(buf)) != -1){ 
    	    	   fos.write(buf,0,len); 
    	       }
    	       
    	       fis.close(); 
    	       fos.close(); 
		} catch (Exception e) {
			log.info("====文件复制失败====");
            return -1; 
		}
    	return 0;
	   
    } 
    
    
    /** 
     * office文档转pdf文件 
     * @param sourceFile    office文档绝对路径 
     * @param destFile      pdf文件绝对路径 
     * @return 
     */  
    private int office2PDF(String sourceFile, String destFile) {  
        String openOffice_HOME = ConfigInfo.getString("oo_home");
        String host_Str = ConfigInfo.getString("oo_host");  
        String port_Str = ConfigInfo.getString("oo_port");  
        OpenOfficeConnection connection=null;
        Process pro =null;
        try {  
            File inputFile = new File(sourceFile);  
            if (!inputFile.exists()) {  
            	log.info("====找不到源文件===="+sourceFile);
                return -1; // 找不到源文件   
            }  
            // 如果目标路径不存在, 则新建该路径    
            File outputFile = new File(destFile);  
            if (!outputFile.getParentFile().exists()) {  
                outputFile.getParentFile().mkdirs();  
            }  
            //windows
            // 启动OpenOffice的服务    
            /*String command = openOffice_HOME  
                    + "\\program\\soffice.exe -headless -accept=\"socket,host="  
                    + host_Str + ",port=" + port_Str + ";urp;\"";  */
           //linux
            String command = openOffice_HOME  
                    + "/program/soffice --headless --accept=\"socket,host="  
                    + host_Str + ",port=" + port_Str + ";urp;\"  --nofirststartwizard &"; 
                     
            log.info("====command===="+command);
            pro = Runtime.getRuntime().exec(command);  
            // 连接openoffice服务  
            connection = new SocketOpenOfficeConnection(host_Str, Integer.parseInt(port_Str));  
            connection.connect();  
            // 转换   
            DocumentConverter converter = new OpenOfficeDocumentConverter(connection);  
            try{
            	converter.convert(inputFile, outputFile);  
            }catch (Exception e) {
            	if(connection!=null){
            		connection.disconnect();  
            	}
            	if(pro!=null){
                    pro.destroy();  
                }
            	log.info("====转换异常！====");
			}
            // 关闭连接和服务  
            connection.disconnect();  
            pro.destroy();  
  
            return 0;  
        } catch (FileNotFoundException e) { 
        	log.info("====文件未找到====");
            return -1;  
        } catch (ConnectException e) {  
        	log.info("====OpenOffice服务监听异常！====");
        } catch (IOException e) {
        	log.info("====IO异常！====");
        } 
        return 1;  
    }  
    
    public static void main(String[] args) {  
    	/*ConverPdf c=new ConverPdf();
    	
		String filePath="D:\\work\\";
		String fileName="22.pptx";

		System.out.println(">>>"+c.beginConvert(filePath, fileName));
    	try {
    		//ConverImage.pdfToJPG("d:\\work\\22.pdf");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
    }  
	  
}
