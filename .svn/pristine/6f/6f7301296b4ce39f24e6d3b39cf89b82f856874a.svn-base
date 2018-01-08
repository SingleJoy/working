package cn.bnsr.edu_yun.servlet;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.bnsr.edu_yun.frontstage.base.view.UserFile;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.IoUtil;
/**
 * @author fangxiongwei
 * @date 2016年8月2日
 * 文件上传servlet，读取参数文件，存储文件
 */
public class StreamServlet extends HttpServlet {
	private final Logger log = LoggerFactory.getLogger(StreamServlet.class);

	private static final long serialVersionUID = -8619685235661387895L;
	static final int BUFFER_LENGTH = 10240;
	static final String START_FIELD = "start";
	public static final String CONTENT_RANGE_HEADER = "content-range";

	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doOptions(req, resp);
		final String token = req.getParameter(TokenServlet.TOKEN_FIELD);
		final String size = req.getParameter(TokenServlet.FILE_SIZE_FIELD);
		final String fileName = req.getParameter(TokenServlet.FILE_NAME_FIELD);
		final PrintWriter writer = resp.getWriter();
		
		/** TODO: 验证token */
		
		JSONObject json = new JSONObject();
		long start = 0;
		boolean success = true;
		String message = "";
		try {
			File f = IoUtil.getFile(token, fileName,req);
			start = f.length();
			/** 文件大小为0处理. */
			if (token.endsWith("_0") && "0".equals(size) && 0 == start){
				f.renameTo(IoUtil.getFile(fileName));
			}
		} catch (FileNotFoundException fne) {
			message = "Error: " + fne.getMessage();
			success = false;
		} finally {
			try {
				if (success){
					json.put(START_FIELD, start);
				}
				json.put(TokenServlet.SUCCESS, success);
				json.put(TokenServlet.MESSAGE, message);
			} catch (JSONException e) {}
			writer.write(json.toString());
			IoUtil.close(writer);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("text/html;charset=utf-8");
		req.setCharacterEncoding("UTF-8");
		doOptions(req, resp);
		final String token = req.getParameter(TokenServlet.TOKEN_FIELD);
		final String fileName = req.getParameter(TokenServlet.FILE_NAME_FIELD);
		Range range = IoUtil.parseRange(req);
		
		OutputStream out = null;
		InputStream content = null;
		final PrintWriter writer = resp.getWriter();
		
		/** TODO: 验证token */
		
		JSONObject json = new JSONObject();
		long start = 0;
		boolean success = true;
		String message = "";
		File f = IoUtil.getFile(token, fileName,req);
		try {
			if (f.length() != range.getFrom())
				throw new IOException("上传文件错误!");
			
			out = new FileOutputStream(f, true);
			content = req.getInputStream();
			int read = 0;
			final byte[] bytes = new byte[BUFFER_LENGTH];
			while ((read = content.read(bytes)) != -1)
				out.write(bytes, 0, read);

			start = f.length();
		} catch (FileNotFoundException fne) {
			message = "Error: " + fne.getMessage();
			success = false;
		} catch (IOException io) {
			message = "IO Error: " + io.getMessage();
			success = false;
		} finally {
			IoUtil.close(out);
			IoUtil.close(content);
			/** 重命名文件 */
			if (range.getSize() == start) {
                File dst = IoUtil.getFile(fileName);
                dst.delete();
                f.renameTo(dst);
                log.info("====TK: `" + token + "`, NE: `" + fileName + "`====");    
				try {
					//上传到文件服务器
					IoUtil.uploadFastDFS(dst,req);

			    	HttpSession session = req.getSession();
					if (success){
						UserFile userFile = (UserFile) session.getAttribute("userFile");
						json.put("filePaths",userFile.getFilePaths());
						json.put("fileNames",userFile.getFileNames());
						json.put("fileLengths",userFile.getFileLengths());
						json.put("fileImages",userFile.getFileImages());
						json.put(START_FIELD, start);
					}
					json.put(TokenServlet.SUCCESS, success);
					json.put(TokenServlet.MESSAGE, message);
					writer.write(json.toString());
					IoUtil.close(writer);
				} catch (JSONException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
				   /** 上传完成是否需要删除 */
				if (ConfigInfo.getBoolean("stream_delete_finish")) {
	                log.info("====上传完成删除文件===="+fileName);    
					IoUtil.getFile(fileName).delete();
				}
			}
		}
	}
	
	@Override
	protected void doOptions(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("application/json");
		resp.setHeader("Access-Control-Allow-Headers", "Content-Range,Content-Type");
		resp.setHeader("Access-Control-Allow-Origin", ConfigInfo.getString("stream_cross_origin"));
		resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
	}

	@Override
	public void destroy() {
		super.destroy();
	}

}
