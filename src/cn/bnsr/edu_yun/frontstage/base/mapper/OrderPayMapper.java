package cn.bnsr.edu_yun.frontstage.base.mapper;

import cn.bnsr.edu_yun.frontstage.base.po.OrderPay;

public interface OrderPayMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order_pay
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order_pay
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    int insert(OrderPay record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order_pay
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    int insertSelective(OrderPay record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order_pay
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    OrderPay selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order_pay
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    int updateByPrimaryKeySelective(OrderPay record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order_pay
     *
     * @mbggenerated Tue Dec 20 15:18:33 CST 2016
     */
    int updateByPrimaryKey(OrderPay record);
}