package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.StudyTimeView;
import cn.bnsr.edu_yun.backstage.train.view.StudyTimeStatsView;
import cn.bnsr.edu_yun.comparator.StudyTimeStatsComparator;
import cn.bnsr.edu_yun.comparator.StudyTimeViewComparator;
import cn.bnsr.edu_yun.frontstage.train.mapper.UserStudyTimeMapper;
import cn.bnsr.edu_yun.frontstage.train.po.UserStudyTime;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyTimeService;
import cn.bnsr.edu_yun.util.TimeUtil;

public class UserStudyTimeServiceImpl implements UserStudyTimeService {

	@Autowired
	private UserStudyTimeMapper userStudyTimeMapper;

	@Override
	public int insert(UserStudyTime userStudyTime) {

		return userStudyTimeMapper.insertSelective(userStudyTime);
	}

	@Override
	public List<StudyTimeStatsView> queryWatchStats(StudyTimeStatsView condition) throws ParseException {
		Date date = new Date();
		List<String> list = new ArrayList<String>();
		int timeType = condition.getTimeType();
		if (timeType == 0) {// 本月
			// 获的当前年月
			condition.setDays(TimeUtil.getDate());
		} else if (timeType == 1) {// 上月
			condition.setDays(TimeUtil.getLastDate());
		} else if (timeType == 2) {// 近三月
			condition.setStartTime(TimeUtil.getBeforeMarch());
			condition.setEndTime(TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), 1)));
		} else if (timeType == 4) {// 某一天
			condition.setDays(TimeUtil.dateToString1(TimeUtil.stringFormatDate1(condition.getDays())));
		}
		if (timeType == 0 || timeType == 1) {// 本月、上月
			date = TimeUtil.stringFormatDate(condition.getDays());
			list = TimeUtil.getAllTheDateOftheMonth(date);
		} else if (timeType == 4) {
			list = TimeUtil.getAllTheHourOfTheDay();
		} else {// 近三月、起止时间
			list = TimeUtil.getBetweenDates(TimeUtil.stringFormatDate1(condition.getStartTime()),
					TimeUtil.afterNDay(TimeUtil.stringFormatDate1(condition.getEndTime()), 1));
		}
		List<StudyTimeStatsView> studyTimeStatsList = userStudyTimeMapper.queryWatchStats(condition);

		if (studyTimeStatsList.size() != list.size()) {// 如果不相等，证明有缺少日期
			// 有数据日期
			List<String> dataList = new ArrayList<String>();
			for (int i = 0; i < studyTimeStatsList.size(); i++) {
				dataList.add(studyTimeStatsList.get(i).getDays());
			}
			list.removeAll(dataList);// 差集
			for (int i = 0; i < list.size(); i++) {// 补全当前月日期
				StudyTimeStatsView studyTimeStat = new StudyTimeStatsView();
				studyTimeStat.setDays(list.get(i));
				studyTimeStat.setWatchNum(0);
				studyTimeStat.setAverageNum(0);
				studyTimeStat.setTotalNum(0);
				studyTimeStat.setTimeType(timeType);
				studyTimeStatsList.add(studyTimeStat);
			}
		}
		Collections.sort(studyTimeStatsList, new StudyTimeStatsComparator());// 排序
		return studyTimeStatsList;
	}

	@Override
	public List<StudyTimeView> selectSumByUserId(StudyTimeView studyTimeView) {

		List<String> list = new ArrayList<String>();

		try {
			if (studyTimeView.getDays() != null) {
				Date date = null;
				date = TimeUtil.stringFormatDate(studyTimeView.getDays());
				list = TimeUtil.getAllTheDateOftheMonth(date);
			} else {
				Date start = TimeUtil.stringFormatDate1(studyTimeView.getStartTime());
				Date end = TimeUtil.stringFormatDate1(studyTimeView.getEndTime());
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(end);
				calendar.add(Calendar.DAY_OF_MONTH, +1);// +1今天的时间加一天
				end = calendar.getTime();
				list = TimeUtil.getBetweenDates(start, end);
			}
		} catch (ParseException e) {

			e.printStackTrace();
		}

		List<StudyTimeView> studyTimeViews = userStudyTimeMapper.selectSumByUserId(studyTimeView);
		if (studyTimeViews.size() != list.size()) {
			List<String> dataList = new ArrayList<String>();
			for (int i = 0; i < studyTimeViews.size(); i++) {
				dataList.add(studyTimeViews.get(i).getDays());
			}
			list.removeAll(dataList);// 差集
			for (int i = 0; i < list.size(); i++) {// 补全当前月日期
				StudyTimeView studyTimeStat = new StudyTimeView();
				studyTimeStat.setDays(list.get(i));
				studyTimeStat.setStudy_time(0);
				studyTimeViews.add(studyTimeStat);
			}
		}
		Collections.sort(studyTimeViews, new StudyTimeViewComparator());// 排序
		return studyTimeViews;
	}

	@Override
	public List<StudyTimeView> selectSumByCourseId(StudyTimeView studyTimeView) {
		List<StudyTimeView> studyTimeViews = userStudyTimeMapper.selectSumByCourseId(studyTimeView);
		List<String> list = new ArrayList<String>();
		if (studyTimeView.getGroup().equals("1")) {
			for (int i = 0; i < 24; i++) {
				if (i < 10) {
					list.add("0" + i + "");
				} else
					list.add(i + "");
			}

		} else if (studyTimeView.getGroup().equals("2")) {
			try {
				if(studyTimeView.getStartTime() != null){
					Date start = TimeUtil.stringFormatDate1(studyTimeView.getStartTime());
					Date end = TimeUtil.stringFormatDate1(studyTimeView.getEndTime());
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(end);
					calendar.add(Calendar.DAY_OF_MONTH, +1);// +1今天的时间加一天
					end = calendar.getTime();
					list = TimeUtil.getBetweenDates(start, end);
				}else{
					list.add(studyTimeView.getDays());
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else if (studyTimeView.getGroup().equals("3") && studyTimeView.getStartTime() != null) {
			try {
				Date start = TimeUtil.stringFormatDate1(studyTimeView.getStartTime());
				Date end = TimeUtil.stringFormatDate1(studyTimeView.getEndTime());
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(start);
				int i = calendar.get(Calendar.WEEK_OF_YEAR);
				calendar.setTime(end);
				int j = calendar.get(Calendar.WEEK_OF_YEAR);
				for (int k = i; k <= j; k++) {
					list.add(k + "");
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (studyTimeViews.size() != list.size()) {
			List<String> dataList = new ArrayList<String>();
			for (int i = 0; i < studyTimeViews.size(); i++) {
				if (studyTimeView.getGroup().equals("1")) {
					dataList.add(studyTimeViews.get(i).getHours());
				} else if (studyTimeView.getGroup().equals("2")) {
					dataList.add(studyTimeViews.get(i).getDays());
				} else if (studyTimeView.getGroup().equals("3")) {
					dataList.add(studyTimeViews.get(i).getWeeks());
				}
			}
			list.removeAll(dataList);// 差集
			for (int i = 0; i < list.size(); i++) {// 补全当前月日期
				StudyTimeView studyTimeStat = new StudyTimeView();
				if (studyTimeView.getGroup().equals("1")) {
					studyTimeStat.setHours(list.get(i));
				} else if (studyTimeView.getGroup().equals("2")) {
					studyTimeStat.setDays(list.get(i));
				} else if (studyTimeView.getGroup().equals("3")) {
					studyTimeStat.setWeeks(list.get(i));
				}

				studyTimeStat.setUser_count(0);
				studyTimeStat.setCount(0);
				studyTimeViews.add(studyTimeStat);
			}
		}
		Collections.sort(studyTimeViews, new StudyTimeViewComparator());// 排序
		return studyTimeViews;
	}

	public static void main(String[] args) {
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int i = calendar.get(Calendar.WEEK_OF_YEAR);
		System.out.println(i);
	}

	@Override
	public List<StudyTimeView> selectSumByCourseHour(StudyTimeView studyTimeView) {

		return userStudyTimeMapper.selectSumByCourseHour(studyTimeView);
	}

	@Override
	public List<StudyTimeView> selectViewByUserId(StudyTimeView studyTimeView) {

		return userStudyTimeMapper.selectViewByUserId(studyTimeView);

	}

	@Override
	public long selectViewByUserIdCount(StudyTimeView studyTimeView) {

		return userStudyTimeMapper.selectViewByUserIdCount(studyTimeView);
	}
}
