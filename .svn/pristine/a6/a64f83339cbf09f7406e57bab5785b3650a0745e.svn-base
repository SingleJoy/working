package cn.bnsr.edu_yun.backstage.base.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.bnsr.edu_yun.util.ExceptionUtil;

import com.alibaba.fastjson.JSON;

/**
 * 基础Controller,其他来获得writeJson和ActionSupport的功能
 * 
 */
public class BaseController {
	private final Logger log = LoggerFactory.getLogger(BaseController.class);
	
    /**
     * 将对象转换成JSON字符串，并响应回前台
     */
    public void writeJson(Object object,HttpServletResponse response) {
        try {
            String json = JSON.toJSONStringWithDateFormat(object, "yyyy-MM-dd HH:mm:ss");
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.write(json);
            out.flush();
            out.close();
        }catch (IOException e) {
			log.error("JSON转换失败",ExceptionUtil.getExceptionMessage(e));
        }
    }
}
