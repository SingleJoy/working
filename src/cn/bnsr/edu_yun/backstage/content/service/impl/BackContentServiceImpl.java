package cn.bnsr.edu_yun.backstage.content.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.content.service.BackContentService;
import cn.bnsr.edu_yun.backstage.content.view.ContentStatiView;
import cn.bnsr.edu_yun.comparator.ContentStatiComparator;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyRecordService;
import cn.bnsr.edu_yun.frontstage.train.service.UserStudyService;
import cn.bnsr.edu_yun.util.TimeUtil;

public class BackContentServiceImpl implements BackContentService{
	@Autowired
	private UserAppraiseService userAppraiseService;
	@Autowired
	private UserStudyService userStudyService;
	@Autowired
	private UserStudyRecordService userStudyRecordService;
	
	@Override
	public List<ContentStatiView> queryContentStati(
			ContentStatiView contentStatiView) throws ParseException {
		Date date = new Date();
		List<String> list = new ArrayList<String>();
		int monthType = contentStatiView.getMonthType();
		if (monthType == 0) {// 当前月
			// 获的当前年月
			contentStatiView.setDays(TimeUtil.getDate());
		} else if (monthType == 1) {// 上月
			contentStatiView.setDays(TimeUtil.getLastDate());
		} else if (monthType == 2) {// 近三月
			contentStatiView.setStartTime(TimeUtil.getBeforeMarch());
			//日期区间判断时，终止时间为xxxx-xx-xx 恒小于 xxxx-xx-xx xx:xx:xx 因此推迟1天
			Date delay_oneday = TimeUtil.afterNDay(new Date(), 1);
			contentStatiView.setEndTime(TimeUtil.dateToString1(delay_oneday));
		}else if(monthType == 3){ //起止时间
			//日期区间判断时，终止时间为xxxx-xx-xx 恒小于 xxxx-xx-xx xx:xx:xx 因此推迟1天
			String delay_oneday_str = TimeUtil.afterNDay(contentStatiView.getEndTime(),1);
			contentStatiView.setEndTime(delay_oneday_str);
		}
		if (monthType == 0 || monthType == 1) {// 本月、上月
			date = TimeUtil.stringFormatDate(contentStatiView.getDays());
			list = TimeUtil.getAllTheDateOftheMonth(date);
		} else {// 近三月、起止时间
			
			list = TimeUtil.getBetweenDates(TimeUtil.stringFormatDate1(contentStatiView.getStartTime()),
					TimeUtil.stringFormatDate1(contentStatiView.getEndTime()));
		}

		List<ContentStatiView> contentStatiList = new ArrayList<ContentStatiView>();

		if (contentStatiView.getStatiType() == 0) {// 评价
			contentStatiList = userAppraiseService.userAppriContentStati(contentStatiView);
		} else if (contentStatiView.getStatiType() == 1) {// 报名(普通课程)
			contentStatiView.setSource_type(0);
			contentStatiView.setType(0);
			contentStatiList = userStudyService.userStudyContentStati(contentStatiView);
		} else if (contentStatiView.getStatiType() == 2) {// 报名(专业培训)
			contentStatiView.setSource_type(1);
			contentStatiView.setType(0);
			contentStatiList = userStudyService.userStudyContentStati(contentStatiView);
		} else if (contentStatiView.getStatiType() == 3) {// 报名(进阶培训)
			contentStatiView.setSource_type(1);
			contentStatiView.setType(1);
			contentStatiList = userStudyService.userStudyContentStati(contentStatiView);
		} else if (contentStatiView.getStatiType() == 4) {// 学习(普通课程)
			contentStatiView.setSource_type(0);
			contentStatiList = userStudyRecordService.queryUserStudyRecordStati(contentStatiView);
		} else if (contentStatiView.getStatiType() == 5) {// 学习(专业培训)
			contentStatiView.setSource_type(1);
			contentStatiView.setType(0);
			contentStatiList = userStudyRecordService.queryUserStudyRecordStati(contentStatiView);
		} else if (contentStatiView.getStatiType() == 6) {// 学习(进阶培训)
			contentStatiView.setSource_type(1);
			contentStatiView.setType(1);
			contentStatiList = userStudyRecordService.queryUserStudyRecordStati(contentStatiView);
		}

		if (contentStatiList.size() != list.size()) {// 如果不相等，证明有缺少日期
			int countNum = 0;
			// 有数据日期
			List<String> dataList = new ArrayList<String>();
			for (int i = 0; i < contentStatiList.size(); i++) {
				dataList.add(contentStatiList.get(i).getDays());
			}
			list.removeAll(dataList);// 差集
			for (int i = 0; i < list.size(); i++) {// 补全当前月日期
				ContentStatiView contentStati = new ContentStatiView();
				contentStati.setDays(list.get(i));
				contentStati.setNewNum(0);
				contentStati.setCountNum(0);
				contentStatiList.add(contentStati);
			}
		}

		Collections.sort(contentStatiList, new ContentStatiComparator());// 排序

		return contentStatiList;
	}

}
