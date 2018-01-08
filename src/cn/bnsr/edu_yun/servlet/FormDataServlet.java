package cn.bnsr.edu_yun.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.json.JSONException;
import org.json.JSONObject;

import cn.bnsr.edu_yun.util.IoUtil;


/**
 * flash上传文件servlet
 */
public class FormDataServlet extends HttpServlet {
	private static final long serialVersionUID = -1905516389350395696L;
	static final String FILE_FIELD = "file";
	public static final int BUFFER_LENGTH = 1024 * 1024 * 10;
	static final int MAX_FILE_SIZE = 1024 * 1024 * 100;

	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doOptions(req, resp);

		final PrintWriter writer = resp.getWriter();
		// 检查是否有一个文件上传请求
		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		if (!isMultipart) {
			writer.println("ERROR: 请求错误！");
			return;
		}
		JSONObject json = new JSONObject();
		long start = 0;
		boolean success = true;
		String message = "";

		ServletFileUpload upload = new ServletFileUpload();
		InputStream in = null;
		String token = null;
		try {
			FileItemIterator iter = upload.getItemIterator(req);
			while (iter.hasNext()) {
				FileItemStream item = iter.next();
				String name = item.getFieldName();
				in = item.openStream();
				if (item.isFormField()) {
					String value = Streams.asString(in);
					if (TokenServlet.TOKEN_FIELD.equals(name)) {
						token = value;
						/** TODO: 验证token */
					}
					System.out.println(name + ":" + value);
				} else {
					String fileName = item.getName();
					start = IoUtil.streaming(in, token, fileName);
				}
			}
		} catch (FileUploadException fne) {
			success = false;
			message = "Error: " + fne.getLocalizedMessage();
		} finally {
			try {
				if (success)
					json.put(StreamServlet.START_FIELD, start);
				json.put(TokenServlet.SUCCESS, success);
				json.put(TokenServlet.MESSAGE, message);
			} catch (JSONException e) {}
			
			writer.write(json.toString());
			IoUtil.close(in);
			IoUtil.close(writer);
		}
	}

	@Override
	public void destroy() {
		super.destroy();
	}
}
