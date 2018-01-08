package cn.bnsr.edu_yun.util;  
  
import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
      
/** 
 * 将pdf文件转成swf格式 
 */  
public class ConvertSwf {  
	private final Logger log = LoggerFactory.getLogger(ConvertSwf.class);

    /** 
     * 将pdf文件转换成swf文件 
     * @param sourceFile pdf文件绝对路径 
     * @param outFile    swf文件绝对路径 
     * @param toolFile   转换工具绝对路径 
     */  
    public String convertPdf2Swf(String sourceFile, String outFile) {  
    	//linux
    	String TOOL = "pdf2swf";  
    	//windows
    	//String TOOL = "D:\\Program Files (x86)\\SWFTools\\pdf2swf";  
    	String command = TOOL  +" "+ sourceFile + " -o " + outFile  
                 + " -s flashversion=9 "+ " -p 0-100"+" -s languagedir=/opt/xpdf-chinese-simplified/  ";  
        try {  
            Process process = Runtime.getRuntime().exec(command);  
            log.info("===="+loadStream(process.getInputStream())+"====");
            log.info("===="+loadStream(process.getErrorStream())+"====");
            log.info("====转换成功swf====");
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return "";
    }  
  
    static String loadStream(InputStream in) throws IOException{  
        int ptr = 0;  
        in = new BufferedInputStream(in);  
        StringBuffer buffer = new StringBuffer();  
          
        while ((ptr=in.read())!= -1){  
            buffer.append((char)ptr);  
        }  
        return buffer.toString();  
    }  
}  