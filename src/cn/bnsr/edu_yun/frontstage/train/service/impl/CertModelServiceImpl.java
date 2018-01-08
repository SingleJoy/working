package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.CertModelMapper;
import cn.bnsr.edu_yun.frontstage.train.po.CertModel;
import cn.bnsr.edu_yun.frontstage.train.service.CertModelService;
import cn.bnsr.edu_yun.frontstage.train.view.CertModelView;

public class CertModelServiceImpl implements CertModelService {

	@Autowired
	private CertModelMapper certModelMapper;
	@Override
	public void saveCertModel(CertModel certModel) {
		certModelMapper.insertSelective(certModel);

	}

	@Override
	public void updateCertModel(CertModel certModel) {
		certModelMapper.updateByPrimaryKeySelective(certModel);

	}

	@Override
	public List<CertModelView> selectAll(CertModelView certModelView) {
		return certModelMapper.selectAllCertModel(certModelView);
	}

	@Override
	public Integer countCertModelView(CertModelView certModelView) {
		return certModelMapper.countCertModel(certModelView);
	}

	@Override
	public CertModelView queryCertModel(Long id) {
		return certModelMapper.queryCertModel(id);
	}

	@Override
	public void deleteCertModel(Long id) {
		certModelMapper.deleteByPrimaryKey(id);
		
	}

}
