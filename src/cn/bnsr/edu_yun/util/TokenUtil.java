package cn.bnsr.edu_yun.util;

import java.io.IOException;

/**
 * 根据文件名生成唯一key
 */
public class TokenUtil {

	/**
	 * 生成Token， A(hashcode>0)|B + |name的Hash值| +_+size的值
	 * @param name
	 * @param size
	 * @return
	 * @throws Exception
	 */
	public static String generateToken(String name, String size)
			throws IOException {
		if (name == null || size == null)
			return "";
		int code = name.hashCode();
		try {
			return (code > 0 ? "A" : "B") + Math.abs(code) + "_" + size.trim();
		} catch (Exception e) {
			throw new IOException(e);
		}
	}
}
