package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.CertModelPictureMapper;
import cn.bnsr.edu_yun.frontstage.train.po.CertModelPicture;
import cn.bnsr.edu_yun.frontstage.train.service.CertModelPictureService;
import cn.bnsr.edu_yun.frontstage.train.view.CertModelPictureView;

public class CertModelPictureServiceImpl implements CertModelPictureService {

	@Autowired
	private CertModelPictureMapper certModelPictureMapper;
	
	@Override
	public void saveCertModelPicture(CertModelPicture certModelPicture) {
		certModelPictureMapper.insertSelective(certModelPicture);

	}

	@Override
	public List<CertModelPictureView> selectAllPicture(CertModelPictureView certModelPictureView) {
		return certModelPictureMapper.selectAllPicture(certModelPictureView);
	}

	@Override
	public Integer countCertModelPicture(CertModelPictureView certModelPictureView) {
		return certModelPictureMapper.countCertModelPicture(certModelPictureView);
	}

	@Override
	public void deleteCertModelPicture(Long id) {
		certModelPictureMapper.deleteByPrimaryKey(id);
		
	}

	@Override
	public CertModelPicture selectOne(Long id) {
		// TODO Auto-generated method stub
		return certModelPictureMapper.selectByPrimaryKey(id);
	}

	@Override
	public CertModelPicture getDefaultImg(Integer type) {
		// TODO Auto-generated method stub
		return certModelPictureMapper.getDefaultImg(type);
	}

	@Override
	public void updateCertModelPicture(CertModelPicture certModelPicture) {
		// TODO Auto-generated method stub
		certModelPictureMapper.updateByPrimaryKeySelective(certModelPicture);
	}

}
