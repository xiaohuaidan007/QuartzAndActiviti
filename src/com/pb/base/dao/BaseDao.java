package com.pb.base.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.pb.base.exception.DaoException;

/**
 * @author WANGRENFENG041
 * 基类Dao，对Mybatis方法进行客户化
 * 2016-06-25
 */
@Repository("baseDao")
@SuppressWarnings(value="rawtypes")
public class BaseDao extends SqlSessionDaoSupport{

	/**
	 * 批量插入数量最大值
	 */
	public static final int INSERT_BATCH_SIZE_MAX_NUM = 1000;
	/**
	 * 批量更新数量最大值
	 */
	public static final int UPDATE_BATCH_SIZE_MAX_NUM = 1000;
	/**
	 * 批量删除数量最大值
	 */
	public static final int DELETE_BATCH_SIZE_MAX_NUM = 1000;
	
//	@Resource
	private TransactionTemplate transactionTemplate;
	

	private Logger logger = LoggerFactory.getLogger(BaseDao.class);
	
	@Autowired
	public BaseDao(
			@Qualifier("sqlSessionFactory") SqlSessionFactory sqlSessionFactory) {
		super.setSqlSessionFactory(sqlSessionFactory);
	}

	/**
	 * 删除数据
	 * 
	 * @author WANGRENFENG041
	 * @param statementName
	 * @param parameterObject
	 * @return 返回删除记录数
	 * @throws
	 */
	public final int delete(final String statementName,
			final Object parameterObject) throws DaoException {
		try {
			return this.getSqlSession().delete(statementName, parameterObject);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}
	}

	/**
	 * 批量删除数据
	 * 
	 * @author WANGRENFENG041
	 * @param statementName
	 * @param list
	 *            返回删除失败的记录集合,为空表示全部成功处理
	 * @return
	 * @throws
	 */
	public int batchDelete(final String statementName, final List list)
			throws DaoException {
		int sum = 0;
		try {
			if(null != list && list.size() >0){
				int startIndex = 0;
				int endIndex = 0;
				List subList = null;
			    while(list.size()>=endIndex){
			    	if(list.size()-endIndex > DELETE_BATCH_SIZE_MAX_NUM){
			    		endIndex = endIndex + DELETE_BATCH_SIZE_MAX_NUM;
			    		subList = list.subList(startIndex, endIndex);
			    		startIndex = startIndex + DELETE_BATCH_SIZE_MAX_NUM;
			    	}else{
			    		endIndex = list.size();
			    		subList = list.subList(startIndex, endIndex);
			    		endIndex++;
			    	}
//			    	如下写法为编程式事务写法1，代码控制事务的开启与关闭以及自定义事务的传播方式与隔离级别，此方法为最灵活方式，但代码侵入性比较强
//			    	TransactionDefinition transactionDefinition = new DefaultTransactionDefinition(TransactionDefinition.PROPAGATION_REQUIRED);
//			    	TransactionStatus transactionStatus = platformTransactionManager.getTransaction(transactionDefinition);
//			    	try{
//			    		sum = sum + this.getSqlSession().delete(statementName, subList);
//			    		platformTransactionManager.commit(transactionStatus);
//			    	}catch(Exception ex){
//			    		platformTransactionManager.rollback(transactionStatus);
//			    		throw new DaoException(ex);
//			    	}
			    	
//                  如下为无返回结果TransactionTemplate回调方法
//			    	transactionTemplate.execute(new TransactionCallbackWithoutResult() {
//						protected void doInTransactionWithoutResult(
//								TransactionStatus transactionstatus) {
//							try{
//								for(int indx = 0;indx<tempList.size();indx++){
//									getSqlSession().delete(statementName,tempList.get(indx));
//								}
//							}catch(Exception ex){
//								transactionstatus.setRollbackOnly();
//								throw new DaoException(ex);
//							}
//						}
//					});
			    	
			    	//如下写 法为编程式事务写法2，由TransactionTemplate执行内部回调函数，交由TransactionTemplate控制事务的开启与关闭，此方法较方法1，代码侵入性差，但事务配置为全局性。
			    	final List tempList = subList;
			    	sum = sum + transactionTemplate.execute(new TransactionCallback<Integer>() {
			    		public Integer doInTransaction(TransactionStatus transactionstatus) {
			    			try{
			    				int size = 0;
				    			for(int indx = 0;indx<tempList.size();indx++){
				    				size = size + getSqlSession().delete(statementName,tempList.get(indx));
				    			}
				    			return new Integer(size);
							}catch(Exception ex){
								transactionstatus.setRollbackOnly();
								throw new DaoException(ex);
							}
			    		}
					});
			    }
			}
			return sum;
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}
	}

	/**
	 * 
	 * 得到单个对象数据
	 * 
	 * @author WANGRENFENG041
	 * @param statementName
	 * @param parameterObject
	 * @return 返回查询结果
	 * @throws DaoException
	 */
	public Object queryForObject(final String statementName,
			final Object parameterObject) throws DaoException {
		try {
			return this.getSqlSession().selectOne(statementName,
					parameterObject);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}
	}

	/**
	 * 得到批量数据
	 * 
	 * @author WANGRENFENG041
	 * @param statementName
	 * @param parameterObject
	 * @return 返回查询结果集合
	 * @throws DaoException
	 */
	public List queryForList(final String statementName,
			final Object parameterObject) throws DaoException {
		try {
			return this.getSqlSession().selectList(statementName,
					parameterObject);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}

	}

	/**
	 * 查询总数
	 * 
	 * @author WANGRENFENG041
	 * @param statementName
	 * @param parameterObject
	 * @return 返回查询记录数
	 * @throws DaoException
	 */
	public long queryForCount(final String statementName,
			final Object parameterObject) throws DaoException {
		try {
			return (Long) this.getSqlSession().selectOne(statementName,
					parameterObject);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}

	}

	/**
	 * 插入数据
	 * 
	 * @author WANGRENFENG041
	 * @param statementName
	 * @param parameterObject
	 * @return 返回插入记录
	 * @throws
	 */
	public Object insert(final String statementName,
			final Object parameterObject) throws DaoException {
		try {
			return this.getSqlSession().insert(statementName, parameterObject);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}
	}

	/**
	 * 批量插入数据
	 * 
	 * @author WANGRENFENG041
	 * @param statementName
	 * @param list
	 *            返回插入失败记录集合,为空表示全部成功处理
	 * @return
	 * @throws
	 */
	public Object batchInsert(final String statementName, final List list)
			throws DaoException {
		int sum = 0;
		try {
			if(null != list && list.size() >0){
				int startIndex = 0;
				int endIndex = 0;
				List subList = null;
			    while(list.size()>=endIndex){
			    	if(list.size()-endIndex > INSERT_BATCH_SIZE_MAX_NUM){
			    		endIndex = endIndex + INSERT_BATCH_SIZE_MAX_NUM;
			    		subList = list.subList(startIndex, endIndex);
			    		startIndex = startIndex + INSERT_BATCH_SIZE_MAX_NUM;
			    	}else{
			    		endIndex = list.size();
			    		subList = list.subList(startIndex, endIndex);
			    		endIndex++;
			    	}
			    	final List tempList = subList;
			    	sum = sum + transactionTemplate.execute(new TransactionCallback<Integer>() {
			    		public Integer doInTransaction(TransactionStatus transactionstatus) {
			    			try{
			    				int size = 0;
				    			for(int indx = 0;indx<tempList.size();indx++){
				    				size = size + getSqlSession().insert(statementName,tempList.get(indx));
				    			}
				    			return new Integer(size);
							}catch(Exception ex){
								transactionstatus.setRollbackOnly();
								throw new DaoException(ex);
							}
			    		}
					});
			    }
			}
			return sum;
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}
	}

	/**
	 * 更新数据
	 * 
	 * @author WANGRENFENG041
	 * @param statementName
	 * @param parameterObject
	 * @return 返回更新记录数
	 * @throws
	 */
	public int update(final String statementName,
			final Object parameterObject) throws DaoException {
		try {
			return this.getSqlSession().update(statementName, parameterObject);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}
	}

	/**
	 * 批量更新
	 * 
	 * @author WANGRENFENG041
	 * @param statementName
	 * @param list
	 * @return 返回更新失败的记录集合,为空表示全部成功处理
	 * @throws
	 */
	public Object batchUpdate(final String statementName, final List list)
			throws DaoException {
		int sum = 0;
		try {
			if(null != list && list.size() >0){
				int startIndex = 0;
				int endIndex = 0;
				List subList = null;
			    while(list.size()>=endIndex){
			    	if(list.size()-endIndex > UPDATE_BATCH_SIZE_MAX_NUM){
			    		endIndex = endIndex + UPDATE_BATCH_SIZE_MAX_NUM;
			    		subList = list.subList(startIndex, endIndex);
			    		startIndex = startIndex + UPDATE_BATCH_SIZE_MAX_NUM;
			    	}else{
			    		endIndex = list.size();
			    		subList = list.subList(startIndex, endIndex);
			    		endIndex++;
			    	}
			    	final List tempList = subList;
			    	sum = sum + transactionTemplate.execute(new TransactionCallback<Integer>() {
			    		public Integer doInTransaction(TransactionStatus transactionstatus) {
			    			try{
			    				int size = 0;
				    			for(int indx = 0;indx<tempList.size();indx++){
				    				size = size + getSqlSession().update(statementName,tempList.get(indx));
				    			}
				    			return new Integer(size);
							}catch(Exception ex){
								transactionstatus.setRollbackOnly();
								throw new DaoException(ex);
							}
			    		}
					});
			    }
			}
			return sum;
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}
	}

	/**
	 * 分页查询
	 * 
	 * @param statementName
	 * @param parameterObject
	 * @param rowBounds
	 * @return
	 * @throws DaoException
	 */
	public PageInfo queryForListByPage(String statementName,
			Object parameterObject, final int pageNum, final int pageSize)
			throws DaoException {
		try {
			RowBounds rowBounds = new RowBounds(pageNum, pageSize);
			Page page = (Page) this.getSqlSession().selectList(statementName,
					parameterObject, rowBounds);
			PageInfo pageInfo = new PageInfo(page);
			return pageInfo;
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}

	}

	/**
	 * 调用存储过程
	 * @author wangrenfeng041
	 * @param statementName
	 * @param parameterObject
	 * @return 调用存储过程状态
	 * @throws DaoException
	 */
	public void callProc(String statementName, Object parameterObject)
			throws DaoException {
		try {
			this.getSqlSession().selectOne(statementName, parameterObject);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}
	}

	public Connection getConnection() throws DaoException {
		/*Connection connection = null;
		try {
			SqlSessionTemplate sqlSessionTemplate = (SqlSessionTemplate) this
					.getSqlSession();
			
			System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%ExecutorType:"+sqlSessionTemplate.getExecutorType().toString());
			System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%getSqlSessionFactory:"+sqlSessionTemplate.getSqlSessionFactory().toString());
			System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%getPersistenceExceptionTranslator:"+sqlSessionTemplate.getPersistenceExceptionTranslator().toString());
			System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%sqlSessionId:"+sqlSessionTemplate.hashCode());

			connection = SqlSessionUtils.getSqlSession(
					sqlSessionTemplate.getSqlSessionFactory(),
					sqlSessionTemplate.getExecutorType(),
					sqlSessionTemplate.getPersistenceExceptionTranslator())
					.getConnection();
			//SqlSessionUtils.closeSqlSession(sqlSessionTemplate, sqlSessionTemplate.getSqlSessionFactory());
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		} 
		return connection;*/
		Connection connection = null;
		try {
			connection = this.getSqlSession().getConfiguration().getEnvironment().getDataSource().getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return connection;
		/*Connection connection = null;
		try {
			connection = this.getSqlSession().getConnection();
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}
		return connection;*/
	}
	
	/**
	 * 执行事务操作，该操作只能支持同一库操作，不支持分布式事务
	 * @param transactionCallback
	 * @return
	 * @throws DaoException
	 */
	public Object executeInTransaction(
			TransactionCallback<Object> transactionCallback)
			throws DaoException {
		try {
			Object object = transactionTemplate.execute(transactionCallback);
			return object;
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new DaoException(ex);
		}
	}
}
