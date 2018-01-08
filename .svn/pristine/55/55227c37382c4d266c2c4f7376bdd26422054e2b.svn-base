package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.OrderStatsView;
import cn.bnsr.edu_yun.comparator.OrderStatsComparator;
import cn.bnsr.edu_yun.frontstage.base.mapper.OrderMapper;
import cn.bnsr.edu_yun.frontstage.base.po.Order;
import cn.bnsr.edu_yun.frontstage.base.service.OrderService;
import cn.bnsr.edu_yun.util.TimeUtil;

public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderMapper orderMapper;
	@Override
	public List<Order> selectByUserId(long user_id, long start, long pageSize) {
		
		return orderMapper.selectByUserId(user_id, start, pageSize);
	}
	@Override
	public int deleteOrder(long id) {
		// TODO Auto-generated method stub
		return orderMapper.deleteByPrimaryKey(id);
	}
	@Override
	public int updateOrder(Order order) {
		// TODO Auto-generated method stub
		return orderMapper.updateByPrimaryKeySelective(order);
	}
	@Override
	public Order selectById(long id) {
		// TODO Auto-generated method stub
		return orderMapper.selectByPrimaryKey(id);
	}
	@Override
	public List<Order> selectByUserIdSuccess(long user_id, long is_success,
			long start, long pageSize) {
		// TODO Auto-generated method stub
		return orderMapper.selectByUserIdSuccess(user_id, is_success, start, pageSize);
	}
	@Override
	public List<Order> selectByUserIdCount(long user_id) {
		// TODO Auto-generated method stub
		return orderMapper.selectByUserIdCount(user_id);
	}
	@Override
	public List<Order> selectByUserIdSuccessCount(long user_id,long is_success) {
		// TODO Auto-generated method stub
		return orderMapper.selectByUserIdSuccessCount(user_id, is_success);
	}
	@Override
	public int insertOrder(Order order) {
		// TODO Auto-generated method stub
		return orderMapper.insertSelective(order);
	}

	
	@Override
	public List<OrderStatsView> queryOrderStats(OrderStatsView orderStats) throws ParseException {
		Date date = new Date();
		List<String> list = new ArrayList<String>();
		if(orderStats.getYear().equals("")){//年月没选
			//获的当前年月
			orderStats.setDays(TimeUtil.getDate());
			date = TimeUtil.stringFormatDate(orderStats.getDays());
			list = TimeUtil.getAllTheDateOftheMonth(date);
		}else{
			if(orderStats.getMonth().equals("")){//只选年
				for(int i=1;i<=12;i++){
					String month = i>=10?i+"":"0"+i;
					list.add(orderStats.getYear()+"-"+month);
				}
				orderStats.setDays(orderStats.getYear());
			}else{//年月都选
				orderStats.setDays(orderStats.getYear()+"-"+orderStats.getMonth());
				date = TimeUtil.stringFormatDate(orderStats.getDays());
				list = TimeUtil.getAllTheDateOftheMonth(date);
			}
		}
		
		List<OrderStatsView> orderStatsList = orderMapper.queryOrderStats(orderStats);
		if(orderStatsList.size()!=list.size()){//如果不相等，证明有缺少日期
			List<String> orderList = new ArrayList<String>();
			for(OrderStatsView f : orderStatsList){
				orderList.add(f.getDays());
			}
			list.removeAll(orderList);//差集
			for(int i=0;i<list.size();i++){//补全当前月日期
				OrderStatsView order = new OrderStatsView();
				order.setAmountNum(0);
				order.setOrderNum(0);
				order.setDays(list.get(i));
				orderStatsList.add(order);
			}
		}
		
		Collections.sort(orderStatsList, new OrderStatsComparator());// 排序
		
		return orderStatsList;
	}
	
	@Override
	public List<Order> selectAllByTime(String username,String order_number,long start, long pageSize) {
		// TODO Auto-generated method stub
		return orderMapper.selectAllByTime(username,order_number,start, pageSize);
	}

	@Override
	public List<Order> selectAll() {
		// TODO Auto-generated method stub
		return orderMapper.selectAll();
	}

	@Override
	public List<Order> selectAllByTimeASC(String username,String order_number,long start, long pageSize) {
		// TODO Auto-generated method stub
		return orderMapper.selectAllByTimeASC(username,order_number,start, pageSize);
	}

	@Override
	public List<Order> selectAllByAmount(String username, String order_number,
			long start, long pageSize) {
		// TODO Auto-generated method stub
		return orderMapper.selectAllByAmount(username, order_number, start, pageSize);
	}

	@Override
	public List<Order> selectAllByAmountASC(String username,
			String order_number, long start, long pageSize) {
		// TODO Auto-generated method stub
		return orderMapper.selectAllByAmountASC(username, order_number, start, pageSize);
	}

	@Override
	public int delete(long id) {
		// TODO Auto-generated method stub
		return orderMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int update(Order order) {
		// TODO Auto-generated method stub
		return orderMapper.updateByPrimaryKeySelective(order);
	}

}
