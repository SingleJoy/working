package cn.bnsr.edu_yun.backstage.resource.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.resource.service.ResourceStatsService;
import cn.bnsr.edu_yun.backstage.resource.view.ResourceStatsView;
import cn.bnsr.edu_yun.comparator.FileStatsComparator;
import cn.bnsr.edu_yun.frontstage.resource.mapper.User_fileMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.CourseFileMapper;
import cn.bnsr.edu_yun.util.TimeUtil;

public class ResourceStatsServiceImpl implements ResourceStatsService {

	@Autowired 
	private User_fileMapper user_fileMapper;
	@Autowired 
	private CourseFileMapper courseFileMapper;
	
	@Override
	public List<ResourceStatsView> queryResourceStats(ResourceStatsView record) throws ParseException {
		Date date = new Date();
		List<String> list = new ArrayList<String>();
		int timeType = record.getTimeType();
		int resourceType = record.getResourceType();
		if (timeType == 0) {// 本月
			// 获的当前年月
			record.setDays(TimeUtil.getDate());
		} else if (timeType == 1) {// 上月
			record.setDays(TimeUtil.getLastDate());
		} else if (timeType == 2) {// 近三月
			record.setStartTime(TimeUtil.getBeforeMarch1());
			record.setEndTime(TimeUtil.dateToString2(new Date()));
		} 
		if (timeType == 0 || timeType == 1) {// 本月、上月
			date = TimeUtil.stringFormatDate(record.getDays());
			list = TimeUtil.getAllTheDateOftheMonth(date);
		}else {// 近三月、起止时间
			list = TimeUtil.getBetweenDates(TimeUtil.stringFormatDate1(record.getStartTime()),
					TimeUtil.afterNDay(TimeUtil.stringFormatDate1(record.getEndTime()), 1));
		}
		List<ResourceStatsView> resourceStatsList = new ArrayList<ResourceStatsView>();
		if (resourceType == 0) {// 0-资料库新增数
			resourceStatsList = courseFileMapper.queryCourseFileAddStats(record);
		} else if (resourceType==1||resourceType == 2) {// 资料库使用数,资料库未使用数
			resourceStatsList = courseFileMapper.queryCourseFileUseStats(record);
		}else if (resourceType==3||resourceType==6||resourceType==7||resourceType==8) {// 资源
			resourceStatsList = user_fileMapper.queryFileAddStats(record);
		}else if (resourceType==4||resourceType==5) {// 
			resourceStatsList = user_fileMapper.queryFileCheckStats(record);
		}
		if (resourceStatsList.size() != list.size()) {// 如果不相等，证明有缺少日期
			// 有数据日期
			List<String> dataList = new ArrayList<String>();
			for (int i = 0; i < resourceStatsList.size(); i++) {
				dataList.add(resourceStatsList.get(i).getDays());
			}
			list.removeAll(dataList);// 差集
			for (int i = 0; i < list.size(); i++) {// 补全当前月日期
				ResourceStatsView resourceStat = new ResourceStatsView();
				resourceStat.setDays(list.get(i));
				resourceStat.setNewNum(0);
				resourceStat.setTimeType(timeType);
				resourceStatsList.add(resourceStat);
			}
		}
		Collections.sort(resourceStatsList, new FileStatsComparator());// 排序
		return resourceStatsList;
	}

}
