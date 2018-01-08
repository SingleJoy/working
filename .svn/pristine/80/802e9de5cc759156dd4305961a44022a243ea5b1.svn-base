package cn.bnsr.edu_yun.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import cn.bnsr.edu_yun.util.TokenUtil;

/**
 * 根据文件名和它的大小，生成一个唯一的标记。这令牌将是指定用户的文件。
 */
public class TokenServlet extends HttpServlet {
	private static final long serialVersionUID = 2650340991003623753L;
	static final String FILE_NAME_FIELD = "name";
	public static final String FILE_SIZE_FIELD = "size";
	static final String TOKEN_FIELD = "token";
	static final String SERVER_FIELD = "server";
	static final String SUCCESS = "success";
	static final String MESSAGE = "message";
	
	/** 标记是否跨域上传 */
	static final String CROSS = "CROSS";
	static final String SERVER = "SERVER";
	boolean cross = false;
	String server = null;
	
	@Override
	public void init() throws ServletException {
		cross = Boolean.parseBoolean(getInitParameter(CROSS));
		server = getInitParameter(SERVER);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String name = req.getParameter(FILE_NAME_FIELD);
		String size = req.getParameter(FILE_SIZE_FIELD);
		String token = TokenUtil.generateToken(name, size);
		
		PrintWriter writer = resp.getWriter();
		
		JSONObject json = new JSONObject();
		try {
			json.put(TOKEN_FIELD, token);
			if (cross)
				json.put(SERVER_FIELD, server);
			json.put(SUCCESS, true);
			json.put(MESSAGE, "");
		} catch (JSONException e) {
		}
		/** TODO: 保存 token. */
		
		writer.write(json.toString());
	}

	@Override
	protected void doHead(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		super.doHead(req, resp);
	}

	@Override
	public void destroy() {
		super.destroy();
	}

}
