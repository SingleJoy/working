package cn.bnsr.edu_yun.comparator;

import java.util.Comparator;

import cn.bnsr.edu_yun.backstage.content.view.ContentStatiView;
import cn.bnsr.edu_yun.util.TimeUtil;

/**
 * 内容统计视图排序
 * @author heliwei
 *
 */
public class ContentStatiComparator implements Comparator<ContentStatiView>{

	@Override
	public int compare(ContentStatiView o1, ContentStatiView o2) {
		return TimeUtil.compare_date(o1.getDays(), o2.getDays());
	}

}
