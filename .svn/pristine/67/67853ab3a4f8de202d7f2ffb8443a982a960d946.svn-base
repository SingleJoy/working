package cn.bnsr.edu_yun.util;

import java.security.MessageDigest;

public class MD5 {

	private static final String HEX_NUMS_STR = "0123456789ABCDEF";
	private static final Integer SALT_LENGTH = 12;

	public final static String MD5c(String s) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
		try {
			byte[] strTemp = s.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 加密解密算法 执行一次加密，两次解密
	 */
	public static String convertMD5(String inStr) {

		char[] a = inStr.toCharArray();
		for (int i = 0; i < a.length; i++) {
			a[i] = (char) (a[i] ^ 't');
		}
		String s = new String(a);
		return s;

	}

	public static byte[] hexStringToByte(String hex) {
		int len = (hex.length() / 2);
		byte[] result = new byte[len];
		char[] hexChars = hex.toCharArray();
		for (int i = 0; i < len; i++) {
			int pos = i * 2;
			result[i] = (byte) (HEX_NUMS_STR.indexOf(hexChars[pos]) << 4 | HEX_NUMS_STR.indexOf(hexChars[pos + 1]));
		}
		return result;
	}

	public static void main(String[] args) {
		// MD5_Test aa = new MD5_Test();
//		System.out.println(MD5c("ceshi"));
//		byte[] bs = hexStringToByte(MD5c("ceshi"));
//		StringBuilder sb = new StringBuilder("");
//		for(byte b:bs){
//			sb.append(b);
//		}
//		System.out.println(sb.toString());
//		System.out.println(MD5.MD5c("yjaqktpp") == MD5.MD5c("yjaqktpp"));
//		System.out.println(MD5.MD5c("yjaqktpp").equals(MD5.MD5c("yjaqktpp")));
		System.out.println(MD5c("111111").equals("96e79218965eb72c92a549dd5a330112"));
		System.out.println("e10adc3949ba59abbe56e057f20f883e".equals(MD5.MD5c("123456")));

	}
}
