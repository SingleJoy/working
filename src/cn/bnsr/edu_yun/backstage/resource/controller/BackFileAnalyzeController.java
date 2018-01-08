package cn.bnsr.edu_yun.backstage.resource.controller;

import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.resource.service.BackFileAnalyzeService;
import cn.bnsr.edu_yun.backstage.resource.view.BackFileView;
import cn.bnsr.edu_yun.backstage.resource.view.FileStatsView;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.ExportExcel;
import cn.bnsr.edu_yun.util.ResponseUtil;
import cn.bnsr.edu_yun.util.TimeUtil;
import net.sf.json.JSONObject;

/**
 * 资源文档管理
 * @author fangxiongwei
 * @date 2016年9月20日
 */
@Controller
@RequestMapping("/back_file_analyze")
public class BackFileAnalyzeController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(BackFileAnalyzeController.class);
	@Autowired
	private BackFileAnalyzeService backFileAnalyzeService;
	/**
	 *跳转资源页面
	 */
	@RequestMapping("/to_file_analyze")
	public ModelAndView toFileAnalyze(){
		return new ModelAndView("backstage/resourceAnalyze/file_analyze");
	}
	
	/**
	 * 获得资源datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,HttpServletRequest request,BackFileView backFileView) {
		super.writeJson(backFileAnalyzeService.datagrid(backFileView),response);
	}
	
	
	/**
	 * 跳转资源操作趋势页面
	 */
	@RequestMapping("/to_file_trend")
	public ModelAndView toUserTrend(HttpServletRequest request) {
		try {
			String timeType = request.getParameter("timeType");
			String isDuration = request.getParameter("isDuration");
			String days = request.getParameter("days");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String timeUnit = request.getParameter("timeUnit");
			String logType = request.getParameter("logType");
			String inactive = request.getParameter("inactive");
			String compare = request.getParameter("compare");
			if (timeType != null) {
				if ("0".equals(timeType)) {// 今天
					days = TimeUtil.dateToString1(new Date());
				} else if ("1".equals(timeType)) {// 昨天
					days = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -1));
				} else if ("2".equals(timeType)) {// 最近7天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -6));
					endTime = TimeUtil.dateToString1(new Date());
				} else if ("3".equals(timeType)) {// 最近30天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -29));
					endTime = TimeUtil.dateToString1(new Date());
				}
			}
			request.setAttribute("timeType", timeType);
			request.setAttribute("isDuration", isDuration);
			if ("1".equals(isDuration)) {
				request.setAttribute("days", days);
			} else if ("0".equals(isDuration)) {
				request.setAttribute("startTime", startTime);
				request.setAttribute("endTime", endTime);
			}
			request.setAttribute("timeUnit", timeUnit);
			request.setAttribute("logType", logType);
			request.setAttribute("inactive", inactive);
			request.setAttribute("compare", compare);
		} catch (Exception e) {
			log.error("查询资源操作趋势失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/resourceAnalyze/file_trend");
	}

	/**
	 * 查询资源统计数据
	 */
	@RequestMapping("/query_file_trend")
	public void queryUserTrend(HttpServletResponse response, FileStatsView fileStats) {
		JSONObject result = new JSONObject();
		try {
			List<FileStatsView> fileStatsList = backFileAnalyzeService.queryfileTrend(fileStats);
			result.put("fileStatsList", fileStatsList);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询统计数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}
	
	@RequestMapping("/export_file_trend")
	public void exportStudent(HttpServletRequest request, HttpServletResponse response,
			FileStatsView fileStats) {
		try {
			List<FileStatsView> list = backFileAnalyzeService.queryfileTrend(fileStats);
			int timeUnit = fileStats.getTimeUnit();
			Integer compare = fileStats.getCompare();
			String time = "小时";
			if(timeUnit!=0){//日期
				time = "日期";
			}
			int sumdownLoadNum = 0;
			int sumcollectionNum = 0;
			int sumclickNum = 0;
			int sumbuyNum = 0;
			int sumuploadNum = 0;
			for(int i=0;i<list.size();i++){
				sumdownLoadNum += list.get(i).getDownLoadNum();
                sumcollectionNum += list.get(i).getCollectionNum();
                sumclickNum += list.get(i).getClickNum();
                sumbuyNum += list.get(i).getBuyNum();
                sumuploadNum += list.get(i).getUploadNum();
                if(timeUnit==0){
                	list.get(i).setDays(list.get(i).getDays()+":00-"+list.get(i).getDays()+":59");
                }else if(timeUnit==2){
                    if(i<list.size()-1){
                        Date monday = TimeUtil.stringFormatDate1(list.get(i+1).getDays());
                        monday = TimeUtil.afterNDay(monday, -1);//设置天数 -1 天
                        String sunday = TimeUtil.dateToString1(monday);
                        list.get(i).setDays(list.get(i).getDays()+"~"+sunday);
                    }else if(i==list.size()-1){
                    	list.get(i).setDays(list.get(i).getDays()+"~"+fileStats.getEndTime());
                    }
                }else if(timeUnit==3){
                    if(i<list.size()-1){
                        String lastday = TimeUtil.getLastDayOfMonth(list.get(i).getDays());
                        list.get(i).setDays(list.get(i).getDays()+"~"+lastday);
                    }else if(i==list.size()-1){
                    	list.get(i).setDays(list.get(i).getDays()+"~"+fileStats.getEndTime());
                    }
                }
			}
			if(compare==null){
				FileStatsView sum = new FileStatsView();
				sum.setDays("汇总");
				sum.setBuyNum(sumbuyNum);
				sum.setClickNum(sumclickNum);
				sum.setCollectionNum(sumcollectionNum);
				sum.setDownLoadNum(sumdownLoadNum);
				sum.setUploadNum(sumuploadNum);
				list.add(sum);
			}
			String[] head = {time,"下载量","收藏量","点击浏览量","购买量","上传量"};
			String[] fieldNames = {"days", "downLoadNum", "collectionNum", "clickNum", "buyNum","uploadNum" };
			String fileName = "资源统计.xls";
			response.setContentType("application/msexcel");
			ExportExcel<FileStatsView> excel = new ExportExcel<FileStatsView>();
			response.setHeader("Content-Disposition", excel.getFileName(fileName, excel.getExplorer(request)));
			OutputStream out = response.getOutputStream();
			excel.exportExcel("资源", head, fieldNames, list, out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 跳转资源排行页面
	 */
	@RequestMapping("/to_file_ranking")
	public ModelAndView toCourseRanking(HttpServletRequest request) {
		try {
			String group = request.getParameter("group");
			String sort = request.getParameter("sort");
			String timeType = request.getParameter("timeType");
			String isDuration = request.getParameter("isDuration");
			String days = request.getParameter("days");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String inactive = request.getParameter("inactive");
			if (timeType != null) {
				if ("0".equals(timeType)) {// 今天
					days = TimeUtil.dateToString1(new Date());
				} else if ("1".equals(timeType)) {// 昨天
					days = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -1));
				} else if ("2".equals(timeType)) {// 最近7天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -6));
					endTime = TimeUtil.dateToString1(new Date());
				} else if ("3".equals(timeType)) {// 最近30天
					startTime = TimeUtil.dateToString1(TimeUtil.afterNDay(new Date(), -29));
					endTime = TimeUtil.dateToString1(new Date());
				}
			}
			request.setAttribute("timeType", timeType);
			request.setAttribute("isDuration", isDuration);
			if ("1".equals(isDuration)) {
				request.setAttribute("days", days);
			} else if ("0".equals(isDuration)) {
				request.setAttribute("startTime", startTime);
				request.setAttribute("endTime", endTime);
			}
			request.setAttribute("inactive", inactive);
			request.setAttribute("sort", sort);
			request.setAttribute("group", group);
		} catch (Exception e) {
			log.error("跳转资源排行失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("backstage/resourceAnalyze/file_ranking");
	}
	
	
	/**
	 * 查询资源排行数据
	 */
	@RequestMapping("/query_file_ranking")
	public void queryArealDistribution(HttpServletResponse response, FileStatsView fileStats) {
		JSONObject result = new JSONObject();
		try {
			List<FileStatsView> list = backFileAnalyzeService.queryFileRanking(fileStats);
			result.put("list", list);
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			log.error("查询课程排行数据失败", ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}

	}
	
	@RequestMapping("/export_course_ranking")
	public void exportCourseRanking(HttpServletRequest request, HttpServletResponse response,
			FileStatsView fileStats) {
		try {
			List<FileStatsView> list = backFileAnalyzeService.queryFileRanking(fileStats);
			String group = fileStats.getGroup();
			String title = "用户";
			String first = "username";
			if("0".equals(group)){
				title = "资源";
				first = "filename";
				for(FileStatsView fsv:list){
					fsv.setUploadNum(1);
				}
			}
			String[] head = {title,"下载量","收藏量","点击浏览量","购买量","上传量"};
			String[] fieldNames = {first, "downLoadNum", "collectionNum", "clickNum", "buyNum","uploadNum" };
			String fileName = "资源排行.xls";
			response.setContentType("application/msexcel");
			ExportExcel<FileStatsView> excel = new ExportExcel<FileStatsView>();
			response.setHeader("Content-Disposition", excel.getFileName(fileName, excel.getExplorer(request)));
			OutputStream out = response.getOutputStream();
			excel.exportExcel("资源", head, fieldNames, list, out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
