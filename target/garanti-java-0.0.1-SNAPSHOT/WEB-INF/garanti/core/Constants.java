/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core;

/**
 *
 * @author Codevist
 */
public interface Constants {


	interface StandardHTTPHeaders {

		public static final String ACCEPT = "Accept";
		public static final String CONTENT_TYPE = "Content-Type";

	}

	interface Formats {

		public static final String SHA1 = "SHA1";
		public static final String UTF8 = "UTF-8";

	}

	interface ContentTypes {

		public static final String APPLICATION_XML_UTF8 = "application/xml;charset=UTF-8";
		public static final String APPLICATION_JSON_UTF8 = "application/json;charset=UTF-8";

	}

	interface HTTPMethods {

		public static final String POST = "POST";
		public static final String GET = "GET";

	}

}
