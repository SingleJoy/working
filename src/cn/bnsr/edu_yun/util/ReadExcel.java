package cn.bnsr.edu_yun.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.LinkedList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class ReadExcel {
	/**
	 * 对外提供读取excel 的方法
	 * */
	public static List<List<Object>> readExcel(File file,int sheet,int firstrowIndex,int lastrowIndex,int maxcellIndex) throws IOException {
		String fileName = file.getName();
		String extension = fileName.lastIndexOf(".") == -1 ? "" : fileName
				.substring(fileName.lastIndexOf(".") + 1);
		if ("xls".equals(extension)) {
			return read2003Excel(file,sheet,firstrowIndex,lastrowIndex,maxcellIndex);
		} else if ("xlsx".equals(extension)) {
			return read2007Excel(file,sheet,firstrowIndex,lastrowIndex,maxcellIndex);
		} else {
			throw new IOException("不支持的文件类型");
		}
	}

	/**
	 * 读取 office 2003 excel
	 * 
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	private static List<List<Object>> read2003Excel(File file,int sheetIndex,int firstrowIndex,int lastrowIndex,int maxcellIndex)
			throws IOException {
		List<List<Object>> list = new LinkedList<List<Object>>();
		HSSFWorkbook hwb = null;
		HSSFSheet sheet =  null;
		try{
			hwb = new HSSFWorkbook(new FileInputStream(file));
			sheet = hwb.getSheetAt(sheetIndex);
		}catch(Exception e){
			return null;
		}
		Object value = null;
		HSSFRow row = null;
		HSSFCell cell = null;
//		int counter = 0;
//		int i = sheet.getFirstRowNum();
//		sheet.getPhysicalNumberOfRows();
		for ( int i = firstrowIndex ; i <= lastrowIndex; i++) {
			row = sheet.getRow(i);
			if (row == null) {
				continue;
			} 
			List<Object> linked = new LinkedList<Object>();
			for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++) {
				cell = row.getCell(j);
//				if (cell == null) {
//					continue;
//				}
				if(j>maxcellIndex&&cell!=null) return null;//格式不正确
				DecimalFormat df = new DecimalFormat("0");// 格式化 number String
															// 字符
				SimpleDateFormat sdf = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
				DecimalFormat nf = new DecimalFormat("0.00");// 格式化数字
				switch (cell.getCellType()) {
				case XSSFCell.CELL_TYPE_STRING:
				//	System.out.println(i + "行" + j + " 列 is String type");
					value = cell.getStringCellValue();
					break;
				case XSSFCell.CELL_TYPE_NUMERIC:
					/*System.out.println(i + "行" + j
							+ " 列 is Number type ; DateFormt:"
							+ cell.getCellStyle().getDataFormatString());*/
					if ("@".equals(cell.getCellStyle().getDataFormatString())) {
						value = df.format(cell.getNumericCellValue());
					} else if ("General".equals(cell.getCellStyle()
							.getDataFormatString())) {
						value = nf.format(cell.getNumericCellValue());
					} else {
						value = sdf.format(HSSFDateUtil.getJavaDate(cell
								.getNumericCellValue()));
					}
					break;
				case XSSFCell.CELL_TYPE_BOOLEAN:
				//	System.out.println(i + "行" + j + " 列 is Boolean type");
					value = cell.getBooleanCellValue();
					break;
				case XSSFCell.CELL_TYPE_BLANK:
				//	System.out.println(i + "行" + j + " 列 is Blank type");
					value = "";
					break;
				default:
				//	System.out.println(i + "行" + j + " 列 is default type");
					value = cell.toString();
				}
				if (value == null || "".equals(value)) {
					value = "";
				}
				linked.add(value);
			}
			list.add(linked);
		}
		return list;
	}

	/**
	 * 读取Office 2007 excel
	 * */
	private static List<List<Object>> read2007Excel(File file,int sheetIndex,int firstrowIndex,int lastrowIndex,int maxcellIndex)
			throws IOException {
		List<List<Object>> list = new LinkedList<List<Object>>();
		XSSFWorkbook xwb = null;
		XSSFSheet sheet = null;
		try{
			// 构造 XSSFWorkbook 对象，strPath 传入文件路径
			xwb = new XSSFWorkbook(new FileInputStream(file));
			// 读取第一章表格内容
			sheet = xwb.getSheetAt(sheetIndex);
		}catch(Exception e){
			return null;
		}
		Object value = null;
		XSSFRow row = null;
		XSSFCell cell = null;
//		int counter = 0;
//		int i = sheet.getFirstRowNum();
//		sheet.getPhysicalNumberOfRows();
		for ( int i = firstrowIndex ;i <= lastrowIndex;  i++) {
			row = sheet.getRow(i);
			if (row == null) {
				continue;
			} 
			List<Object> linked = new LinkedList<Object>();
			for (int j = row.getFirstCellNum(); j <= row.getLastCellNum(); j++) {
				cell = row.getCell(j);
//				if (cell == null) {
////					value = "";
////					linked.add(value);
//					continue;
//				}
				if(j>maxcellIndex&&cell!=null) return null;
				DecimalFormat df = new DecimalFormat("0");// 格式化 number String
															// 字符
				SimpleDateFormat sdf = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");// 格式化日期字符串
				DecimalFormat nf = new DecimalFormat("0");// 格式化数字
				switch (cell.getCellType()) {
				case XSSFCell.CELL_TYPE_STRING:
					//System.out.println(i + "行" + j + " 列 is String type");
					value = cell.getStringCellValue();
					break;
				case XSSFCell.CELL_TYPE_NUMERIC:
				/*	System.out.println(i + "行" + j
							+ " 列 is Number type ; DateFormt:"
							+ cell.getCellStyle().getDataFormatString());*/
					if ("@".equals(cell.getCellStyle().getDataFormatString())) {
						value = df.format(cell.getNumericCellValue());
					} else if ("General".equals(cell.getCellStyle()
							.getDataFormatString())) {
						value = nf.format(cell.getNumericCellValue());
					} else {
						value = sdf.format(HSSFDateUtil.getJavaDate(cell
								.getNumericCellValue()));
					}
					break;
				case XSSFCell.CELL_TYPE_BOOLEAN:
			//		System.out.println(i + "行" + j + " 列 is Boolean type");
					value = cell.getBooleanCellValue();
					break;
				case XSSFCell.CELL_TYPE_BLANK:
				//	System.out.println(i + "行" + j + " 列 is Blank type");
					value = "";
					break;
				default:
				//	System.out.println(i + "行" + j + " 列 is default type");
					value = cell.toString();
				}
				if (value == null || "".equals(value)) {
					value = "";
				}
				linked.add(value);
			}
			list.add(linked);
		}
		return list;
	}

	
}
