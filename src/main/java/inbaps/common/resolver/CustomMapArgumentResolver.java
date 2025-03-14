package inbaps.common.resolver;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import inbaps.common.common.CommandMap;

public class CustomMapArgumentResolver implements HandlerMethodArgumentResolver {
	@Override
    public boolean supportsParameter(MethodParameter parameter) {
        return CommandMap.class.isAssignableFrom(parameter.getParameterType());
    }
 
    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        CommandMap commandMap = new CommandMap();
         
        HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();
        Enumeration<?> enumeration = request.getParameterNames();
         
        String key = null;
        String[] values = null;
        while(enumeration.hasMoreElements()){
            key = (String) enumeration.nextElement();
            values = request.getParameterValues(key);
            if(values != null){
            	// encode UTF-8 -> decode UTF-8
            	for(int i=0; i<values.length; i++){
                	try {
                		values[i] =  URLDecoder.decode(values[i], "UTF-8");
            		} catch (UnsupportedEncodingException e) {
            			// TODO Auto-generated catch block
            			e.printStackTrace();
            		}
            	}            	
                commandMap.put(key, (values.length > 1) ? values:values[0] );
            }
        }
        return commandMap;
    }
}
