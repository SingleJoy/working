package cn.bnsr.edu_yun.comparator;

import java.util.Comparator;

import cn.bnsr.edu_yun.backstage.base.po.Menu;

/**
 *
 * 菜单排序
 * @author fangxiongwei
 * @date 2016年8月27日
 */
public class MenuComparator implements Comparator<Menu> {

	public int compare(Menu o1, Menu o2) {
		int i1 = o1.getSeq() != null ? o1.getSeq().intValue() : -1;
		int i2 = o2.getSeq() != null ? o2.getSeq().intValue() : -1;
		return i1 - i2;
	}


}
