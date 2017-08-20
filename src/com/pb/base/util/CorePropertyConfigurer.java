package com.pb.base.util;

import java.util.Map.Entry;
import java.util.Properties;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.util.PropertyPlaceholderHelper;

/**
 * 开放定制PropertyPlaceholderConfigurer
 * @author WANGHUI338
 *
 */
public class CorePropertyConfigurer extends PropertyPlaceholderConfigurer{

	//全局属性
	private Properties properties = new Properties();
	
	@Override
	protected void processProperties(  
            ConfigurableListableBeanFactory beanFactoryToProcess,  
            Properties props) throws BeansException {  
        //缓存属性
        PropertyPlaceholderHelper helper = new PropertyPlaceholderHelper(  
                DEFAULT_PLACEHOLDER_PREFIX, DEFAULT_PLACEHOLDER_SUFFIX, DEFAULT_VALUE_SEPARATOR, false);  
        for(Entry<Object, Object> entry:props.entrySet()){  
            String stringKey = String.valueOf(entry.getKey());  
            String stringValue = String.valueOf(entry.getValue());  
            stringValue = helper.replacePlaceholders(stringValue, props);  
            properties.put(stringKey, stringValue);  
        }  
        super.processProperties(beanFactoryToProcess, props);  
    }  
      
    public Properties getProperties() {  
        return properties;  
    }  
      
    public String getProperty(String key){  
        return properties.getProperty(key);  
    }  
	
}
