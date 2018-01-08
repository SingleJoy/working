package cn.bnsr.edu_yun.util;

import java.awt.Image;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.lang.reflect.Method;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.security.AccessController;
import java.security.PrivilegedAction;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.sun.pdfview.PDFFile;
import com.sun.pdfview.PDFPage;

/**
 * pdf转换图片
 * @author fangxiongwei
 * @date 2016年9月9日
 */
public class ConverImage {
	private final static Logger log = LoggerFactory.getLogger(ConverImage.class);

	// 将PDF格式的文件转换为JPG格式的文件
	public String pdfToJPG(String inputFile,String outFile){
		log.info("====开始转换图片===="+inputFile);
		// load a pdf from a byte buffer
		File file = new File(inputFile);
		RandomAccessFile raf;
		FileChannel channel = null;
		ByteBuffer buf = null;
		try {
			raf = new RandomAccessFile(file, "r");
			channel = raf.getChannel();
			//这句代码通道建立了map映射,如果要删除file那么得接触映射
			buf = channel.map(FileChannel.MapMode.READ_ONLY, 0,channel.size());
			PDFFile pdffile = new PDFFile(buf);
			int totalpage =pdffile.getNumPages();
			for (int i = 1; i <= totalpage; i++) {
				if (i == 1) {
					// draw the first page to an image
					// 以图片的形式来描绘首页
					PDFPage page = pdffile.getPage(i);
					Rectangle rect = new Rectangle(0, 0, (int) page.getBBox().getWidth(), (int) page.getBBox().getHeight());
					// generate the image
					// 生成图片
					Image img = page.getImage(rect.width, rect.height, // width &
						// height
						rect, // clip rect
						null, // null for the ImageObserver
						true, // fill background with white
						true // block until drawing is done
						);
					BufferedImage tag = new BufferedImage(rect.width, rect.height,
					BufferedImage.TYPE_INT_RGB);
					tag.getGraphics().drawImage(img.getScaledInstance(rect.width, rect.height, Image.SCALE_SMOOTH), 0, 0, rect.width, rect.height,null);
			
					FileOutputStream out = new FileOutputStream(outFile); // 输出到文件流
					JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
					encoder.encode(tag); // JPEG编码
					log.info("====转换成功===="+outFile);
					// 关闭输出流
					out.close();
				}
			}
			buf.clear();
			channel.close();
			raf.close();
			unmap(buf);
			//删除源文件
		//	file.delete();
			return outFile;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "0";

	}
		//解除map映射
	public static <T> void unmap(final Object buffer) {
		AccessController.doPrivileged(new PrivilegedAction<T>(){
			@Override
			public T run() { 
				try {
					Method getCleanerMethod = buffer.getClass().getMethod("cleaner", new Class[0]);
					getCleanerMethod.setAccessible(true);
					sun.misc.Cleaner cleaner = (sun.misc.Cleaner) getCleanerMethod.invoke(buffer, new Object[0]);
					cleaner.clean();
				} catch(Exception e) {
					log.info("====转换异常====");
					e.printStackTrace();
				} 
				return null;
			} 
		});
	}
}
