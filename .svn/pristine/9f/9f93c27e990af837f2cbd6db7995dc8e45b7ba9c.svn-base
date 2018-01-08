package cn.bnsr.edu_yun.util;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * Redis缓存工具类
 * @author fangxiongwei
 * @date 2016年12月8日
 */
@SuppressWarnings("static-access")
public class RedisUtils {
	private static Logger logger = Logger.getLogger(RedisUtils.class);

	/** 连接池 **/
	private static JedisPool jedisPool;
	
	public void setjedisPool(JedisPool jedisPool) {
		RedisUtils.jedisPool = jedisPool;
	}

	public JedisPool getjedisPool() {
        return jedisPool;  
	}
	
	private static Jedis jedis = null;
	
	 /** 
     * 从jedis连接池中获取获取jedis对象   
     * @return 
     */  
    public static Jedis getJedis() {    
        return jedisPool.getResource();   
   }  
	
	static {
		if (jedisPool == null) {  
			ConfigInfo ci = new ConfigInfo();
			JedisPoolConfig config = new JedisPoolConfig();  
            //控制一个pool可分配多少个jedis实例，通过pool.getResource()来获取；  
            //如果赋值为-1，则表示不限制；如果pool已经分配了maxActive个jedis实例，则此时pool的状态为exhausted(耗尽)。  
            config.setMaxActive(ci.getInteger("redis.maxActive"));  
            //控制一个pool最多有多少个状态为idle(空闲的)的jedis实例。  
            config.setMaxIdle(ci.getInteger("redis.maxIdle"));  
            //表示当borrow(引入)一个jedis实例时，最大的等待时间，如果超过等待时间，则直接抛出JedisConnectionException；  
            config.setMaxWait(ci.getLong("redis.maxWait"));  
            //在borrow一个jedis实例时，是否提前进行validate操作；如果为true，则得到的jedis实例均是可用的；  
            config.setTestOnBorrow(ci.getBoolean("redis.testOnBorrow"));  
            //redis未设置了密码：  
            jedisPool = new JedisPool(config, ci.getString("redis.host"), ci.getInteger("redis.port"));
            
            //redis如果设置了密码：  
           /* jedisPool = new JedisPool(config, JRedisPoolConfig.REDIS_IP,   
                    JRedisPoolConfig.REDIS_PORT,  
                    10000,JRedisPoolConfig.REDIS_PASSWORD);      */
        }  
		
	}
	
	/**
	 * 检测redis是否在运行
	 * 如果连接正常就返回一个 PONG ，否则返回一个连接错误。
	 */
	public static String ping(){
		Jedis jedis = getJedis();
		return jedis.ping();
	}
	
	 /** 
     * 查询key的过期时间 
     * -1, 如果key没有到期超时。  
	 * -2, 如果键不存在。 
     * @return 以秒为单位的时间表示 
     * */  
    public static long ttl(String key) {
    	long len = 0;
    	try {
    		jedis = getJedis();
	        len = jedis.ttl(SerializeUtils.serialize(key));  
		} catch (Exception e) {
			logger.error("Cache时间查询失败：" + e);
		} finally {
			releaseResource(jedis);
		}
        return len;  
    }  

	/**
	 * 释放redis资源
	 */
	private static void releaseResource(Jedis jedis) {
		if (jedis != null) {
			jedisPool.returnResource(jedis);
		}
	}
	
	/**
	 * 删除Redis中的所有key
	 */
	public static void flushAll() {
		
		try {
			jedis = getJedis();
			jedis.flushAll();
		} catch (Exception e) {
			logger.error("Cache清空失败：" + e);
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 保存一个对象到Redis中(缓存过期时间:使用此工具类中的默认时间) . <br/>
	 */
	public static Boolean set(Object key, Object object) {
		return set(key, object, ConfigInfo.getInteger("redis.cacheSeconds"));
	}

	/**
	 * 保存一个对象到redis中并指定过期时间
	 */
	public static Boolean set(Object key, Object object, int seconds) {
		
		try {
			jedis = getJedis();
			jedis.set(SerializeUtils.serialize(key), SerializeUtils.serialize(object));
			if(seconds!=0){//等于0没有缓存时间
				jedis.expire(SerializeUtils.serialize(key), seconds);
			}
			return true;
		} catch (Exception e) {
			logger.error("Cache保存失败：" + e);
			return false;
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 根据缓存键获取Redis缓存中的值.<br/>
	 */
	public static Object get(Object key) {
		
		try {
			jedis = getJedis();
			byte[] obj = jedis.get(SerializeUtils.serialize(key));
			return obj == null ? null : SerializeUtils.unSerialize(obj);
		} catch (Exception e) {
			logger.error("Cache获取失败：" + e);
			return null;
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 根据缓存键清除Redis缓存中的值.<br/>
	 */
	public static Boolean del(Object key) {
		
		try {
			jedis = getJedis();
			jedis.del(SerializeUtils.serialize(key));
			return true;
		} catch (Exception e) {
			logger.error("Cache删除失败：" + e);
			return false;
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 根据缓存键清除Redis缓存中的值.<br/>
	 */
	public static Boolean del(Object... keys) {
		
		try {
			jedis = getJedis();
			jedis.del(SerializeUtils.serialize(keys));
			return true;
		} catch (Exception e) {
			logger.error("Cache删除失败：" + e);
			return false;
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 
	 * @param key
	 * @param seconds
	 *            超时时间（单位为秒）
	 * @return
	 */
	public static Boolean expire(Object key, int seconds) {

		
		try {
			jedis = getJedis();
			jedis.expire(SerializeUtils.serialize(key), seconds);
			return true;
		} catch (Exception e) {
			logger.error("Cache设置超时时间失败：" + e);
			return false;
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 添加一个内容到指定key的hash中
	 */
	public static Boolean setHash(String key, Object field, Object value) {
		
		try {
			jedis = getJedis();
			jedis.hset(SerializeUtils.serialize(key), SerializeUtils.serialize(field), SerializeUtils.serialize(value));
			return true;
		} catch (Exception e) {
			logger.error("Cache保存失败：" + e);
			return false;
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 从指定hash中拿一个对象
	 */
	public static Object getHash(Object key, Object field) {
		
		try {
			jedis = getJedis();
			byte[] obj = jedis.hget(SerializeUtils.serialize(key), SerializeUtils.serialize(field));
			return SerializeUtils.unSerialize(obj);
		} catch (Exception e) {
			logger.error("Cache读取失败：" + e);
			return null;
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 从hash中删除指定filed的值
	 */
	public static Boolean delHash(Object key, Object field) {
		
		try {
			jedis = getJedis();
			long result = jedis.hdel(SerializeUtils.serialize(key), SerializeUtils.serialize(field));
			return result == 1 ? true : false;
		} catch (Exception e) {
			logger.error("Cache删除失败：" + e);
			return null;
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 拿到缓存中所有符合pattern的key
	 */
	public static Set<byte[]> keys(String pattern) {
		
		try {
			jedis = getJedis();
			Set<byte[]> allKey = jedis.keys(("*" + pattern + "*").getBytes());
			return allKey;
		} catch (Exception e) {
			logger.error("Cache获取失败：" + e);
			return new HashSet<byte[]>();
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 获得hash中的所有key value
	 */
	public static Map<byte[], byte[]> getAllHash(Object key) {
		
		try {
			jedis = getJedis();
			Map<byte[], byte[]> map = jedis.hgetAll(SerializeUtils.serialize(key));
			return map;
		} catch (Exception e) {
			logger.error("Cache获取失败：" + e);
			return null;
		} finally {
			releaseResource(jedis);
		}
	}

	/**
	 * 判断一个key是否存在
	 */
	public static Boolean exists(Object key) {
		
		Boolean result = false;
		try {
			jedis = getJedis();
			result = jedis.exists(SerializeUtils.serialize(key));
			return result;
		} catch (Exception e) {
			logger.error("Cache获取失败：" + e);
			return false;
		} finally {
			releaseResource(jedis);
		}
	}
}
