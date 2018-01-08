package cn.bnsr.edu_yun.frontstage.base.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.comparator.ComparatorRank;
import cn.bnsr.edu_yun.frontstage.base.po.DefaultText;
import cn.bnsr.edu_yun.frontstage.base.po.DefaultVarchar;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.service.AreaService;
import cn.bnsr.edu_yun.frontstage.base.service.Classification_entryService;
import cn.bnsr.edu_yun.frontstage.base.service.DefaultTextService;
import cn.bnsr.edu_yun.frontstage.base.service.DefaultVarcharService;
import cn.bnsr.edu_yun.frontstage.base.service.NotificationService;
import cn.bnsr.edu_yun.frontstage.base.service.SubjectListService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.NotificationView;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.frontstage.base.view.UserDetailView;
import cn.bnsr.edu_yun.frontstage.base.view.UserView;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file_log;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.resource.service.LogService;
import cn.bnsr.edu_yun.frontstage.resource.view.RankView;
import cn.bnsr.edu_yun.frontstage.train.po.CertModelPicture;
import cn.bnsr.edu_yun.frontstage.train.service.CertModelPictureService;
import cn.bnsr.edu_yun.frontstage.train.service.CourseService;
import cn.bnsr.edu_yun.frontstage.train.service.TeacherRelationService;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherRelationView;
import cn.bnsr.edu_yun.listener.SessionListener;
import cn.bnsr.edu_yun.util.HttpRequest;
import cn.bnsr.edu_yun.util.IpUtil;
import cn.bnsr.edu_yun.util.MD5;
import cn.bnsr.edu_yun.util.RequestUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;
import cn.bnsr.edu_yun.util.UserLog;

/**
 * 用户注册登录Controller
 * 
 * @author Administrator
 * 
 */
@Controller
@RequestMapping("/user")
public class UserController {
	private final Logger log = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;
	@Autowired
	private File_baseService fileBaseService;
	@Autowired
	private Classification_entryService classiFIcationEntryService;
	@Autowired
	private LogService logService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private AreaService areaService;
	@Autowired
	private SubjectListService subjectListService;
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private TeacherRelationService teacherRelationService;
	@Autowired
	private DefaultTextService defaultTextService;
	@Autowired
	private DefaultVarcharService defaultVarcharService;
	@Autowired
	private CertModelPictureService certModelPictureService;
	private int state = 0;

	/**
	 * 跳转注册页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	// @RequestMapping("/to_register")
	// public ModelAndView to_register(HttpServletRequest request) throws
	// Exception {
	// ModelAndView modelAndView = new ModelAndView();
	//
	// modelAndView.setViewName("frontstage/base/register1");
	// return modelAndView;
	//
	// }

	/**
	 * 注册页面跳转登录
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/registerToLogin")
	public ModelAndView registerToLogin(HttpServletRequest request) throws Exception {
		ModelAndView modelAndView = home(request);

		String loginFlag = "1";

		modelAndView.addObject("loginFlag", loginFlag);
		return modelAndView;

	}

	/**
	 * 注销
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.removeAttribute("currentUser");
		ModelAndView modelAndView = home(request);
		return modelAndView;

	}

	/**
	 * 注册
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	// @RequestMapping("/register")
	// public ModelAndView register(HttpServletRequest request) throws Exception
	// {
	// String username = request.getParameter("username");
	// String password = request.getParameter("password");
	// String email = request.getParameter("email");
	// String real_name = request.getParameter("password");
	// String phone = request.getParameter("phone");
	// User user = new User();
	// user.setUsername(username);
	// // 判断用户是否存在
	// boolean flag = userService.selectByUsername(user);
	// if (username == null || username.equals("")) {
	// ModelAndView modelAndView = new ModelAndView();
	// modelAndView.setViewName("frontstage/base/register");
	// return modelAndView;
	// }
	// if (flag) {
	// ModelAndView modelAndView = new ModelAndView();
	// modelAndView.setViewName("frontstage/base/register");
	// return modelAndView;
	//
	// } else {
	// System.out.println(username);
	// UserProperty userProperty = new UserProperty();
	// userProperty.setAttent_count(0);
	// userProperty.setIs_attented_count(0);
	// userProperty.setUpload_count(0);
	// userProperty.setPrivate_file_count(0);
	// userProperty.setPublic_file_count(0);
	// userService.insertProperty(userProperty);
	// user.setProperty_id(userProperty.getId());
	// double wealth = 100;
	// user.setWealth(wealth);
	// user.setUsername(username);
	// user.setCreate_time(new Date());
	// user.setPassword(password);
	// user.setEmail(email);
	// user.setPhone(phone);
	// user.setRealname(real_name);
	// user.setUser_type("1");// 网站用户
	// user.setStatus("0");// 未验证用户
	// user.setIcon(ConfigInfo.getString("defalutPicture") + "/default.jpg");
	// userService.insert(user);
	// UserInfo info = new UserInfo();
	// info.setUser_id(user.getId());
	// userInfoService.insert(info);
	// // 还需添加日志
	// ModelAndView modelAndView = home(request);
	// System.out.println("用户ID" + user.getId());
	//
	// List<File_base> file_baseList =
	// fileBaseService.selectByUserId(user.getId(), 0, 3);
	//
	// for (File_base file_base : file_baseList) {
	// System.out.println(file_base.getFile_catalog().getProfile());
	// }
	// HttpSession session = request.getSession();
	// session.setAttribute("currentUser", user);
	// session.setAttribute("sessionListener", new SessionListener(user));
	// session.setAttribute("user_info", info);
	// modelAndView.addObject("user", user);
	// modelAndView.addObject("file_baseList", file_baseList);
	// modelAndView.addObject("userProperty", userProperty);
	// return modelAndView;
	// }
	// }

	/**
	 * 注销
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@UserLog(description = "用户退出")
	@RequestMapping("/frontAjaxLogout")
	public ModelAndView frontAjaxLogout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();
		HttpSession session = request.getSession();
		User u = (User) session.getAttribute("currentUser");
		request.setAttribute("extraId", u.getId());
		session.removeAttribute("currentUser");
		ResponseUtil.write(response, result);
		return null;

	}

	/**
	 * ajax登录
	 */
	// @RequestMapping("/ajaxLogin")
	// public ModelAndView ajaxLogin(HttpServletRequest request,
	// HttpServletResponse response) throws Exception {
	// JSONObject result = new JSONObject();
	// String username = request.getParameter("username");
	// String password = request.getParameter("password");
	// User user = new User();
	// boolean flag = userService.selectByUsernameAndPassword(username,
	// password, user);
	//
	// if (flag) {
	// user = userService.selectByUserId(user.getId());
	//
	// System.out.println("用户ID" + user.getId());
	//
	// HttpSession session = request.getSession();
	// session.setAttribute("currentUser", user);
	// session.setAttribute("sessionListener", new SessionListener(user));
	// UserInfo userInfo = userInfoService.getByUserId(user.getId());
	// session.setAttribute("user_info", userInfo);
	//
	// } else {
	//
	// String phone = request.getParameter("phone");
	// String yzm = request.getParameter("yzm");
	// HttpSession session = request.getSession();
	// String yzm1 = (String) session.getAttribute("yzm");
	// boolean flag1 = yzm.equals(yzm1);
	// if (flag1) {
	// user = userService.selectUserByPhone(phone);
	//
	// System.out.println("用户ID" + user.getId());
	//
	// session.setAttribute("currentUser", user);
	// session.setAttribute("sessionListener", new SessionListener(user));
	// UserInfo userInfo = userInfoService.getByUserId(user.getId());
	// session.setAttribute("user_info", userInfo);
	//
	// }
	//
	// }
	// ResponseUtil.write(response, result);
	// return null;
	// }

	/**
	 * 检查注册
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/checkRegister")
	public ModelAndView checkRegister(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String username = request.getParameter("username");
		User user = new User();
		user.setUsername(username);

		boolean flag = userService.selectByUsername(user);
		JSONObject result = new JSONObject();
		if (flag) {
			result.put("flag", "1");
			result.put("user", user);
			System.out.println("用户名存在");
		} else {
			result.put("flag", "2");
			System.out.println("用户名不存在");
		}

		ResponseUtil.write(response, result);
		return null;

	}

	/**
	 * 检查手机号码是否重复
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/checkPhone")
	public ModelAndView checkPhone(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String phone = request.getParameter("phone");
		boolean flag = userService.selectByPhone(phone);
		JSONObject result = new JSONObject();
		if (flag) {
			result.put("flag", "1");
			User user = userService.selectUserByPhone(phone);
			result.put("user_id", user.getId());
			System.out.println("手机号码存在");
		} else {
			result.put("flag", "2");
			System.out.println("手机号码不存在");
		}

		ResponseUtil.write(response, result);
		return null;
	}

	/**
	 * 获得手机验证码
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getPhoneYzm")
	public ModelAndView getPhoneYzm(HttpServletRequest request, HttpServletResponse response, String phone) throws Exception {
		System.out.println("电话号码是=" + phone);

		HttpClient client = new HttpClient();
		String Url = "http://106.ihuyi.cn/webservice/sms.php?method=Submit";
		PostMethod method = new PostMethod(Url);

		// client.getParams().setContentCharset("GBK");
		client.getParams().setContentCharset("UTF-8");
		method.setRequestHeader("ContentType", "application/x-www-form-urlencoded;charset=UTF-8");

		int mobile_code = (int) ((Math.random() * 9 + 1) * 100000);

		System.out.println("----------->这是手机验证码：" + mobile_code);

		String content = new String("您的验证码是：" + mobile_code + "。请不要把验证码泄露给其他人。");

		org.apache.commons.httpclient.NameValuePair[] data = { // 提交短信
		new org.apache.commons.httpclient.NameValuePair("account", "cf_bnsr"),
				new org.apache.commons.httpclient.NameValuePair("password", "e10adc3949ba59abbe56e057f20f883e"), // 密码使用32位MD5加密
				// new NameValuePair("password",
				// util.StringUtil.MD5Encode("密码")),
				new org.apache.commons.httpclient.NameValuePair("mobile", phone), new org.apache.commons.httpclient.NameValuePair("content", content), };

		method.setRequestBody(data);

		try {
			client.executeMethod(method);

			String SubmitResult = method.getResponseBodyAsString();

			// System.out.println(SubmitResult);

			Document doc = DocumentHelper.parseText(SubmitResult);
			Element root = doc.getRootElement();

			String code = root.elementText("code");
			String msg = root.elementText("msg");
			String smsid = root.elementText("smsid");
			System.out.println(code);
			System.out.println(msg);
			System.out.println(smsid);
			JSONObject result = new JSONObject();
			HttpSession session = request.getSession();
			if ("2".equals(code)) {
				System.out.println("短信提交成功");
				session.setAttribute("yzm", mobile_code + "");
				result.element("status", "y");
			} else {
				result.element("status", "n");
			}
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println(result.toString());
			out.flush();
			out.close();
		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		return null;

	}

	/**
	 * 检查手机验证码登录
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/checkLoginByPhone")
	public ModelAndView checkLoginByPhone(HttpServletRequest request, HttpServletResponse response, String phone) throws Exception {
		JSONObject result = new JSONObject();

		boolean flag = userService.selectByPhone(phone);

		if (flag) {
			result.put("flag", "1");
		} else {
			result.put("flag", "2");
		}
		ResponseUtil.write(response, result);
		return null;

	}

	@RequestMapping("/home")
	public ModelAndView home(HttpServletRequest request) throws Exception {
		// 。。。。。。。。。。。。user相关（本用户）${pageContext.request.contextPath}/
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		// 用户的属性值
		if (user != null) {
			NotificationView notificationView = new NotificationView();
			notificationView.setUser_id(user.getId());
			session.setAttribute("notification_num", notificationService.queryNoReadCount(notificationView));

			UserInfo userInfo = userInfoService.getByUserId(user.getId());
			session.setAttribute("user_info", userInfo);
			modelAndView.addObject("user", user);
		}
		// modelAndView.addObject("userProperty",userProperty);
		modelAndView.setViewName("frontstage/base/home");

		return modelAndView;

	}

	@RequestMapping("/resource_home")
	public ModelAndView resourceHome(HttpServletRequest request) throws Exception {
		// 。。。。。。。。。。。。user相关（本用户）${pageContext.request.contextPath}/
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		// 用户的属性值
		if (user != null) {
			// user=userService.selectByUserId(user.getId());
			long user_propertyId = user.getProperty_id();
			UserProperty userProperty = userService.selectUserPropertyById(user_propertyId);
			System.out.println("用户ID" + user.getId());
			NotificationView notificationView = new NotificationView();
			notificationView.setUser_id(user.getId());

			session.setAttribute("notification_num", notificationService.queryNoReadCount(notificationView));

			List<File_base> file_baseList = fileBaseService.selectByUserId(user.getId(), 0, 3);

			for (File_base file_base : file_baseList) {
				System.out.println(file_base.getFile_catalog().getProfile());
			}

			session.setAttribute("currentUser", user);
			session.setAttribute("sessionListener", new SessionListener(user));
			UserInfo userInfo = userInfoService.getByUserId(user.getId());
			session.setAttribute("user_info", userInfo);
			modelAndView.addObject("user", user);
			modelAndView.addObject("file_baseList", file_baseList);
			modelAndView.addObject("userProperty", userProperty);
		}
		// 。。。。。。。。。。。。file相关
		// 最新上传
		List<File_base> newUpload = fileBaseService.selectAll();
		for (File_base f : newUpload) {
			System.out.println(f.getUser().getUsername());
		}

		String str = "语文,数学,英语,物理,化学,生物,思想政治,历史,地理";
		String[] strs = str.split(",");
		List<List<PubverList>> entryList = new ArrayList<List<PubverList>>();

		for (String s : strs) {

			List<PubverList> pubverList1 = areaService.selectAllProject("%" + s + "%", "XX");
			List<PubverList> pubverList2 = areaService.selectAllProject("%" + s + "%", "CZ");
			List<PubverList> pubverList3 = areaService.selectAllProject("%" + s + "%", "GZ");
			entryList.add(pubverList1);
			entryList.add(pubverList2);
			entryList.add(pubverList3);

		}

		// 其他
		List<SubjectList> subjectListXX = subjectListService.selectOtherSubject("XX");
		List<SubjectList> subjectListCZ = subjectListService.selectOtherSubject("CZ");
		List<SubjectList> subjectListGZ = subjectListService.selectOtherSubject("GZ");
		// List<Classification_entry>
		// entrys=classiFIcationEntryService.selectAllProject("%数学%");

		// 热门专区
		// 精品资料
		// 今日免费文档
		// 热搜文档
		// 。。。。。。。。。。。。user相关（其他用户）
		// 作者推荐
		Date date = new Date();
		SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");

		String time = formater.format(date);
		List<Long> userIds = logService.selectDistinctUser("%" + time + "%");
		List<RankView> rankViews = new ArrayList<RankView>();

		for (long userId : userIds) {
			RankView rankView = new RankView();
			List<User_file_log> logs = logService.selectByUserId("%" + time + "%", userId);
			rankView.setUser_id(userId);
			System.out.println(userId);
			System.out.println(userService.selectByUserId(userId).getUsername());
			rankView.setUsername(userService.selectByUserId(userId).getUsername());
			rankView.setUploadCount(logs.size());
			rankViews.add(rankView);
		}

		Collections.sort(rankViews, new ComparatorRank());

		for (RankView a : rankViews) {
			System.out.println(a.getUsername() + "saaaaaa" + a.getUploadCount());
		}

		List<User> propertyUsers = userService.selectAllNum();
		modelAndView.addObject("propertyUsers", propertyUsers);
		modelAndView.addObject("rankViews", rankViews);
		modelAndView.addObject("strs", strs);

		modelAndView.addObject("entryList", entryList);
		modelAndView.addObject("subjectListXX", subjectListXX);
		modelAndView.addObject("subjectListCZ", subjectListCZ);
		modelAndView.addObject("subjectListGZ", subjectListGZ);

		modelAndView.addObject("newUpload", newUpload);
		modelAndView.addObject("head_title", "资源主页");
		// modelAndView.addObject("userProperty",userProperty);
		modelAndView.setViewName("frontstage/base/resource_home");

		return modelAndView;

	}

	/**
	 * 跳转修改密码页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/resetPassword")
	public ModelAndView resetPassword(HttpServletRequest request) throws Exception {
		if (request.getParameter("state") != null) {
			state = Integer.parseInt(request.getParameter("state"));
		}
		String stamp = request.getParameter("stamp");
		String flag1 = request.getParameter("flag1");
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");

		UserInfo userInfo = userInfoService.getByUserId(user.getId());
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		// 个人中心统计数据
		UserCenterView userCenter = userService.queryUserCenter(user.getId());
		modelAndView.addObject("userCenter", userCenter);
		modelAndView.addObject("head_title", "修改密码");
		modelAndView.setViewName("frontstage/base/personalCenter/reset-password");
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);
		request.setAttribute("flag1", flag1);
		return modelAndView;

	}

	/**
	 * 修改密码
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/reset")
	public ModelAndView reset(HttpServletRequest request) throws Exception {
		// String password = request.getParameter("password");

		String newPassword = request.getParameter("newPassword");
		User user = (User) request.getSession().getAttribute("currentUser");
		String flag1 = "0";
		if (user != null && user.getId() != null) {
			User user2 = new User();
			user2.setId(user.getId());
			user2.setPassword(MD5.MD5c(newPassword));

			userService.updateUser(user2);
			flag1 = "1";
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/user/resetPassword.action?state=34&stamp=7&flag1=" + flag1);
		return modelAndView;

	}

	@RequestMapping("/to_resource_list")
	public ModelAndView to_resource_list(HttpServletRequest request, String editionId) throws Exception {

		String subjectId = editionId.substring(0, 5);
		String stageId = editionId.substring(0, 2);

		SubjectList subjectList = subjectListService.selectById(subjectId);
		System.out.println(subjectId);
		String subject = subjectList.getSubjectName();

		subject = java.net.URLEncoder.encode(subject, "utf-8");

		if (editionId.length() > 5) {
			return new ModelAndView("redirect:/resource_list/to_resource_list.action?stageId=" + stageId + "&subjectId=" + subjectId + "&editionId="
					+ editionId + "&subject=" + subject);

		} else {
			return new ModelAndView("redirect:/resource_list/to_resource_list.action?stageId=" + stageId + "&subjectId=" + subjectId + "&subject=" + subject);

		}

	}

	@RequestMapping("/search_user")
	@ResponseBody
	public JSONArray searchUser(HttpServletRequest request) {
		String username = request.getParameter("username");
		String usertype = request.getParameter("usertype");
		TeacherRelationView user = userService.searchUser(username, usertype);
		if (user != null) {
			return JSONArray.fromObject(user);
		} else {
			return JSONArray.fromObject(0);
		}
	}

	@RequestMapping("/search_user0")
	@ResponseBody
	public JSONArray searchUser0(HttpServletRequest request) {
		String username = request.getParameter("username");
		String usertype = request.getParameter("usertype");
		TeacherRelationView user = userService.searchUser0(username, usertype);
		if (user != null) {
			return JSONArray.fromObject(user);
		} else {
			return JSONArray.fromObject(0);
		}
	}

	@RequestMapping("/select_user")
	@ResponseBody
	public JSONArray selectUser(HttpServletRequest request) {
		String id = request.getParameter("id");
		UserDetailView user = userService.selectUserDetail(id);
		if (user != null) {
			return JSONArray.fromObject(user);
		} else {
			return JSONArray.fromObject(0);
		}
	}

	/**
	 * 跳转注册页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/to_register1")
	public ModelAndView to_register1(HttpServletRequest request) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		String url = request.getHeader("Referer");
		url = url != null ? url.substring(RequestUtil.getCharacterPosition(url, "/", 4)) : "/user/home.action";
		modelAndView.addObject("index", "2");
		if (!"/user/to_register1.action".equals(url) && !"/user/to_login.action".equals(url)) {// 不是注册链接跳转去登陆链接，登陆链接跳转到登陆链接
			HttpSession session = request.getSession();
			session.removeAttribute("refererUrl");
			session.setAttribute("refererUrl", url);
		}
		modelAndView.setViewName("frontstage/base/layout/sign");
		modelAndView.addObject("head_title", "注册");
		return modelAndView;
	}

	/**
	 * 注册
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@UserLog(description = "注册并登录")
	@RequestMapping("/frontRegister1")
	public ModelAndView register1(HttpServletRequest request, User user) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		Integer sign_type = user.getSign_type();
		if (sign_type == 1) {
			modelAndView.setViewName("redirect:/user/to_login.action");
		} else {
			modelAndView.setViewName("redirect:/user/to_register1.action");
		}
		HttpSession session = request.getSession();
		String yzm = request.getParameter("yzm");
		if (yzm == null || yzm.length() == 0) {
			return modelAndView;
		} else {
			String yzm1 = (String) session.getAttribute("yzm");
			boolean flag1 = yzm.equals(yzm1);
			if (!flag1) {
				return modelAndView;
			}
		}
		if (user.getPhone() == null || user.getPhone().length() == 0) {
			return modelAndView;
		} else {
			String regex = "^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(user.getPhone());
			if (!matcher.matches()) {
				return modelAndView;
			} else {
				boolean flag = userService.selectByPhone(user.getPhone());
				if (flag) {
					return modelAndView;
				}
			}
		}
		if (sign_type == 1) {// 手机快捷注册
			user.setUsername(UUID.randomUUID().toString().replaceAll("-", "").substring(24));
			// user.setPassword(user.getPhone());
		} else if (sign_type == 0) {// 账号注册
			String username = user.getUsername();
			if (username == null || username.length() == 0 || HttpRequest.paramValidate(username)) {
				return modelAndView;
			} else {
				boolean flag = userService.selectByUsername(user);
				if (flag) {
					return modelAndView;
				}
			}
			String password = user.getPassword();
			if (password == null || password.length() == 0 || HttpRequest.paramValidate(password)) {
				return modelAndView;
			} else {
				user.setPassword(MD5.MD5c(password));
			}
		} else {
			return modelAndView;
		}
		// String url = (String) session.getAttribute("refererUrl");//
		// 跳转注册之前的url
		// url = (url == null || url.length() == 0) ? "/user/home.action" : url;
		// modelAndView.setViewName("redirect:/" + url);
		// 获取用户登录的外网IP
		String networkIp = IpUtil.getIpAddr(request);
		if ("".equals(networkIp)) {
			networkIp = request.getRemoteAddr();
		}
		networkIp = StringUtils.isBlank(networkIp) ? "" : networkIp;

		UserProperty userProperty = new UserProperty();
		userProperty.setAttent_count(0);
		userProperty.setIs_attented_count(0);
		userProperty.setUpload_count(0);
		userProperty.setPrivate_file_count(0);
		userProperty.setPublic_file_count(0);
		userService.insertProperty(userProperty);
		user.setProperty_id(userProperty.getId());
		user.setSign_ip(networkIp);
		double wealth = 100;
		user.setWealth(wealth);
		user.setCreate_time(new Date());
		user.setUser_type("1");// 网站用户
		user.setStatus("1");// 正常
		// user.setIcon("/frontstage/images/default.png");
		CertModelPicture defaultImg = certModelPictureService.getDefaultImg(2);
		user.setIcon(defaultImg.getPath());
		userService.insert(user);
		UserInfo info = new UserInfo();
		info.setUser_id(user.getId());
		DefaultText defaultText = defaultTextService.selectTheOne(1L);
		if (defaultText != null) {
			info.setProfile(defaultText.getContent());
			info.setDefault_profile(1);
		}
		DefaultVarchar defaultVarchar = defaultVarcharService.selectTheOne(1L);
		if (defaultVarchar != null) {
			info.setSignature(defaultVarchar.getContent());
			info.setDefault_signature(1);
		}
		userInfoService.insert(info);
		session.setAttribute("currentUser", user);
		session.setAttribute("sessionListener", new SessionListener(user));
		session.setAttribute("user_info", info);
		modelAndView.addObject("user", user);
		String url = (String) session.getAttribute("refererUrl");
		url = (url == null || url.length() == 0) ? "/user/home.action" : url;
		modelAndView.setViewName("redirect:" + url);
		return modelAndView;
	}

	/**
	 * 跳转注册页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/to_login")
	public ModelAndView to_login(HttpServletRequest request) throws Exception {
		// User user = (User) request.getSession().getAttribute("currentUser");
		ModelAndView modelAndView = new ModelAndView();
		String reset = request.getParameter("reset");
		if (!"1".equals(reset)) {// 不是从重置密码链接跳转过来，需要重新获取之前的链接
			String url = request.getHeader("Referer");
			if (url != null) {
				url = url.substring(RequestUtil.getCharacterPosition(url, "/", 4));
			} else {
				url = "/user/home.action";
			}
			if (!"/user/to_register1.action".equals(url) && !"/user/to_login.action".equals(url)) {// 不是注册链接跳转去登陆链接，登陆链接跳转到登陆链接
				HttpSession session = request.getSession();
				session.removeAttribute("refererUrl");
				session.setAttribute("refererUrl", url);
			}
		}
		String name = "";
		String password = "";
		String rpwd = "";
		try {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					if (cookies[i].getName().equals("cookie_user")) {
						String values = cookies[i].getValue();
						// 如果value字段不为空
						if (StringUtils.isNotBlank(values)) {
							String[] elements = values.split("-");
							// 获取账户名或者密码
							if (StringUtils.isNotBlank(elements[0])) {
								name = URLDecoder.decode(elements[0], "UTF-8");
							}
							if (StringUtils.isNotBlank(elements[1])) {
								password = elements[1];
							}
							if (StringUtils.isNotBlank(elements[2])) {
								rpwd = elements[2];
							}
						}
						break;
					}
				}
			}
			modelAndView.addObject("name", name);
			modelAndView.addObject("password", password);
			modelAndView.addObject("rpwd", rpwd);
		} catch (Exception e) {
			e.printStackTrace();

		}
		modelAndView.addObject("index", "0");
		modelAndView.setViewName("frontstage/base/layout/sign");
		return modelAndView;
	}

	/**
	 * 检查普通登录
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * @UserLog(description = "用户登录")
	 */
	@RequestMapping("/checkLogin1")
	public ModelAndView checkLogin1(HttpServletResponse response, User user) throws Exception {
		JSONObject result = new JSONObject();
		String password = MD5.MD5c(user.getPassword());
		user.setPassword("");
		if (userService.queryUser(user) != null) {
			user.setPassword(password);
			if (userService.queryUser(user) != null) {
				result.put("flag", "1");// ok
			} else {
				result.put("flag", "2");// 密码错误
			}
		} else {
			result.put("flag", "3");// 账户不存在
		}
		ResponseUtil.write(response, result);
		return null;
	}

	/**
	 * 普通登录
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@UserLog(description = "用户登录")
	@RequestMapping("/frontLogin")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, User user) throws Exception {
		ModelAndView modelAndView = new ModelAndView("redirect:/user/to_login.action");
		String pass = user.getPassword();
		if (pass != null && pass.length() > 0) {
			user.setPassword(MD5.MD5c(pass));
		}
		// if (pass == null||pass.length()==0||HttpRequest.paramValidate(pass))
		// {
		// return modelAndView;
		// }else{
		// user.setPassword(MD5.MD5c(pass));
		// }
		int i = 0;
		String username = user.getUsername();
		if (username == null || username.length() == 0) {
			i += 1;
		} else if (HttpRequest.paramValidate(username)) {
			return modelAndView;
		}
		String phone = user.getPhone();
		if (phone == null || phone.length() == 0) {
			i += 1;
		} else if (HttpRequest.paramValidate(phone)) {
			return modelAndView;
		}
		String email = user.getEmail();
		if (email == null || email.length() == 0) {
			i += 1;
		} else if (HttpRequest.paramValidate(email)) {
			return modelAndView;
		}
		if (i == 3) {
			return modelAndView;
		}
		user = userService.queryUser(user);
		if (user != null && user.getId() != null) {
			user = userService.selectByUserId(user.getId());
			// user.setPassword(pass);
			long user_propertyId = user.getProperty_id();
			UserProperty userProperty = userService.selectUserPropertyById(user_propertyId);
			List<File_base> file_baseList = fileBaseService.selectByUserId(user.getId(), 0, 3);
			HttpSession session = request.getSession();
			if (session.getAttribute("currentUser") == null) {
				session.setAttribute("currentUser", user);
				session.setAttribute("sessionListener", new SessionListener(user));
				UserInfo userInfo = userInfoService.getByUserId(user.getId());
				session.setAttribute("user_info", userInfo);
				modelAndView.addObject("user", user);
			} else {
				System.out.println("--------------------------->已经登录<--------------------------");
				user = (User) session.getAttribute("currentUser");
				modelAndView.addObject("user", user);
			}
			// 放到cookie中
			String rpwd = request.getParameter("rpwd");
			// 如果需要记住账户就存储账号和密码
			if (rpwd != null && rpwd.equals("1")) {
				Cookie cookie = new Cookie("cookie_user", URLEncoder.encode(user.getUsername(), "UTF-8") + "-" + pass + "-" + rpwd);
				cookie.setMaxAge(60 * 60 * 24 * 7);// 保存
				response.addCookie(cookie);
				log.info("存储用户的cookie:" + user.getUsername() + "-" + pass);
			} /*
			 * else{// 如果没有要求记住账户密码，就保存账户 Cookie cookie = new
			 * Cookie("cookie_user", user.getUsername());
			 * cookie.setMaxAge(60*60*24*30); response.addCookie(cookie);
			 * log.info("存储用户的cookie:"+user.getUsername()); }
			 */

			modelAndView.addObject("file_baseList", file_baseList);
			modelAndView.addObject("userProperty", userProperty);
			String url = (String) session.getAttribute("refererUrl");
			url = (url == null || url.length() == 0) ? "/user/home.action" : url;
			modelAndView.setViewName("redirect:" + url);
		}
		// 还需添加日志
		return modelAndView;
	}

	/**
	 * 重置密码
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/reset_password")
	public ModelAndView resetPassword(HttpServletRequest request, User user) {
		// String url = request.getParameter("refererUrl");// 跳转登陆之前的url
		try {
			if (user.getPassword() != null && user.getPassword().length() > 0) {
				user.setPassword(MD5.MD5c(user.getPassword()));
			}
			userService.updateUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/user/to_login.action?reset=1");
	}

	@RequestMapping("/unlock_phone")
	@ResponseBody
	public String unlockPhone(HttpServletRequest request, HttpServletResponse response, Long id) {
		try {
			JSONObject result = new JSONObject();
			User user = (User) request.getSession().getAttribute("currentUser");
			if (user.getId() == id) {
				User user1 = new User();
				user1.setId(id);
				user1.setPhone("");
				userService.updateUser(user1);
				result.put("flag", 1);// ok
			} else {
				result.put("flag", 2);// failure
			}
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 检查手机号码是否重复
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/checkYzm")
	public ModelAndView checkYzm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String yzm = request.getParameter("yzm");
		String yzm1 = "";
		boolean flag = false;
		if (session.getAttribute("yzm") != null) {
			yzm1 = session.getAttribute("yzm").toString();
			flag = yzm1.equals(yzm) ? true : false;
		}
		JSONObject result = new JSONObject();
		if (!flag) {
			result.put("flag", "1");// 验证码错误
		}
		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping("/refresh_user")
	@ResponseBody
	public String refreshUser(HttpServletRequest request, HttpServletResponse response) {
		return "";

	}
	@UserLog(description = "手机普通登录")
	@RequestMapping("/loginPhone")
	public void loginByPhone(HttpServletRequest request, HttpServletResponse response, User user) throws Exception {
		JSONObject result = new JSONObject();
		String password = MD5.MD5c(user.getPassword());
		user.setPassword("");
		if (user.getUsername() != null && !user.getUsername().equals("") && userService.queryUser(user) != null) {
			user.setPassword(password);
			User u = userService.queryUser(user);
			if (u != null) {
				result.put("flag", "1");// ok
				u = userService.selectByPrimaryKey(u.getId());
				UserView userView = new UserView();
				userView.setIcon(u.getIcon());
				userView.setUsername(u.getUsername());
				userView.setId(u.getId());
				result.put("user", userView);
			} else {
				result.put("flag", "2");// 密码错误
			}
		} else {
			user.setPhone(user.getUsername());
			user.setUsername(null);
			User u1 = userService.queryUser(user);
			if (u1 != null) {
				user.setPassword(password);
				User u = userService.queryUser(user);
				if (u != null) {
					result.put("flag", "1");// ok
					u = userService.selectByPrimaryKey(u.getId());
					UserView userView = new UserView();
					userView.setIcon(u.getIcon());
					userView.setUsername(u.getUsername());
					userView.setId(u.getId());
					result.put("user", userView);
				} else {
					result.put("flag", "2");// 密码错误
				}
			} else
				result.put("flag", "3");// 账户不存在
		}
		ResponseUtil.write(response, result);
	}

	/**
	 * 手机注册
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@UserLog(description = "手机注册")
	@RequestMapping("/frontRegister_m")
	public void registerM(HttpServletRequest request, User user, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();
		result.put("status", 0);
		result.put("msg", "注册成功");
		if (user.getPhone() == null || user.getPhone().length() == 0) {
			// 手机号码为空
			result.put("status", 1);
			result.put("msg", "手机号码为空");
			ResponseUtil.write(response, result);
			return;
		} else {
			String regex = "^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}|17[0-9]{9}$";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(user.getPhone());
			if (!matcher.matches()) {
				// 手机格式不对
				result.put("status", 2);
				result.put("msg", "手机号码格式不对");
				ResponseUtil.write(response, result);
				return;
			} else {
				boolean flag = userService.selectByPhone(user.getPhone());
				if (flag) {
					// 手机号存在
					result.put("status", 3);
					result.put("msg", "手机号码已存在");
					ResponseUtil.write(response, result);
					return;
				}
			}
		}
		if (user.getUsername() == null || user.getUsername().length() == 0) {
			// 用户名为空
			result.put("status", 4);
			result.put("msg", "用户名为空");
			ResponseUtil.write(response, result);
			return;
		} else {
			boolean flag = userService.selectByUsername(user);
			if (flag) {
				// 用户存在
				result.put("status", 5);
				result.put("msg", "用户已存在");
				ResponseUtil.write(response, result);
				return;
			}
		}
		if (user.getPassword() == null || user.getPassword().length() == 0) {
			// 密码为空
			result.put("status", 6);
			result.put("msg", "密码为空");
			ResponseUtil.write(response, result);
			return;
		} else {
			String password = user.getPassword();
			user.setPassword(MD5.MD5c(password));
		}
		String networkIp = IpUtil.getIpAddr(request);
		if ("".equals(networkIp)) {
			networkIp = request.getRemoteAddr();
		}
		networkIp = StringUtils.isBlank(networkIp) ? "" : networkIp;

		UserProperty userProperty = new UserProperty();
		userProperty.setAttent_count(0);
		userProperty.setIs_attented_count(0);
		userProperty.setUpload_count(0);
		userProperty.setPrivate_file_count(0);
		userProperty.setPublic_file_count(0);
		userService.insertProperty(userProperty);
		user.setProperty_id(userProperty.getId());
		user.setSign_ip(networkIp);
		double wealth = 100;
		user.setWealth(wealth);
		user.setCreate_time(new Date());
		user.setUser_type("1");// 网站用户
		user.setStatus("1");// 正常
		// user.setIcon("/frontstage/images/default.png");
		CertModelPicture defaultImg = certModelPictureService.getDefaultImg(2);
		user.setIcon(defaultImg.getPath());
		user.setSign_type(0);
		userService.insert(user);
		HttpSession session = request.getSession();
		session.setAttribute("currentUser", user);
		UserInfo info = new UserInfo();
		info.setUser_id(user.getId());
		DefaultText defaultText = defaultTextService.selectTheOne(1L);
		if (defaultText != null) {
			info.setProfile(defaultText.getContent());
			info.setDefault_profile(1);
		}
		DefaultVarchar defaultVarchar = defaultVarcharService.selectTheOne(1L);
		if (defaultVarchar != null) {
			info.setSignature(defaultVarchar.getContent());
			info.setDefault_signature(1);
		}
		userInfoService.insert(info);
		ResponseUtil.write(response, result);
	}
	@RequestMapping("/getPhoneYzm1")
	public void getPhoneYzm1(HttpServletRequest request, HttpServletResponse response, String phone) throws Exception {
		System.out.println("电话号码是=" + phone);

		HttpClient client = new HttpClient();
		String Url = "http://106.ihuyi.cn/webservice/sms.php?method=Submit";
		PostMethod method = new PostMethod(Url);

		// client.getParams().setContentCharset("GBK");
		client.getParams().setContentCharset("UTF-8");
		method.setRequestHeader("ContentType", "application/x-www-form-urlencoded;charset=UTF-8");

		int mobile_code = (int) ((Math.random() * 9 + 1) * 100000);

		System.out.println("----------->这是手机验证码：" + mobile_code);

		String content = new String("您的验证码是：" + mobile_code + "。请不要把验证码泄露给其他人。");

		org.apache.commons.httpclient.NameValuePair[] data = { // 提交短信
		new org.apache.commons.httpclient.NameValuePair("account", "cf_bnsr"),
				new org.apache.commons.httpclient.NameValuePair("password", "e10adc3949ba59abbe56e057f20f883e"), // 密码使用32位MD5加密
				// new NameValuePair("password",
				// util.StringUtil.MD5Encode("密码")),
				new org.apache.commons.httpclient.NameValuePair("mobile", phone), new org.apache.commons.httpclient.NameValuePair("content", content), };

		method.setRequestBody(data);

		try {
			client.executeMethod(method);

			String SubmitResult = method.getResponseBodyAsString();

			// System.out.println(SubmitResult);

			Document doc = DocumentHelper.parseText(SubmitResult);
			Element root = doc.getRootElement();

			String code = root.elementText("code");
			String msg = root.elementText("msg");
			String smsid = root.elementText("smsid");
			System.out.println(code);
			System.out.println(msg);
			System.out.println(smsid);
			JSONObject result = new JSONObject();
			HttpSession session = request.getSession();
			if ("2".equals(code)) {
				System.out.println("短信提交成功");
				int interval=1800;
				session.setMaxInactiveInterval(interval);
				System.out.println(session.getId()+"session_id****************************");
				session.setAttribute("yzm", mobile_code + "");
				result.put("yzm", mobile_code + "");
				result.element("status", 0);
			} else {
				result.element("status", 1);
			}
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println(result.toString());
			out.flush();
			out.close();
		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		

	}
	@UserLog(description = "手机验证码登录")
	@RequestMapping("/loginPhoneYzm")
	public void loginByPhoneYzm(HttpServletRequest request, HttpServletResponse response, User user,String yzm) throws Exception {
		HttpSession session = request.getSession();
		JSONObject result = new JSONObject();
		String yzm1 = (String) session.getAttribute("yzm");
		
			if(yzm1!=null&&yzm1.equals(yzm)){
			User u = userService.queryUser(user);
			if (u != null) {
				result.put("flag", "1");// ok
				u = userService.selectByPrimaryKey(u.getId());
				UserView userView = new UserView();
				userView.setIcon(u.getIcon());
				userView.setUsername(u.getUsername());
				userView.setId(u.getId());
				result.put("user", userView);
			} else {
				//手机号码快捷登录
				user.setSign_type(1);
				user.setUsername(UUID.randomUUID().toString().replaceAll("-", "").substring(24));
				String networkIp = IpUtil.getIpAddr(request);
				if ("".equals(networkIp)) {
					networkIp = request.getRemoteAddr();
				}
				networkIp = StringUtils.isBlank(networkIp) ? "" : networkIp;

				UserProperty userProperty = new UserProperty();
				userProperty.setAttent_count(0);
				userProperty.setIs_attented_count(0);
				userProperty.setUpload_count(0);
				userProperty.setPrivate_file_count(0);
				userProperty.setPublic_file_count(0);
				userService.insertProperty(userProperty);
				user.setProperty_id(userProperty.getId());
				user.setSign_ip(networkIp);
				double wealth = 100;
				user.setWealth(wealth);
				user.setCreate_time(new Date());
				user.setUser_type("1");// 网站用户
				user.setStatus("1");// 正常
				// user.setIcon("/frontstage/images/default.png");
				CertModelPicture defaultImg = certModelPictureService.getDefaultImg(2);
				user.setIcon(defaultImg.getPath());
				userService.insert(user);
				UserInfo info = new UserInfo();
				info.setUser_id(user.getId());
				DefaultText defaultText = defaultTextService.selectTheOne(1L);
				if (defaultText != null) {
					info.setProfile(defaultText.getContent());
					info.setDefault_profile(1);
				}
				DefaultVarchar defaultVarchar = defaultVarcharService.selectTheOne(1L);
				if (defaultVarchar != null) {
					info.setSignature(defaultVarchar.getContent());
					info.setDefault_signature(1);
				}
				userInfoService.insert(info);
				result.put("flag", "1");// ok
				u = userService.selectByPrimaryKey(user.getId());
				UserView userView = new UserView();
				userView.setIcon(u.getIcon());
				userView.setUsername(u.getUsername());
				userView.setId(u.getId());
				result.put("user", userView);
			}
			}else{
				if(yzm1==null){
					result.put("flag", "2");// 验证码超时
				}
				else
				result.put("flag", "3");// 验证码错误
			}
		
		ResponseUtil.write(response, result);
		
	}

}
