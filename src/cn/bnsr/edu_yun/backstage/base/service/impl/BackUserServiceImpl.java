package cn.bnsr.edu_yun.backstage.base.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.mapper.RoleMapper;
import cn.bnsr.edu_yun.backstage.base.mapper.SysLogMapper;
import cn.bnsr.edu_yun.backstage.base.mapper.UserRoleMapper;
import cn.bnsr.edu_yun.backstage.base.po.UserRole;
import cn.bnsr.edu_yun.backstage.base.service.BackUserService;
import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.PageBase;
import cn.bnsr.edu_yun.backstage.base.view.StudyTimeView;
import cn.bnsr.edu_yun.backstage.base.view.UserDurationView;
import cn.bnsr.edu_yun.backstage.base.view.UserStatsView;
import cn.bnsr.edu_yun.backstage.base.view.UserTrackView;
import cn.bnsr.edu_yun.backstage.base.view.UserView;
import cn.bnsr.edu_yun.backstage.train.view.UserAppraiseView;
import cn.bnsr.edu_yun.comparator.UserStatsComparator;
import cn.bnsr.edu_yun.frontstage.base.mapper.OnlineUserMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.UserDurationMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.UserDurationPartMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.UserInfoMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.UserMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.UserPropertyMapper;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.po.User_attent;
import cn.bnsr.edu_yun.frontstage.base.service.UserAttentService;
import cn.bnsr.edu_yun.frontstage.base.service.UserDurationService;
import cn.bnsr.edu_yun.frontstage.base.service.UserFileService;
import cn.bnsr.edu_yun.frontstage.base.view.MyAttentionView;
import cn.bnsr.edu_yun.frontstage.base.view.NoteView;
import cn.bnsr.edu_yun.frontstage.resource.view.ResouceFileView;
import cn.bnsr.edu_yun.frontstage.train.mapper.CourseNoteMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.TopicAnswerMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.TopicQuestionMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.UserAppraiseMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.UserStudyTimeMapper;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyService;
import cn.bnsr.edu_yun.frontstage.train.view.StudyView;
import cn.bnsr.edu_yun.frontstage.train.view.TopicAnswerView;
import cn.bnsr.edu_yun.frontstage.train.view.TopicQuestionView;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.TimeUtil;

public class BackUserServiceImpl implements BackUserService {
	@Autowired
	private UserMapper userMapper;

	@Autowired
	private UserRoleMapper userRoleMapper;
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private UserPropertyMapper userPropertyMapper;
	@Autowired
	private UserInfoMapper userInfoMapper;
	@Autowired
	private SysLogMapper sysLogMapper;
	@Autowired
	private UserDurationMapper userDurationMapper;
	@Autowired
	private UserDurationPartMapper userDurationPartMapper;

	@Autowired
	private UserStudyTimeMapper userStudyTimeMapper;
	@Autowired
	private UserStudyService userStudyService;
	@Autowired
	private UserFileService userFileService;
	@Autowired
	private UserAppraiseMapper userAppraiseMapper;
	@Autowired
	private UserAttentService userAttentService;
	@Autowired
	private TopicQuestionMapper topicQuestionMapper;
	@Autowired
	private TopicAnswerMapper topicAnswerMapper;
	@Autowired
	private CourseNoteMapper courseNoteMapper;
	@Autowired
	private OnlineUserMapper onlineUserMapper;
	@Autowired
	private UserDurationService userDurationService;

	@Override
	public DataGrid datagrid(UserView userView) throws ParseException {
		DataGrid j = new DataGrid();
		userView.setPage(NumUtil.startingNum(userView.getPage(), userView.getRows()));
		j.setRows(changeModel(find(userView)));
		j.setTotal(total(userView));
		return j;
	}

	private List<UserView> changeModel(List<User> userList) {
		List<UserView> users = new ArrayList<UserView>();
		if (userList != null && userList.size() > 0) {
			for (User u : userList) {
				UserView uv = new UserView();
				BeanUtils.copyProperties(u, uv);

				List<UserRole> userRoleList = userRoleMapper.getByUserId(u.getId());
				UserInfo info = userInfoMapper.getByUserId(u.getId());
				String roleIds = "";
				String roleNames = "";
				boolean b = false;
				if (userRoleList != null && userRoleList.size() > 0) {
					for (UserRole ur : userRoleList) {
						if (ur != null) {
							if (b) {
								roleIds += ",";
								roleNames += ",";
							}
							roleIds += ur.getRole_id();
							roleNames += roleMapper.selectByPrimaryKey(ur.getRole_id()).getName();
							b = true;
						}
					}
				}
				if(info!=null){
					uv.setSex(info.getSex()+"");
				}
				uv.setRoleIds(roleIds);
				uv.setRoleNames(roleNames);
				uv.setStatusType(u.getStatus());
				users.add(uv);
			}
		}
		return users;
	}

	private List<User> find(UserView userView) throws ParseException {
		String timeEnd = userView.getTimeEnd();
		if (timeEnd != null && timeEnd != "") {
			userView.setTimeEnd(TimeUtil.afterNDay(timeEnd, 1));
		}

		return userMapper.find(userView);
	}

	private Long total(UserView userView) {
		return userMapper.count(userView);
	}

	@Override
	public void save(UserView userView) {
		// 创建用户关联信息
		UserProperty userProperty = new UserProperty();
		userProperty.setAttent_count(0);
		userProperty.setIs_attented_count(0);
		userProperty.setUpload_count(0);
		userProperty.setPrivate_file_count(0);
		userProperty.setPublic_file_count(0);
		userPropertyMapper.insertSelective(userProperty);

		User user = new User();
		BeanUtils.copyProperties(userView, user);
		user.setProperty_id(userProperty.getId());
		user.setCreate_time(new Date());
		userMapper.insertSelective(user);
		if (userView.getUser_type().equals("1")) {// 网站用户
			// 创建老师信息
			UserInfo teach = new UserInfo();
			teach.setUser_id(user.getId());
			userInfoMapper.insertSelective(teach);
		}

		this.saveUserRole(userView, user);
	}

	/**
	 * 保存用户和角色的关系 user_role关联表
	 */
	private void saveUserRole(UserView userView, User user) {
		List<UserRole> userRoleList = userRoleMapper.getByUserId(user.getId());
		if (userRoleList != null && userRoleList.size() > 0) {
			// 根据用户id删除关联角色
			for (UserRole ur : userRoleList) {
				userRoleMapper.deleteByPrimaryKey(ur.getId());
			}
		}
		if (userView.getRoleIds() != null) {
			for (String id : userView.getRoleIds().split(",")) {
				UserRole userRole = new UserRole();
				userRole.setRole_id(Long.parseLong(id.trim()));
				userRole.setUser_id(user.getId());
				userRoleMapper.insertSelective(userRole);
			}
		}
	}

	@Override
	public void update(UserView userView) {
		User u = new User();
		BeanUtils.copyProperties(userView, u);
		userMapper.updateByPrimaryKeySelective(u);
		String realname = userView.getRealname();
		if((realname!=null&&realname.length()>0)){
			UserInfo info = userInfoMapper.getByUserId(userView.getId());
			if(info!=null){
				info.setTrue_name(realname);
				userInfoMapper.updateByPrimaryKeySelective(info);
			}
		}
        if(userView.getRoleIds()!=null&&userView.getRoleIds().length()>0){
        	this.saveUserRole(userView, u);
        }
		
	}

	@Override
	public void delete(String ids) {
		if (ids != null) {
			for (String id : ids.split(",")) {
				User user = userMapper.selectByPrimaryKey(Long.parseLong(id.trim()));
				user.setStatus("3");// 逻辑删除
				userMapper.updateByPrimaryKeySelective(user);
			}
		}
	}

	@Override
	public User login(User user) {
		return userMapper.selectByUsernameAndPassword(user.getUsername(), user.getPassword());
	}

	@Override
	public String checkExis(UserView userView) {
		User user = new User();
		if (userView.getUsername() != null && !userView.getUsername().trim().equals("")) {
			user = userMapper.selectByUsername(userView.getUsername());
		}
		if (userView.getEmail() != null && !userView.getEmail().trim().equals("")) {
			user = userMapper.selectByEmail(userView.getEmail());
		}
		if (userView.getPhone() != null && !userView.getPhone().trim().equals("")) {
			user = userMapper.selectByPhone(userView.getPhone());
		}
		if (user!=null&&user.getId() != null) {
			return "1";// 已存在
		} else {
			return "2";// 未存在
		}
	}

	@Override
	public void doChangeStatus(UserView userView) {
		User user = userMapper.selectByPrimaryKey(userView.getId());
		user.setStatus(userView.getStatus());
		userMapper.updateByPrimaryKeySelective(user);
	}

	@Override
	public void saveRoleEdit(UserView userView) {
		if (userView.getIds() != null) {
			for (String id : userView.getIds().split(",")) {
				User user = userMapper.selectByPrimaryKey(Long.parseLong(id));
				this.saveUserRole(userView, user);
			}
		}
	}

	@Override
	public List<UserStatsView> queryUserStats(UserStatsView userStats) throws ParseException {
		Date date = new Date();
		List<String> list = new ArrayList<String>();
		if (userStats.getYear().equals("")) {// 年月没选
			// 获的当前年月
			userStats.setDays(TimeUtil.getDate());
			date = TimeUtil.stringFormatDate(userStats.getDays());
			list = TimeUtil.getAllTheDateOftheMonth(date);
		} else {
			if (userStats.getMonth().equals("")) {// 只选年
				for (int i = 1; i <= 12; i++) {
					String month = i >= 10 ? i + "" : "0" + i;
					list.add(userStats.getYear() + "-" + month);
				}
				userStats.setDays(userStats.getYear());
			} else {// 年月都选
				userStats.setDays(userStats.getYear() + "-" + userStats.getMonth());
				date = TimeUtil.stringFormatDate(userStats.getDays());
				list = TimeUtil.getAllTheDateOftheMonth(date);
			}
		}

		List<UserStatsView> userStatsList = userMapper.queryUserStats(userStats);
		if (userStatsList.size() != list.size()) {// 如果不相等，证明有缺少日期
			List<String> userList = new ArrayList<String>();
			for (UserStatsView u : userStatsList) {
				userList.add(u.getDays());
			}
			list.removeAll(userList);// 差集
			for (int i = 0; i < list.size(); i++) {// 补全当前月日期
				UserStatsView user = new UserStatsView();
				user.setDays(list.get(i));
				user.setFrontNum(0);
				userStatsList.add(user);
			}
		}

		Collections.sort(userStatsList, new UserStatsComparator());// 排序

		return userStatsList;
	}


	@Override
	public List<UserStatsView> queryRemainStats(UserStatsView userStats) throws ParseException {
		String year = userStats.getYear();
		String timeType = userStats.getTimeType();
		List<String> timelist = new ArrayList<>();
		List<UserStatsView> userStatsList = new ArrayList<UserStatsView>();
		if (year != null && year != "") {
			userStats.setStartTime(TimeUtil.getLastYearDecember(year));
			userStats.setEndTime(TimeUtil.getYearDecember(year));
			userStats.setReturnTime(TimeUtil.getYearNovember(year));
			timelist = TimeUtil.getAllMouths();
			List<UserStatsView> adduserStatsList = userMapper.queryAddUserStatsByMouths(userStats);
			List<UserStatsView> activeUserStatsList = sysLogMapper.queryActiveUserByMouth(userStats);
			List<UserStatsView> returnUserStatsList = sysLogMapper.queryReturnUserByMouth(userStats);
			for (int i = 1; i < 13; i++) {
				UserStatsView u = new UserStatsView();
				if (i < 10) {
					u.setDays("0" + i);
				} else {
					u.setDays(i + "");
				}
				u.setNewNum(0);
				u.setActiveNum(0);
				u.setReturnNum(0);
				u.setTimeType(timeType);
				userStatsList.add(u);
			}
			for (UserStatsView u : adduserStatsList) {
				UserStatsView stats = userStatsList.get(Integer.parseInt(u.getDays()) - 1);
				stats.setNewNum(u.getNewNum());
			}
			for (UserStatsView u : activeUserStatsList) {
				UserStatsView stats = userStatsList.get(Integer.parseInt(u.getDays()) - 1);
				stats.setActiveNum(u.getActiveNum());
			}
			for (UserStatsView u : returnUserStatsList) {
				UserStatsView stats = userStatsList.get(Integer.parseInt(u.getDays()) - 1);
				stats.setReturnNum(u.getReturnNum());
			}
		} else {// 非月活跃度用户
			userStats.setStartTime(TimeUtil.afterNDay(userStats.getDays(), 1));
			if ("0".equals(timeType)) {// 次日
				userStats.setEndTime(TimeUtil.afterNDay(userStats.getDays(), 2));
			} else if ("1".equals(timeType)) {// 三日
				userStats.setEndTime(TimeUtil.afterNDay(userStats.getDays(), 4));
			} else if ("2".equals(timeType)) {// 一周
				userStats.setEndTime(TimeUtil.afterNDay(userStats.getDays(), 8));
			}
			timelist = TimeUtil.getBetweenDates(TimeUtil.stringFormatDate1(userStats.getDays()),
					TimeUtil.stringFormatDate1(userStats.getEndTime()));
			List<Long> signUserId = userMapper.queryUserId(userStats);// timelist.get(0)
			if (signUserId != null && signUserId.size() > 0) {// 起始时间有新用户注册
				// 跟踪
				userStats.setRemain_type(1);// 获取single day date
				userStats.setCountNum(signUserId.size());
				if (!"0".equals(timeType)) {// 不是次日
					userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), -1));
				}
				userStats.setSort(1);
				userStatsList = sysLogMapper.queryloginRemain(userStats);
				// 获取第一天的注册数据
				UserStatsView signSatas = new UserStatsView();
				signSatas.setDays(timelist.get(0));
				signSatas.setTimeType(timeType);
				signSatas.setNewNum(signUserId.size());
				signSatas.setSort(1);
				signSatas.setRemainRatio(100);
				userStatsList.add(signSatas);
				if (!"0".equals(timeType)) {// 不是次日
					userStats.setOneDay(timelist.get(timelist.size() - 1));
					userStats.setRemain_type(0);// 求最后一天的登录的总和
					userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), 1));
					List<UserStatsView> sumLoginUser = sysLogMapper.queryloginRemain(userStats);
					if (sumLoginUser.size() > 0) {
						userStatsList.add(sumLoginUser.get(0));
					}
				}
			}
		}
		if (userStatsList.size() != timelist.size()) {// 如果不相等，证明有缺少日期
			// 有数据日期
			List<String> dataList = new ArrayList<String>();
			for (int i = 0; i < userStatsList.size(); i++) {
				dataList.add(userStatsList.get(i).getDays());
			}
			timelist.removeAll(dataList);// 差集
			for (int i = 0; i < timelist.size(); i++) {// 补全当前月日期
				UserStatsView userStat = new UserStatsView();
				userStat.setDays(timelist.get(i));
				userStat.setNewNum(0);
				userStat.setActiveNum(0);
				userStat.setReturnNum(0);
				userStat.setRemainRatio(0);
				userStat.setTimeType(timeType);
				if (year == null || year == "") {
					userStat.setSort(1);
				}
				userStatsList.add(userStat);
			}
		}
		Collections.sort(userStatsList, new UserStatsComparator());// 排序
		return userStatsList;

	}

	public List<UserStatsView> queryUserStats1(UserStatsView userStats) throws ParseException {
		Date date = new Date();
		List<String> list = new ArrayList<String>();
		String timeType = userStats.getTimeType();
		if ("0".equals(timeType)) {// 本月
			// 获的当前年月
			userStats.setDays(TimeUtil.getDate());
		} else if ("1".equals(timeType)) {// 上月
			userStats.setDays(TimeUtil.getLastDate());
		} else if ("2".equals(timeType)) {// 近三月
			userStats.setStartTime(TimeUtil.getBeforeMarch1());
			userStats.setEndTime(TimeUtil.dateToString2(new Date()));
		} else if ("4".equals(timeType)) {// 某一天
			userStats.setDays(TimeUtil.dateToString1(TimeUtil.stringFormatDate1(userStats.getOneDay())));
		}
		if ("0".equals(timeType) || "1".equals(timeType)) {// 本月、上月
			date = TimeUtil.stringFormatDate(userStats.getDays());
			list = TimeUtil.getAllTheDateOftheMonth(date);
		} else if ("4".equals(timeType)) {
			list = TimeUtil.getAllTheHourOfTheDay();
		} else {// 近三月、起止时间
			list = TimeUtil.getBetweenDates(TimeUtil.stringFormatDate1(userStats.getStartTime()),
					TimeUtil.afterNDay(TimeUtil.stringFormatDate1(userStats.getEndTime()), 1));
			// userStats.setStartTime(userStats.getStartTime());
			// userStats.setEndTime(userStats.getEndTime());
		}
		List<UserStatsView> userStatsList = new ArrayList<UserStatsView>();
		if (userStats.getLogType().indexOf("0") >= 0) {// 注册用户
			userStatsList = userMapper.queryUserStats1(userStats);
		} else if (userStats.getLogType().indexOf("1") >= 0) {// 登录用户
			userStatsList = sysLogMapper.queryloginStats(userStats);
		}
		if (userStatsList.size() != list.size()) {// 如果不相等，证明有缺少日期
			int countNum = 0;
			// 有数据日期
			List<String> dataList = new ArrayList<String>();
			for (int i = 0; i < userStatsList.size(); i++) {
				dataList.add(userStatsList.get(i).getDays());
				if (i == 0) {
					countNum = userStatsList.get(i).getCountNum();
				}
			}
			list.removeAll(dataList);// 差集
			for (int i = 0; i < list.size(); i++) {// 补全当前月日期
				UserStatsView userStat = new UserStatsView();
				userStat.setDays(list.get(i));
				userStat.setNewNum(0);
				userStat.setCountNum(countNum);
				userStat.setTimeType(timeType);
				userStatsList.add(userStat);
			}
		}
		Collections.sort(userStatsList, new UserStatsComparator());// 排序
		return userStatsList;
	}

	@Override
	public List<UserStatsView> queryUserTrend(UserStatsView userStats) throws ParseException {
		List<UserStatsView> userStatsList = new ArrayList<UserStatsView>();
		List<String> timelist = new ArrayList<String>();
		List<String> alldays = new ArrayList<String>();
		int timeUnit = userStats.getTimeUnit();
		String logType = userStats.getLogType();
		Integer compare = userStats.getCompare();
		if (timeUnit == 0) {// 按时
			String[] hourlist = TimeUtil.getHourList();
			for (int i = 0; i < hourlist.length; i++) {
				UserStatsView userStats1 = new UserStatsView();
				userStats1.setDays(hourlist[i]);
				userStatsList.add(userStats1);
			}
		} else if (timeUnit == 1) {// 按天
			// 选择某一天和一段时间一定分开
			if (userStats.getDays() != null && userStats.getDays() != "") {// 某一天
				UserStatsView userStats1 = new UserStatsView();
				userStats1.setDays(userStats.getDays());
				userStats1.setSort(1);// 按天排序
				userStatsList.add(userStats1);
			}
		}
		if (userStats.getStartTime() != null && userStats.getEndTime() != null && userStats.getStartTime() != ""
				&& userStats.getEndTime() != "") {// 一段时间
			if (timeUnit != 0) {// 不是按时，timelist才有意义
				alldays = TimeUtil.getBetweenDates(TimeUtil.stringFormatDate1(userStats.getStartTime()),
						TimeUtil.afterNDay(TimeUtil.stringFormatDate1(userStats.getEndTime()), 1));
			}
			if (timeUnit == 1) {// 按天
				// 选择某一天和一段时间一定分开
				timelist = alldays;
			} else if (timeUnit == 2) {// 按周
				timelist = TimeUtil.getMonday(alldays);// 获取所有日期所在的星期一的日期
			} else if (timeUnit == 3) {// 按月
				timelist = TimeUtil.getFirstdayofmouth(userStats.getStartTime(), userStats.getEndTime());// 获取时间段内的每月的第一天
			}
			if (timeUnit != 0) {// 小时的list和date的list已不同
				timelist.set(0, userStats.getStartTime());// 默认初始时间是起始时间
				for (int i = 0; i < timelist.size(); i++) {
					UserStatsView userStats1 = new UserStatsView();
					userStats1.setDays(timelist.get(i));
					userStats1.setSort(1);// 按天排序
					userStatsList.add(userStats1);
				}
			}
			userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), 1));
		}
		List<UserStatsView> userStatsAddList = sysLogMapper.queryUserAddTrend(userStats);
		if (userStatsAddList.size() > 0 && (timeUnit == 2 || timeUnit == 3)) {// 按周或按月
			if(userStatsAddList.get(0).getDays().equals(timelist.get(0))){
				userStatsAddList.get(0).setDays(userStats.getStartTime());
			}
		}
		List<UserStatsView> userStatsloginList = sysLogMapper.queryUserloginTrend(userStats);
		if (userStatsloginList.size() > 0 && (timeUnit == 2 || timeUnit == 3)) {// 按周或按月
			if(userStatsloginList.get(0).getDays().equals(timelist.get(0))){
				userStatsloginList.get(0).setDays(userStats.getStartTime());
			}
		}
		List<UserStatsView> userStatsVisitList = userDurationMapper.meanVisitTrend(userStats);
		if (userStatsVisitList.size() > 0 && (timeUnit == 2 || timeUnit == 3)) {// 按周或按月
			if(userStatsVisitList.get(0).getDays().equals(timelist.get(0))){
				userStatsVisitList.get(0).setDays(userStats.getStartTime());
			}
		}
		List<UserStatsView> userStatsnewVisitList = userDurationMapper.meanNewVisitTrend(userStats);
		if (userStatsnewVisitList.size() > 0 && (timeUnit == 2 || timeUnit == 3)) {// 按周或按月
			if(userStatsnewVisitList.get(0).getDays().equals(timelist.get(0))){
				userStatsnewVisitList.get(0).setDays(userStats.getStartTime());
			}
		}
		List<UserStatsView> userStatsCompareList = new ArrayList<UserStatsView>();
		if (compare != null && logType.length() == 1) {
			if (compare == 0) {// 对比前一日
				userStats.setDays(TimeUtil.afterNDay(userStats.getDays(), -1));
			} else if (compare == 1) {// 对比上一周期
				userStats.setDays(TimeUtil.afterNDay(userStats.getDays(), -7));
			}
			if ("0".equals(logType)) {// 比较新增用户
				userStatsCompareList = sysLogMapper.queryUserAddTrend(userStats);
			} else if ("1".equals(logType)) {// 比较登录用户
				userStatsCompareList = sysLogMapper.queryUserloginTrend(userStats);
			} else if ("2".equals(logType)) {// 比较平均访问时长
				userStatsCompareList = userDurationMapper.meanVisitTrend(userStats);
			} else if ("3".equals(logType)) {// 比较新用户平均访问时长
				userStatsCompareList = userDurationMapper.meanNewVisitTrend(userStats);
			}
		}
		// 组装
		// 新增用户 0
		for (UserStatsView u : userStatsAddList) {
			for (UserStatsView u1 : userStatsList) {
				if (u1.getDays().equals(u.getDays())) {
					u1.setNewNum(u.getNewNum());
					if (logType.charAt(0) == '0') {// 包含只有一个指标或两个指标第一个是0
						u1.setNewNum1(u.getNewNum());
					}
				}
			}
		}
		// 登录用户 1
		for (UserStatsView u : userStatsloginList) {
			for (UserStatsView u1 : userStatsList) {
				if (u1.getDays().equals(u.getDays())) {
					u1.setLoginNum(u.getNewNum());
					if (logType.charAt(0) == '1') {// 包含只有一个指标或两个指标第一个是1
						u1.setNewNum1(u.getNewNum());
					}
					if (logType.length() == 3 && logType.charAt(2) == '1') {// 第二个指标是1
						u1.setNewNum2(u.getNewNum());
					}
				}
			}
		}
		// 平均访问时长 2
		for (UserStatsView u : userStatsVisitList) {
			for (UserStatsView u1 : userStatsList) {
				if (u1.getDays().equals(u.getDays())) {
					u1.setMeanVisitTime(u.getInterval1());
					if (logType.charAt(0) == '2') {// 包含只有一个指标或两个指标第一个是2
						u1.setInterval1(u.getInterval1());
					}
					if (logType.length() == 3 && logType.charAt(2) == '2') {// 第二个指标是2
						u1.setInterval2(u.getInterval1());
					}
				}
			}
		}
		// 新用户平均访问时长 3
		for (UserStatsView u : userStatsnewVisitList) {
			for (UserStatsView u1 : userStatsList) {
				if (u1.getDays().equals(u.getDays())) {
					u1.setNewMeanVisitTime(u.getInterval1());
					if (logType.charAt(0) == '3') {// 包含只有一个指标或两个指标第一个是3
						u1.setInterval1(u.getInterval1());
					}
					if (logType.length() == 3 && logType.charAt(2) == '3') {// 第二个指标是3
						u1.setInterval2(u.getInterval1());
					}
				}
			}
		}
		// 比较
		if (compare != null) {// 有比较 一般都是对某一天某一个指标进行比较，所以days不会相等，都是一个数据
			for (UserStatsView u : userStatsCompareList) {// 一定是某一天才可以比较
				for (UserStatsView u1 : userStatsList) {
					if(timeUnit==0){//按时
						if (u1.getDays().equals(u.getDays())) {
							if ("0".equals(logType) || "1".equals(logType)) {
								u1.setNewNum2(u.getNewNum());
							} else if ("2".equals(logType) || "3".equals(logType)) {
								u1.setInterval2(u.getInterval1());
							}
						}
					}else{//按日
						if (compare == 0 && TimeUtil.afterNDay(u1.getDays(), -1).equals(u.getDays())) {// 对比前一日
							u1.setOneDay(u.getDays());
							if ("0".equals(logType) || "1".equals(logType)) {
								u1.setNewNum2(u.getNewNum());
							} else if ("2".equals(logType) || "3".equals(logType)) {
								u1.setInterval2(u.getInterval1());
							}
						} else if (compare == 1 && TimeUtil.afterNDay(u.getDays(), -7).equals(u.getDays())) {// 对比上一周期
							u1.setOneDay(u.getDays());
							if ("0".equals(logType) || "1".equals(logType)) {
								u1.setNewNum2(u.getNewNum());
							} else if ("2".equals(logType) || "3".equals(logType)) {
								u1.setInterval2(u.getInterval1());
							}
						}
					}
					
				}
			}
		}
		Collections.sort(userStatsList, new UserStatsComparator());// 排序
		return userStatsList;
	}

	@Override
	public List<UserStatsView> queryUserRemain(UserStatsView userStats) throws ParseException {
		List<UserStatsView> userStatsList = new ArrayList<UserStatsView>();
		List<String> timelist = new ArrayList<String>();
		int timeUnit = userStats.getTimeUnit();
		String timeType = userStats.getTimeType();
		Integer compare = userStats.getCompare();
		String logType = userStats.getLogType();
		// Base unit
		if (timeUnit == 0) {// 区间
			timelist = TimeUtil.getBetweenDates(TimeUtil.stringFormatDate1(userStats.getDays()),
					TimeUtil.stringFormatDate1(userStats.getEndTime()));
		} else if (timeUnit == 1) {// 点日
			timelist.add(TimeUtil.afterNDay(userStats.getEndTime(), -1));
		}
		List<Long> signUserId = userMapper.queryUserId(userStats);
		if (signUserId != null && signUserId.size() > 0) {// 起始时间有新用户注册
			// 跟踪
			userStats.setRemain_type(1);// 获取single day date
			userStats.setCountNum(signUserId.size());
			if (!"0".equals(timeType)) {// 不是次日
				userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), -1));
			}
			userStats.setSort(1);
			userStats.setCountNum(signUserId.size());
			if (timeUnit == 0) {// 区间
				userStatsList = sysLogMapper.queryloginRemain(userStats);
				// 获取第一天的注册数据
				UserStatsView signSatas = new UserStatsView();
				signSatas.setDays(timelist.get(0));
				signSatas.setNewNum(signUserId.size());
				signSatas.setSort(1);
				signSatas.setRemainRatio(100);
				userStatsList.add(signSatas);
				// 求最后一天的登录的总和
				if (!"0".equals(timeType)) {// 不是次日
					userStats.setOneDay(timelist.get(timelist.size() - 1));
					userStats.setRemain_type(0);// 求最后一天的登录的总和
					userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), 1));
					List<UserStatsView> sumLoginUser = sysLogMapper.queryloginRemain(userStats);
					if (sumLoginUser.size() > 0) {
						userStatsList.add(sumLoginUser.get(0));
					}
				}
			} else if (timeUnit == 1) {// 点日
				userStats.setStartTime(timelist.get(0));
				userStats.setEndTime(TimeUtil.afterNDay(timelist.get(0), 1));
				userStatsList = sysLogMapper.queryloginRemain(userStats);
			}
		}
		if (userStatsList.size() != timelist.size()) {// 如果不相等，证明有缺少日期
			List<String> userList = new ArrayList<String>();
			for (UserStatsView u : userStatsList) {
				userList.add(u.getDays());
				// 归纳
				if (logType.length() > 0) {
					if (logType.charAt(0) == '0') {// 留存数
						u.setNewNum1(u.getNewNum());
					} else if (logType.charAt(0) == '1') {// 留存率
						u.setNewNum1(u.getRemainRatio());
					} else if (logType.charAt(0) == '2') {// 留失数
						u.setNewNum1(u.getLossNum());
					} else if (logType.charAt(0) == '3') {// 留失率
						u.setNewNum1(u.getLossRatio());
					}
				}
				if (logType.length() == 3) {
					if (logType.charAt(2) == '0') {// 留存数
						u.setNewNum2(u.getNewNum());
					} else if (logType.charAt(2) == '1') {// 留存率
						u.setNewNum2(u.getRemainRatio());
					} else if (logType.charAt(2) == '2') {// 留失数
						u.setNewNum2(u.getLossNum());
					} else if (logType.charAt(2) == '3') {// 留失率
						u.setNewNum2(u.getLossRatio());
					}
				}
			}
			timelist.removeAll(userList);// 差集
			for (int i = 0; i < timelist.size(); i++) {// 补全当前月日期
				UserStatsView user = new UserStatsView();
				user.setSort(1);
				user.setDays(timelist.get(i));
				if (signUserId.size() > 0) {// 只有存在注册用户，流失才有意义
					user.setLossNum(signUserId.size());
					user.setLossRatio(100);
				}
				if (logType.length() > 0) {
					if (logType.charAt(0) == '2') {// 留失数
						user.setNewNum1(signUserId.size());
					} else if (logType.charAt(0) == '3') {// 留失率
						user.setNewNum1(100);
					}
				}
				if (logType.length() == 3) {
					if (logType.charAt(2) == '2') {// 留失数
						user.setNewNum2(signUserId.size());
					} else if (logType.charAt(2) == '3') {// 留失率
						user.setNewNum2(100);
					}
				}
				userStatsList.add(user);
			}
		}

		if (compare != null && logType.length() == 1) {
			List<UserStatsView> userStatsCompareList = new ArrayList<UserStatsView>();
			if (compare == 0) {// 对比前一日
				userStats.setDays(TimeUtil.afterNDay(userStats.getDays(), -1));
				userStats.setStartTime(TimeUtil.afterNDay(userStats.getStartTime(), -1));
				userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), -1));
			} else if (compare == 1) {// 对比上一周期
				userStats.setDays(TimeUtil.afterNDay(userStats.getDays(), -7));
				userStats.setStartTime(TimeUtil.afterNDay(userStats.getStartTime(), -7));
				userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), -7));
			}
			List<Long> compareUserId = userMapper.queryUserId(userStats);
			if (compareUserId != null && compareUserId.size() > 0) {// 起始时间有新用户注册
				// 跟踪
				userStats.setRemain_type(1);// 获取single day date
				userStats.setCountNum(compareUserId.size());
				if (!"0".equals(timeType)) {// 不是次日
					userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), -1));
				}
				userStats.setSort(1);
				userStats.setCountNum(compareUserId.size());
				if (timeUnit == 0) {// 区间
					userStatsCompareList = sysLogMapper.queryloginRemain(userStats);
					// 获取第一天的注册数据
					UserStatsView signSatas = new UserStatsView();
					signSatas.setDays(timelist.get(0));
					signSatas.setNewNum(compareUserId.size());
					signSatas.setSort(1);
					signSatas.setRemainRatio(100);
					userStatsCompareList.add(signSatas);
					// 求最后一天的登录的总和
					if (!"0".equals(timeType)) {// 不是次日
						userStats.setOneDay(userStats.getEndTime());
						userStats.setRemain_type(0);// 求最后一天的登录的总和
						userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), 1));
						List<UserStatsView> sumLoginUser = sysLogMapper.queryloginRemain(userStats);
						if (sumLoginUser.size() > 0) {
							userStatsCompareList.add(sumLoginUser.get(0));
						}
					}
				} else if (timeUnit == 1) {// 点日
					userStats.setStartTime(TimeUtil.afterNDay(userStats.getEndTime(), -1));
					userStatsCompareList = sysLogMapper.queryloginRemain(userStats);
					if (userStatsCompareList != null && userStatsCompareList.size() == 0) {
						UserStatsView u = new UserStatsView();
						u.setLossNum(compareUserId.size());
						u.setLossRatio(100);
						u.setDays(userStats.getStartTime());
						userStatsCompareList.add(u);
					}
				}
			}

			// 组装
			if (userStatsCompareList.size() > 0) {
				for (UserStatsView u : userStatsList) {
					for (UserStatsView u1 : userStatsCompareList) {
						if (compare == 0 && TimeUtil.afterNDay(u.getDays(), -1).equals(u1.getDays())) {// 对比前一日
							u.setOneDay(u1.getDays());
							if (logType.equals("0")) {// 留存数
								u.setNewNum2(u1.getNewNum());
							} else if (logType.equals("1")) {// 留存率
								u.setNewNum2(u1.getRemainRatio());
							} else if (logType.equals("2")) {// 流失数
								u.setNewNum2(u1.getLossNum());
							} else if (logType.equals("3")) {// 流失率
								u.setNewNum2(u1.getLossRatio());
							}
						} else if (compare == 1 && TimeUtil.afterNDay(u.getDays(), -7).equals(u1.getDays())) {// 对比上一周期
							u.setOneDay(u1.getDays());
							if (logType.equals("0")) {// 留存数
								u.setNewNum2(u1.getNewNum());
							} else if (logType.equals("1")) {// 留存率
								u.setNewNum2(u1.getRemainRatio());
							} else if (logType.equals("2")) {// 流失数
								u.setNewNum2(u1.getLossNum());
							} else if (logType.equals("3")) {// 流失率
								u.setNewNum2(u1.getLossRatio());
							}
						}
					}
					if (u.getOneDay() == null) {
						if (logType.equals("2")) {// 流失数
							u.setNewNum2(compareUserId.size());
						} else if (logType.equals("3")) {// 流失率
							u.setNewNum2(100);
						}
					}
				}
			}

		}

		Collections.sort(userStatsList, new UserStatsComparator());// 排序

		return userStatsList;
	}

	@Override
	public List<UserStatsView> queryUserActive(UserStatsView userStats) throws ParseException {
		List<UserStatsView> userStatsList = new ArrayList<UserStatsView>();
		List<String> timelist = new ArrayList<String>();
		String logType = userStats.getLogType();
		Integer compare = userStats.getCompare();
		if (userStats.getDays() != null && userStats.getDays().length() > 0) {// 某一天
			UserStatsView userStats1 = new UserStatsView();
			userStats1.setDays(userStats.getDays());
			userStats1.setSort(1);// 按天排序
			userStatsList.add(userStats1);
		} else if (userStats.getStartTime() != null && userStats.getEndTime() != null && userStats.getStartTime() != ""
				&& userStats.getEndTime() != "") {// 一段时间
			timelist = TimeUtil.getBetweenDates(TimeUtil.stringFormatDate1(userStats.getStartTime()),
					TimeUtil.afterNDay(TimeUtil.stringFormatDate1(userStats.getEndTime()), 1));
			for (int i = 0; i < timelist.size(); i++) {
				UserStatsView userStats1 = new UserStatsView();
				userStats1.setDays(timelist.get(i));
				userStats1.setSort(1);// 按天排序
				userStatsList.add(userStats1);
			}
			userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), 1));
		}
		List<UserStatsView> activeList = userDurationPartMapper.queryActiveStats(userStats);
		List<UserStatsView> returnList = new ArrayList<UserStatsView>();
		if (userStats.getStatus() == 2 && logType.indexOf("2") != -1 && userStats.getOneDay() != null
				&& userStats.getOneDay().length() > 0) {// 老用户
			returnList = sysLogMapper.queryReturnNum(userStats);
		}
		// 组装
		// 活跃与尝试用户
		for (UserStatsView u : activeList) {
			for (UserStatsView u1 : userStatsList) {
				if (u1.getDays().equals(u.getDays())) {
					u1.setActiveNum(u.getActiveNum());
					u1.setTryNum(u.getTryNum());
					if (logType.charAt(0) == '0') {// 包含只有一个指标或两个指标第一个是0
						u1.setNewNum1(u.getActiveNum());
					} else if (logType.charAt(0) == '1') {// 包含只有一个指标或两个指标第一个是1
						u1.setNewNum1(u.getTryNum());
					}
					if (logType.length() == 3 && logType.charAt(2) == '1') {// 两个指标第2个是1
						u1.setNewNum2(u.getTryNum());
					}
				}
			}
		}
		// 僵尸回归用户
		for (UserStatsView u : returnList) {
			for (UserStatsView u1 : userStatsList) {
				if (u1.getDays().equals(u.getDays())) {
					u1.setReturnNum(u.getReturnNum());
					if (logType.charAt(0) == '2') {// 只有一个指标2
						u1.setNewNum1(u.getReturnNum());
					}
					if (logType.length() == 3 && logType.charAt(2) == '2') {// 两个指标第2个是2
						u1.setNewNum2(u.getReturnNum());
					}
				}
			}
		}
		if (compare != null && logType.length() == 1) {
			List<UserStatsView> userStatsCompareList = new ArrayList<UserStatsView>();
			if (userStats.getDays() != null && userStats.getDays().length() > 0) {// 某一天
				if (compare == 0) {// 对比前一日
					userStats.setDays(TimeUtil.afterNDay(userStats.getDays(), -1));
				} else if (compare == 1) {// 对比上一周期
					userStats.setDays(TimeUtil.afterNDay(userStats.getDays(), -7));
				}
			} else if (userStats.getStartTime() != null && userStats.getEndTime() != null
					&& userStats.getStartTime() != "" && userStats.getEndTime() != "") {// 一段时间
				if (compare == 0) {// 对比前一日
					userStats.setStartTime(TimeUtil.afterNDay(userStats.getStartTime(), -1));
					userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), -1));
				} else if (compare == 1) {// 对比上一周期
					userStats.setStartTime(TimeUtil.afterNDay(userStats.getStartTime(), -7));
					userStats.setEndTime(TimeUtil.afterNDay(userStats.getEndTime(), -7));
				}
			}

			if (logType.equals("0") || logType.equals("1")) {
				userStatsCompareList = userDurationPartMapper.queryActiveStats(userStats);
			} else if (logType.equals("2") && userStats.getStatus() == 2) {// 老用户
				userStatsCompareList = sysLogMapper.queryReturnNum(userStats);
			}
			// 组装比较
			for (UserStatsView u : userStatsList) {
				for (UserStatsView u1 : userStatsCompareList) {
					if (compare == 0 && TimeUtil.afterNDay(u.getDays(), -1).equals(u1.getDays())) {// 对比前一日
						u.setOneDay(u1.getDays());
						if (logType.equals("0")) {// 活跃用户
							u.setNewNum2(u1.getActiveNum());
						} else if (logType.equals("1")) {// 尝试用户
							u.setNewNum2(u1.getTryNum());
						} else if (logType.equals("2")) {// 僵尸用户
							u.setNewNum2(u1.getReturnNum());
						}
					} else if (compare == 1 && TimeUtil.afterNDay(u.getDays(), -7).equals(u1.getDays())) {// 对比上一周期
						u.setOneDay(u1.getDays());
						if (logType.equals("0")) {// 活跃用户
							u.setNewNum2(u1.getActiveNum());
						} else if (logType.equals("1")) {// 尝试用户
							u.setNewNum2(u1.getTryNum());
						} else if (logType.equals("2")) {// 僵尸用户
							u.setNewNum2(u1.getReturnNum());
						}
					}
				}
			}
		}
		Collections.sort(userStatsList, new UserStatsComparator());// 排序
		return userStatsList;
	}

	@Override
	public List<UserTrackView> slectAllTrack(UserTrackView userTrackView) {
		return userMapper.queryUserTrackView(userTrackView);
	}

	@Override
	public Long totalTrack() {

		return userMapper.countAllUser();
	}

	@Override
	public DataGrid datagridTrack(UserTrackView userTrackView) throws Exception {
		DataGrid j = new DataGrid();
		userTrackView.setPage(NumUtil.startingNum(userTrackView.getPage(), userTrackView.getRows()));
		j.setRows(slectAllTrack(userTrackView));
		j.setTotal(totalTrack());
		return j;
	}

	@Override
	public DataGrid datagridTrackIndex(long user_id, int index, PageBase p) throws Exception {
		DataGrid j = new DataGrid();
		// index 0~11 需要分页
		if (index == 0) {
			UserDurationView userDurationView = new UserDurationView();
			BeanUtils.copyProperties(p, userDurationView);
			userDurationView.setPage(NumUtil.startingNum(userDurationView.getPage(), userDurationView.getRows()));
			userDurationView.setUser_id(user_id);
			j.setRows(userDurationMapper.selectViewByUserId(userDurationView));
			j.setTotal(userDurationMapper.selectViewByUserIdCount(userDurationView) + 0L);
		}
		if (index == 1) {
			StudyTimeView studyTimeView = new StudyTimeView();
			BeanUtils.copyProperties(p, studyTimeView);
			studyTimeView.setPage(NumUtil.startingNum(studyTimeView.getPage(), studyTimeView.getRows()));
			studyTimeView.setUser_id(user_id);
			j.setRows(userStudyTimeMapper.selectViewByUserId(studyTimeView));
			j.setTotal(userStudyTimeMapper.selectViewByUserIdCount(studyTimeView));
		}
		if (index == 2 || index == 3) {
			StudyView studyView = new StudyView();
			BeanUtils.copyProperties(p, studyView);
			studyView.setPage(NumUtil.startingNum(studyView.getPage(), studyView.getRows()));
			studyView.setUser_id(user_id);
			studyView.setIs_studyed(-1);
			studyView.setStartLine(studyView.getPage());
			if (index == 2)
				studyView.setSource_type(0);
			else
				studyView.setSource_type(1);
			j.setRows(userStudyService.queryUserStudy(studyView));
			j.setTotal(userStudyService.countUserSutdy(studyView) + 0L);
		}
		if (index == 4 || index == 5) {
			ResouceFileView resouceFileView = new ResouceFileView();
			BeanUtils.copyProperties(p, resouceFileView);
			if (index == 4)
				resouceFileView.setType(5);
			else
				resouceFileView.setType(1);
			resouceFileView.setStartLine(NumUtil.startingNum(resouceFileView.getPage(), resouceFileView.getRows()));
			resouceFileView.setUser_id(user_id);
			j.setRows(userFileService.queryUserFile(resouceFileView));
			j.setTotal(userFileService.queryTotalUserFile(resouceFileView) + 0L);
		}
		if (index == 6) {
			UserAppraiseView userAppraiseView = new UserAppraiseView();
			BeanUtils.copyProperties(p, userAppraiseView);
			userAppraiseView.setPage(NumUtil.startingNum(userAppraiseView.getPage(), userAppraiseView.getRows()));
			userAppraiseView.setUser_id(user_id);
			j.setRows(userAppraiseMapper.search(userAppraiseView));
			j.setTotal(userAppraiseMapper.count(userAppraiseView));
		}
		if (index == 7 || index == 8) {
			p.setPage(NumUtil.startingNum(p.getPage(), p.getRows()));
			User_attent user_attent = new User_attent();
			user_attent.setStartLine(p.getPage());
			user_attent.setRows(p.getRows());
			user_attent.setUser_id(user_id);
			if (index == 8) {
				int total = userAttentService.queryTotalAttention(user_id);
				j.setTotal(total + 0L);
				List<User_attent> attents = userAttentService.myAttenation(user_attent);
				List<MyAttentionView> list = new ArrayList<MyAttentionView>();
				for (User_attent u : attents) {
					MyAttentionView myAttentionView = new MyAttentionView();
					myAttentionView.setUserId(u.getAttent_user_id());
					myAttentionView.setSupport(0);
					myAttentionView.setTeacher(0);
					myAttentionView.setAttent_time(u.getAttent_time());
					User user2 = userMapper.selectByPrimaryKey(u.getAttent_user_id());
					myAttentionView.setRealName(user2.getUsername());
					myAttentionView.setImg(user2.getIcon());
					UserInfo userInfo2 = userInfoMapper.getByUserId(u.getAttent_user_id());
					if (userInfo2 != null) {
						myAttentionView.setTeacher(1);
						myAttentionView.setTitles(userInfo2.getTitles());
						myAttentionView.setSchool(userInfo2.getSchool());
					}
					list.add(myAttentionView);

				}
				j.setRows(list);
			} else {
				int total = userAttentService.queryTotalFans(user_id);
				j.setTotal(total + 0L);
				List<User_attent> fans = userAttentService.myFans(user_attent);
				List<MyAttentionView> list = new ArrayList<MyAttentionView>();
				for (User_attent u : fans) {
					MyAttentionView myAttentionView = new MyAttentionView();
					myAttentionView.setUserId(u.getUser_id());
					myAttentionView.setSupport(0);
					myAttentionView.setTeacher(0);
					myAttentionView.setAttent_time(u.getAttent_time());
					User user2 = userMapper.selectByPrimaryKey(u.getUser_id());
					myAttentionView.setRealName(user2.getUsername());
					myAttentionView.setImg(user2.getIcon());
					UserInfo userInfo2 = userInfoMapper.getByUserId(u.getAttent_user_id());
					if (userInfo2 != null) {
						myAttentionView.setTeacher(1);
						myAttentionView.setTitles(userInfo2.getTitles());
						myAttentionView.setSchool(userInfo2.getSchool());
					}
					list.add(myAttentionView);
				}
				j.setRows(list);
			}
		}
		if (index == 9) {
			TopicQuestionView topicQuestionView = new TopicQuestionView();
			BeanUtils.copyProperties(p, topicQuestionView);
			topicQuestionView
					.setStartLine(NumUtil.startingNum(topicQuestionView.getPage(), topicQuestionView.getRows()));
			topicQuestionView.setUser_id(user_id);
			topicQuestionView.setBack(1);
			j.setRows(topicQuestionMapper.queryTopic(topicQuestionView));
			j.setTotal(topicQuestionMapper.queryTopicCount(topicQuestionView) + 0L);
		}
		if (index == 10) {
			TopicAnswerView topicAnswerView = new TopicAnswerView();
			BeanUtils.copyProperties(p, topicAnswerView);
			topicAnswerView.setStartLine(NumUtil.startingNum(topicAnswerView.getPage(), topicAnswerView.getRows()));
			topicAnswerView.setUser_id(user_id);
			j.setRows(topicAnswerMapper.queryMyTopicAnswer(topicAnswerView));
			j.setTotal(topicAnswerMapper.queryMyTopicAnswerCount(topicAnswerView) + 0L);
		}
		if (index == 11) {
			NoteView noteView = new NoteView();
			BeanUtils.copyProperties(p, noteView);
			noteView.setStartLine(NumUtil.startingNum(noteView.getPage(), noteView.getRows()));
			noteView.setUser_id(user_id);
			j.setRows(courseNoteMapper.queryMyCourseNote(noteView));
			j.setTotal(courseNoteMapper.queryMyCourseNoteCount(noteView) + 0L);
		}
		return j;
	}

	@Override
	public List<UserStatsView> queryOnlineNum(UserStatsView userStats) throws ParseException {
		Date date = new Date();
		Date start = TimeUtil.afterNMiute(date, -32);
		Date end = TimeUtil.afterNMiute(date, -2);
		List<UserStatsView> userStatsList = new ArrayList<UserStatsView>();
		List<String> timelist = TimeUtil.getBetweenTimes(start, end);
		for (String time : timelist) {
			UserStatsView u1 = new UserStatsView();
			u1.setDays(time.substring(11, 16));
			userStats.setStartTime(time.substring(0, 17) + "00");
			userStats.setEndTime(time.substring(0, 17) + "59");
			int online_num = userDurationMapper.queryOnlineNum(userStats);
			u1.setNewNum(online_num);
			userStatsList.add(u1);
		}
		return userStatsList;
	}

	@Override
	public List<UserStatsView> queryAvgOnline(UserStatsView condition) throws ParseException {
		List<UserStatsView> userStatsList = new ArrayList<UserStatsView>();
		List<String> timelist = new ArrayList<String>();
		List<String> alldays = new ArrayList<String>();
		int timeUnit = condition.getTimeUnit();
		String logType = condition.getLogType();
		Integer compare = condition.getCompare();
		if (timeUnit == 0) {// 按时
			String[] hourlist = TimeUtil.getHourList();
			for (int i = 0; i < hourlist.length; i++) {
				UserStatsView userStats1 = new UserStatsView();
				userStats1.setDays(hourlist[i]);
				userStatsList.add(userStats1);
			}
		} else if (timeUnit == 1) {// 按天
			// 选择某一天和一段时间一定分开
			if (condition.getDays() != null && condition.getDays() != "") {// 某一天
				UserStatsView userStats1 = new UserStatsView();
				userStats1.setDays(condition.getDays());
				userStats1.setSort(1);// 按天排序
				userStatsList.add(userStats1);
			}
		}
		if (condition.getStartTime() != null && condition.getEndTime() != null && condition.getStartTime() != ""
				&& condition.getEndTime() != "") {// 一段时间
			if (timeUnit != 0) {// 不是按时，timelist才有意义
				alldays = TimeUtil.getBetweenDates(TimeUtil.stringFormatDate1(condition.getStartTime()),
						TimeUtil.afterNDay(TimeUtil.stringFormatDate1(condition.getEndTime()), 1));
			}
			if (timeUnit == 1) {// 按天
				// 选择某一天和一段时间一定分开
				timelist = alldays;
			} else if (timeUnit == 2) {// 按周
				timelist = TimeUtil.getMonday(alldays);// 获取所有日期所在的星期一的日期
			} else if (timeUnit == 3) {// 按月
				timelist = TimeUtil.getFirstdayofmouth(condition.getStartTime(), condition.getEndTime());// 获取时间段内的每月的第一天
			}
			if (timeUnit != 0) {// 小时的list和date的list已不同
				timelist.set(0, condition.getStartTime());// 默认初始时间是起始时间
				for (int i = 0; i < timelist.size(); i++) {
					UserStatsView userStats1 = new UserStatsView();
					userStats1.setDays(timelist.get(i));
					userStats1.setSort(1);// 按天排序
					userStatsList.add(userStats1);
				}
			}
			condition.setEndTime(TimeUtil.afterNDay(condition.getEndTime(), 1));
		}
		List<UserStatsView> avgOnlineList = onlineUserMapper.queryAvgOnline(condition);
		if (avgOnlineList.size() > 0 && (timeUnit == 2 || timeUnit == 3)) {// 按周或按月
			if(avgOnlineList.get(0).getDays().equals(timelist.get(0))){
				avgOnlineList.get(0).setDays(condition.getStartTime()); 
			}
		}
		// 组装
		// 平均同时在线人数、在线峰值
		for (UserStatsView u : avgOnlineList) {
			for (UserStatsView u1 : userStatsList) {
				if (u1.getDays().equals(u.getDays())) {
					u1.setAvgNum(u.getAvgNum());
					u1.setMaxNum(u.getMaxNum());
					if (logType.charAt(0) == '0') {// 包含只有一个指标或两个指标且第一个是0
						u1.setNewNum1(u.getAvgNum());
					} else if (logType.charAt(0) == '1') {// 一个指标且为1
						u1.setNewNum1(u.getMaxNum());
					}
					if (logType.length() == 3 && logType.charAt(2) == '1') {// 两个指标且第二个为1
						u1.setNewNum2(u.getMaxNum());
					}
				}
			}
		}
		if (compare != null && logType.length() == 1) {// 有比较
			if (condition.getDays() != null && condition.getDays().length() > 0) {// 某一天
				if (compare == 0) {// 对比前一日
					condition.setDays(TimeUtil.afterNDay(condition.getDays(), -1));
				} else if (compare == 1) {// 对比上一周期
					condition.setDays(TimeUtil.afterNDay(condition.getDays(), -7));
				}
			} else if (condition.getStartTime() != null && condition.getEndTime() != null
					&& condition.getStartTime() != "" && condition.getEndTime() != "") {// 一段时间
				if (compare == 0) {// 对比前一日
					condition.setStartTime(TimeUtil.afterNDay(condition.getStartTime(), -1));
					condition.setEndTime(TimeUtil.afterNDay(condition.getEndTime(), -1));
				} else if (compare == 1) {// 对比上一周期
					condition.setStartTime(TimeUtil.afterNDay(condition.getStartTime(), -7));
					condition.setEndTime(TimeUtil.afterNDay(condition.getEndTime(), -7));
				}
			}
			List<UserStatsView> onlineCompareList = onlineUserMapper.queryAvgOnline(condition);
			// 组装比较
			for (UserStatsView u : userStatsList) {
				for (UserStatsView u1 : onlineCompareList) {
					if(timeUnit==0){//按时
						if (u.getDays().equals(u1.getDays())) {
							if ("0".equals(logType)) {//平均同时在线
								u.setNewNum2(u1.getAvgNum());
							} else if ("1".equals(logType)) {// 在线峰值
								u.setNewNum2(u1.getMaxNum());
							}
						}
					}else if(timeUnit==1){//按日
						if (compare == 0 && TimeUtil.afterNDay(u.getDays(), -1).equals(u1.getDays())) {// 对比前一日
							u.setOneDay(u1.getDays());
							if (logType.equals("0")) {// 平均同时在线
								u.setNewNum2(u1.getAvgNum());
							} else if (logType.equals("1")) {// 在线峰值
								u.setNewNum2(u1.getMaxNum());
							} 
						} else if (compare == 1 && TimeUtil.afterNDay(u.getDays(), -7).equals(u1.getDays())) {// 对比上一周期
							u.setOneDay(u1.getDays());
							if (logType.equals("0")) {// 平均同时在线
								u.setNewNum2(u1.getAvgNum());
							} else if (logType.equals("1")) {// 在线峰值
								u.setNewNum2(u1.getMaxNum());
							}
						}
					}
				}
			}
		}
		Collections.sort(userStatsList, new UserStatsComparator());// 排序
		return userStatsList;
	}

	@Override
	public List<UserDurationView> queryOnlineUser(UserStatsView userStats) {
		return userDurationMapper.queryOnlineUser(userStats);
	}

	@Override
	public List<UserStatsView> ageDistribution(UserStatsView condition) {
		return userInfoMapper.ageDistribution(condition);
	}

	@Override
	public Integer querySexNum(UserStatsView condition) {
		return userInfoMapper.querySexNum(condition);
	}

	@Override
	public UserStatsView queryAvgVisitTime(UserStatsView userStats) {
		return userDurationMapper.queryAvgVisitTime(userStats);
	}

	@Override
	public List<UserStatsView> querytimesByduaration(UserStatsView userStats) {
		List<UserStatsView> list = userDurationMapper.querytimesByduaration(userStats);
		for(UserStatsView u : list){
			if("1min".equals(u.getInterval1())){
				u.setInterval1("0-1分钟");
			}else if("3min".equals(u.getInterval1())){
				u.setInterval1("1-3分钟");
			}else if("10min".equals(u.getInterval1())){
				u.setInterval1("3-10分钟");
			}else if("30min".equals(u.getInterval1())){
				u.setInterval1("10-30分钟");
			}else if("1hour".equals(u.getInterval1())){
				u.setInterval1("30分钟-1小时");
			}else if("3hour".equals(u.getInterval1())){
				u.setInterval1("1-3小时");
			}else if("10hour".equals(u.getInterval1())){
				u.setInterval1("3-10小时");
			}else if("more than 10hour".equals(u.getInterval1())){
				u.setInterval1("10小时以上");
			}
		}
		if(list.size()==0){
			UserStatsView u = new UserStatsView();
			u.setInterval1("无");
			list.add(u);
		}
		return list;
	}

	@Override
	public List<UserStatsView> queryLoginFrequency(UserStatsView userStats) {
		List<UserStatsView> list = sysLogMapper.queryLoginFrequency(userStats);
		for(UserStatsView u : list){
			if("5 times".equals(u.getInterval1())){
				u.setInterval1("5次以内");
			}else if("10 times".equals(u.getInterval1())){
				u.setInterval1("6-10次");
			}else if("30 times".equals(u.getInterval1())){
				u.setInterval1("11-30次");
			}else if("60 times".equals(u.getInterval1())){
				u.setInterval1("31-60次");
			}else if("more than 60 times".equals(u.getInterval1())){
				u.setInterval1("60次以上");
			}
		}
		if(list.size()==0){
			UserStatsView u = new UserStatsView();
			u.setInterval1("无");
			list.add(u);
		}
		return list;
	}

	@Override
	public List<UserStatsView> querylastTimeOnlineInterval(UserStatsView userStats) {
		List<UserStatsView> list = userDurationMapper.querylastTimeOnlineInterval(userStats);
		for(UserStatsView u : list){
			if("first".equals(u.getInterval1())){
				u.setInterval1("首次登录");
			}else if("1 day".equals(u.getInterval1())){
				u.setInterval1("1天内");
			}else if("2 day".equals(u.getInterval1())){
				u.setInterval1("1天前");
			}else if("7 day".equals(u.getInterval1())){
				u.setInterval1("3-7天前");
			}else if("15 day".equals(u.getInterval1())){
				u.setInterval1("8-15天前");
			}else if("30 day".equals(u.getInterval1())){
				u.setInterval1("16-30天前");
			}else if("more than 30 day".equals(u.getInterval1())){
				u.setInterval1("30多天前");
			}
		}
		if(list.size()==0){
			UserStatsView u = new UserStatsView();
			u.setInterval1("无");
			list.add(u);
		}
		return list;
	}

	@Override
	public List<UserStatsView> queryArealDistribution(UserStatsView userStats) {
		List<UserStatsView> list1 = sysLogMapper.queryArealDistribution(userStats);
		List<UserStatsView> list2 = userDurationMapper.queryArealDistribution(userStats);
		int loginNum = 0,newNum = 0,ipNum = 0;
		String interval1 = userDurationService.queryArealDistribution(userStats);
		for(UserStatsView u1 : list1){
			for(UserStatsView u2 : list2){
				if(u1.getProvince_id().equals(u2.getProvince_id())){
					u1.setInterval1(u2.getInterval1());
				}
			}
			loginNum += u1.getLoginNum();
			newNum += u1.getNewNum();
			ipNum += u1.getIpNum();
		}
		UserStatsView u0 = new UserStatsView();
		u0.setProvince("当前汇总");
		u0.setLoginNum(loginNum);
		u0.setNewNum(newNum);
		u0.setIpNum(ipNum);
		u0.setInterval1(interval1);
		list1.add(u0);
		return list1;
	}

	@Override
	public UserView queryme(Long id) {
		return userMapper.queryme(id);
	}

}