alias Open_Proxy='export https_proxy=http://127.0.0.1:6152;
							 		export http_proxy=http://127.0.0.1:6152;
							 		export all_proxy=socks5://127.0.0.1:6153;
							 		git config --global http.proxy ${http_proxy};
							 		git config --global https.proxy ${https_proxy}'


alias Off_Proxy='unset https_proxy; 
								 unset http_proxy; 
								 unset all_proxy; 
								 git config --global --unset http.proxy; 
								 git config --global --unset https.proxy'
