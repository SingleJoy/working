package cn.bnsr.edu_yun.util;

import java.io.Serializable;
import java.util.Vector;

public class ThreadWaitNotifyTest {
	public static void main(String args[]) {
		Vector v = new Vector();
		Cangku obj = new Cangku(v);
		for (int i = 1; i < 6; i++) {
			Thread consumer = new Thread(new Consumer(obj, i));
			
			consumer.start();
		}
		for (int i = 1; i < 6; i++) {
		
			Thread producter = new Thread(new Producter(obj, i));
		
			producter.start();
			
		}
	}
}

class Cangku implements Serializable {
	private Vector obj;//物品
    private int status=0;//1:为消费者消费，0;为生产者生产
	public Cangku(Vector v) {
		this.obj = v;
	}

	public Vector getObj() {
		return this.obj;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}

/* 消费者 */
class Consumer implements Runnable {
	private Cangku obj;
	private int i;

	public Consumer(Cangku v, int i) {
		this.obj = v;
		this.i = i;
	}

	public void run() {
		synchronized (obj) {
			while (true) {
				try {
					if(obj.getStatus()==0){
						obj.notifyAll();
						obj.wait();
						continue;
					}
					
					if (obj.getObj().size() == 0) {
						obj.setStatus(0);
						obj.notifyAll();
						obj.wait();
					} else {
						obj.getObj().removeElement("物品");
						System.out.println("消费者" + i + "消费了1个，还剩" + obj.getObj().size());
						Thread.sleep(500);
						obj.notifyAll();
						obj.wait();
						
						
					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}

/* 生产者 */
class Producter implements Runnable {
	private Cangku obj;
	private int i;

	public Producter(Cangku v, int i) {
		this.obj = v;
		this.i = i;
	}

	public void run() {

		synchronized (obj) {
			while (true) {
				try {
					if(obj.getStatus()==1){
						obj.notifyAll();
						obj.wait();
						continue;
					}
					
					if (obj.getObj().size() == 20) {
						obj.setStatus(1);	
						obj.notifyAll();
						obj.wait();
					} else {
						obj.getObj().add(new String("物品"));
						System.out.println("生产者" + i + "生产了" + obj.getObj().size()+"个");
						Thread.sleep(500);
						obj.notifyAll();
						obj.wait();

					}

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
