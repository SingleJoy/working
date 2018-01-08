package cn.bnsr.edu_yun.util;


import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * 创建人：fantasy <br>
 * 创建时间：2013-8-27 <br>
 * 功能描述： 处理数字的Util、计算百分比<br>
 */
public class NumUtil {
    /**
     * 转换为BigDecimal
     *  
     * @param o
     * @return BigDecimal
     * @author fantasy 
     * @date 2013-8-27
     */
    public static BigDecimal toBig(Object o) {
        if (o == null || o.toString().equals("") || o.toString().equals("NaN")) {
            return new BigDecimal(0);
        }
        return new BigDecimal(o.toString());
    }
    
    /**
     * 计算百分比
     *  
     * @param divisor
     * @param dividend
     * @return String
     * @author fantasy 
     * @date 2013-8-27
     */
    public static String getPercent(Object divisor, Object dividend){
        if(divisor == null || dividend == null){
            return "";
        }
        NumberFormat percent = NumberFormat.getPercentInstance();   
        //建立百分比格式化引用   
        percent.setMaximumFractionDigits(2);
        BigDecimal a = toBig(divisor);
        BigDecimal b = toBig(dividend);
        if(a.equals(toBig(0)) || b.equals(toBig(0)) || a.equals(toBig(0.0)) || b.equals(toBig(0.0))){
       	 return "0.00%";
        }
        BigDecimal c = a.divide(b, 4, BigDecimal.ROUND_DOWN);
        return percent.format(c);
    }
    
    /**
     * 计算比例
     *  
     * @param divisor
     * @param dividend
     * @return String
     * @author fantasy 
     * @date 2013-10-9
     */
    public static String divideNumber(Object divisor, Object dividend){
    	if(divisor == null || dividend == null){
            return "";
        }
    	 BigDecimal a = toBig(divisor);
         BigDecimal b = toBig(dividend);
         if(a.equals(toBig(0)) || b.equals(toBig(0))){
        	 return "0";
         }
         BigDecimal c = a.divide(b, 2, BigDecimal.ROUND_DOWN);
         return c.toString();
    }
    
    /**
     * 去两个数的平均值，四舍五入
     *  
     * @param divisor
     * @param dividend
     * @return int
     * @author fantasy 
     * @date 2013-11-6
     */
    public static int averageNumber(Object divisor, Object dividend){
    	if(divisor == null || dividend == null){
            return 0;
        }
    	BigDecimal a = toBig(divisor);
        BigDecimal b = toBig(dividend);
        if(a.equals(toBig(0)) || b.equals(toBig(0))){
       	 	return 0;
        }
        BigDecimal c = a.divide(b, 0, BigDecimal.ROUND_HALF_UP);
        return c.intValue();
    }
    
    /**
     * length转换size
     * @param length
     * @return
     */
    public static String toSize(long length){
    	String size = "";
		if(length<1024){
			size = length+"B";
		}else if(length<1024*1024){
			size = length*100/1024/100.0+"KB";
		}else if(length<1024*1024*1024){
			size = length*100/1024/1024/100.0+"MB";
		}else{
			size = length*100/1024/1024/1024/100.0+"GB";
		}
    	return size;
    }
    
    /**
     * fangxiongwei
     * 2016年8月15日
     * 处理判断是否为空字符串
     */
    public static String isNotEmpty(String value,int index){
    	return !value.split(",")[index].equals("")?value.split(",")[index]:"";
    }
    /**
     * fangxiongwei
     * 2016年8月23日
     * 根据总数\每页显示数计算总页数
     * @return
     */
    public static int totalPage(int total,int number){
    	int totalPage = 0;
    	if(total!=0){
    		if(total/number==0){
    			totalPage=1;
    		}else{
    			if(total%number==0){
    				totalPage=total/number;
    			}else{
    				totalPage=(total/number+1);
    			}
    		}
    	}
    	return totalPage;
    }
    
    /**
     * fangxiongwei
     * 2016年8月31日
     * 根据当前页/每页显示条数计算分页起始数
     */
    public static int startingNum(int page,int rows){
    	return (page-1)*rows;
    }
    
    /**
	  * fangxiongwei
	  * 20161205
	  * 得到length位随机数
	  */
	 public static String getRandomChar(int length) {
		 char[] chr = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
		 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
		 Random random = new Random();
		 StringBuffer buffer = new StringBuffer();
		 for (int i = 0; i < length; i++) {
			 buffer.append(chr[random.nextInt(62)]);
		 }
		 return buffer.toString();
	}
	 
	/**
	 * fangxiongwei
	 * 20161223
	 * 生成班级密码，
	 * 10位随机数+两位随机数字
	 * @return
	 */
	public static String getClassPassWord() {
		return getRandomChar(10)+(int)((Math.random()*9+1)*10);
	}
	
	/**
	 * 获取in条件参数
	 * fangxiongwei
	 * 20161228
	 * @param ids "1,2,3"
	 * @return List<String>
	 */
	public static List<String> getList(String ids){
		String[] str = ids.split(",");
		List<String> strList = new ArrayList<String>();
		for(int i=0;i<str.length;i++){
			strList.add(str[i]);
		}
		return strList;
	}
}