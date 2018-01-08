package cn.bnsr.edu_yun.util;

import java.text.CollationKey;
import java.text.Collator;
import java.util.Comparator;

import cn.bnsr.edu_yun.frontstage.base.po.Area;

public class MyArrayComparator implements Comparator{

	private Collator collator = Collator.getInstance();
	@Override
	public int compare(Object o1, Object o2) {
		Area a=(Area) o1;
		Area b=(Area) o2;
		CollationKey key1=collator.getCollationKey(a.getArea_name());
		CollationKey key2=collator.getCollationKey(b.getArea_name());
		return key1.compareTo(key2);
	}

}
