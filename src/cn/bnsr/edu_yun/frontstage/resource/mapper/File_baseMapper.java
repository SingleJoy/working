package cn.bnsr.edu_yun.frontstage.resource.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.bnsr.edu_yun.backstage.resource.view.BackFileView;
import cn.bnsr.edu_yun.backstage.resource.view.FileStatsView;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.view.FileView;
import cn.bnsr.edu_yun.frontstage.resource.view.ResourceView;

public interface File_baseMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table file_base
     *
     * @mbggenerated Thu Aug 04 09:22:21 CST 2016
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table file_base
     *
     * @mbggenerated Thu Aug 04 09:22:21 CST 2016
     */
    int insert(File_base record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table file_base
     *
     * @mbggenerated Thu Aug 04 09:22:21 CST 2016
     */
    int insertSelective(File_base record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table file_base
     *
     * @mbggenerated Thu Aug 04 09:22:21 CST 2016
     */
    File_base selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table file_base
     *
     * @mbggenerated Thu Aug 04 09:22:21 CST 2016
     */
    int updateByPrimaryKeySelective(File_base record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table file_base
     *
     * @mbggenerated Thu Aug 04 09:22:21 CST 2016
     */
    int updateByPrimaryKey(File_base record);
    
    public List<File_base> selectAnyOne(File_base file_base);
    
    
    public List<File_base> selectByUserId(@Param("upload_user")long user_id,@Param("start")long start,@Param("pageSize")long pageSize);
    public List<File_base> selectAll();

    public List<FileView> queryUserFile(FileView fileView);

    public int getTotalFile(FileView fileView);

	public List<File_base> queryHotFile();

	public List<ResourceView> queryRecommend();

	public List<ResourceView> queryResource(ResourceView resourceView);

	public int queryTotalResource(ResourceView resourceView);
	public List<File_base> selectBySearch(@Param("str")String str,@Param("format")String format,@Param("start")long start,@Param("pageSize")long pageSize);
	public List<File_base> selectBySearchCount(@Param("str")String str,@Param("format")String format);
	
	public List<File_base> selectBySearchByTime(@Param("str")String str,@Param("format")String format,@Param("start")long start,@Param("pageSize")long pageSize);

	public List<File_base> selectBySearchByDownload(@Param("str")String str,@Param("format")String format,@Param("start")long start,@Param("pageSize")long pageSize);

    public List<File_base> selectBySearchByAgree(@Param("str")String str,@Param("format")String format,@Param("start")long start,@Param("pageSize")long pageSize);
    
    public List<File_base> find(BackFileView backFileView);

	public Long count(BackFileView backFileView);

	List<FileStatsView> queryFileStats(FileStatsView fileStats);
	
	public List<File_base> selectByBack(@Param("str")String str,@Param("sort")String sort,@Param("order")String order,@Param("start")long start,@Param("pageSize")long pageSize);

	File_base getById(@Param("id")String id);
	
	public List<BackFileView> findGeneral(BackFileView backFileView);

	public Long countGeneral(BackFileView backFileView);
	
	List<FileStatsView> queryFileStatic(FileStatsView fileStats);
	
	List<FileStatsView> queryFileRanking0(FileStatsView fileStats);

	List<FileStatsView> queryFileRanking1(FileStatsView fileStats);
}