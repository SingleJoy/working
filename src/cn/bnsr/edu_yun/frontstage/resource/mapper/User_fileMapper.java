package cn.bnsr.edu_yun.frontstage.resource.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.bnsr.edu_yun.backstage.resource.view.ResourceStatsView;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file;
import cn.bnsr.edu_yun.frontstage.resource.view.RankView;
import cn.bnsr.edu_yun.frontstage.resource.view.ResouceFileView;

public interface User_fileMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_file
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_file
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    int insert(User_file record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_file
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    int insertSelective(User_file record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_file
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    User_file selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_file
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    int updateByPrimaryKeySelective(User_file record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table user_file
     *
     * @mbggenerated Tue Jul 26 16:00:41 CST 2016
     */
    int updateByPrimaryKey(User_file record);
    
    User_file selectFile(@Param("user_id")long user_id,@Param("file_id")long file_id);
    User_file selectBuyFile(@Param("user_id")long user_id,@Param("file_id")long file_id);
    /**
     * 根据用户id查文件
     * @param id
     * @return
     */
    public List<User_file> selectFileByUser(Long id);

	List<RankView> queryRankFile();

	List<ResouceFileView> queryUserFile(ResouceFileView resouceFileView);

	int queryTotalUserFile(ResouceFileView resouceFileView);
	
	//后台
	//统计资源使新增、浏览、收藏、下载趋势
	List<ResourceStatsView> queryFileAddStats(ResourceStatsView record);
	//统计资源审核合格、驳回趋势
	List<ResourceStatsView> queryFileCheckStats(ResourceStatsView record);

}