package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.UserTrackView;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.frontstage.base.view.UserDetailView;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file;
import cn.bnsr.edu_yun.frontstage.train.view.TeacherRelationView;
/**
 * @author Administrator
 *
 */
public interface UserService {
	/**
	 * 生成附加属性表
	 * @param userProperty
	 * @return
	 */
	public int insertProperty(UserProperty userProperty);
	/**
	 * 修改附加属性表
	 * @param userProperty
	 * @return
	 */
	public int updateProperty(UserProperty userProperty);
	public UserProperty selectProperty(long id);
	/**
	 * 生成user_file表
	 * @param user_file
	 * @return
	 */
	public int insertUserFile(User_file user_file);
	/**
	 * 通过id查询userProperty
	 * @param id
	 * @return
	 */
	public UserProperty selectUserPropertyById(Long id);
	/**
	 * 生成用户表
	 * @param user
	 * @return
	 */
	public int insert(User user);
	/**
	 * 通过user查询
	 * @param id
	 * @return
	 */
	public User selectByUserId(Long id);
	/**
	 * 通过username查询,判断用户名是否重复
	 * @param username
	 * @return true表示用户已存在,false表示用户不存在
	 */
	public boolean selectByUsername(User user);
	/**
	 * 通过phone查询,判断phone是否重复
	 * @param phone
	 * @return true表示用户已存在,false表示用户不存在
	 */
	public boolean selectByPhone(String phone);
	/**
	 * 通过phone查询,判断phone是否重复
	 * @param phone
	 * @return true表示用户已存在,false表示用户不存在
	 */
	public User selectUserByPhone(String phone);
	/**
	 * 通过username和password查询，判断用户是否存在
	 * @param username
	 * @param password
	 * @return
	 */
	public boolean selectByUsernameAndPassword(String username,String password,User user);
	public User selectByPrimaryKey(long id);
	
	/**根据用户id查询最新关注的人*/
	public List<User> queryNewAttent(Long userId);
	
	List<User>	selectAllNum();
	int updateUser(User user);
	
	public TeacherRelationView searchUser(String username, String usertype);
	public UserDetailView selectUserDetail(String id);
	
	public User queryUser(User user);
	
	public TeacherRelationView searchUser0(String username, String usertype);
	
	/**根据用户id查询个人中心信息*/
	public UserCenterView queryUserCenter(Long userId);
	
	List<UserTrackView> queryUserTrackClassView(UserTrackView userTrackView);
	
}
