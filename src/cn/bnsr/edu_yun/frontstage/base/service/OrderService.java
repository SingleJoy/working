package cn.bnsr.edu_yun.frontstage.base.service;

import java.text.ParseException;
import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.OrderStatsView;
import cn.bnsr.edu_yun.frontstage.base.po.Order;

public interface OrderService {

	/**
	 * 分页查询订单
	 * @param user_id
	 * @param start
	 * @param pageSize
	 * @return
	 */
	 List<Order> selectByUserId(long user_id,long start,long pageSize);
	 int deleteOrder(long id);
	 int updateOrder(Order order);
	 Order selectById(long id);
	 List<Order>  selectByUserIdSuccess(long user_id,long is_success,long start,long pageSize);
	 List<Order> selectByUserIdCount(long user_id);
	 List<Order> selectByUserIdSuccessCount(long user_id,long is_success);
	 int insertOrder(Order order);
	 
	 /**后台*/
	 
	 /**查询订单统计数据*/
	 List<OrderStatsView> queryOrderStats(OrderStatsView orderStats)throws ParseException ;
		 
	 List<Order> selectAllByTime(String username,String order_number,long start,long pageSize);
	 List<Order> selectAll();
	 List<Order> selectAllByTimeASC(String username,String order_number,long start,long pageSize);
	 List<Order> selectAllByAmount(String username,String order_number,long start,long pageSize);
	 List<Order> selectAllByAmountASC(String username,String order_number,long start,long pageSize);
     int delete(long id);
     int update(Order order);
     
  
}
