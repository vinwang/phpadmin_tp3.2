<?php 
/**
 * 获取在线IP
 * @global type $_SGLOBAL
 * @param type $format
 * @return type $string
 */
function getonlineip($format = 0) {
	if (empty($_SGLOBAL['onlineip'])) {
		if (getenv('HTTP_CLIENT_IP') && strcasecmp(getenv('HTTP_CLIENT_IP'), 'unknown')) {
			$onlineip = getenv('HTTP_CLIENT_IP');
		} elseif (getenv('HTTP_X_FORWARDED_FOR') && strcasecmp(getenv('HTTP_X_FORWARDED_FOR'), 'unknown')) {
			$onlineip = getenv('HTTP_X_FORWARDED_FOR');
		} elseif (getenv('REMOTE_ADDR') && strcasecmp(getenv('REMOTE_ADDR'), 'unknown')) {
			$onlineip = getenv('REMOTE_ADDR');
		} elseif (isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] && strcasecmp($_SERVER['REMOTE_ADDR'], 'unknown')) {
			$onlineip = $_SERVER['REMOTE_ADDR'];
		}
		preg_match("/[\d\.]{7,15}/", $onlineip, $onlineipmatches);
		$_SGLOBAL['onlineip'] = $onlineipmatches[0] ? $onlineipmatches[0] : 'unknown';
	}
	if ($format) {
		$ips = explode('.', $_SGLOBAL['onlineip']);
		for ($i = 0; $i < 3; $i++) {
			$ips[$i] = intval($ips[$i]);
		}
		return sprintf('%03d%03d%03d', $ips[0], $ips[1], $ips[2]);
	} else {
		return $_SGLOBAL['onlineip'];
	}
}


/**
 * ajax return
 * @param  integer
 * @param  string
 * @param  array
 * @return [type]
 */
function ajaxResponse($code = 0, $msg = '', $data = []){
	$response = ['code'=>0, 'msg'=>'', 'data'=>[]];

	if($code) $response['code'] = $code;

	if($msg) $response['msg'] = $msg;

	if($data) $response['data'] = $data;

	exit(json_encode($response));
}

/**
 * 快速文件数据读取和保存 针对简单类型数据 字符串、数组
 * @param string $name 缓存名称
 * @param mixed $value 缓存值
 * @param string $path 缓存路径
 * @return mixed
 */
function FW($name, $value='', $path=DATA_PATH) {
    static $_cache  =   array();
    $filename       =   $path . $name;
    if ('' !== $value) {
        if (is_null($value)) {
            // 删除缓存
            if(false !== strpos($name,'*')){
                return false; // TODO 
            }else{
                unset($_cache[$name]);
                return Think\Storage::unlink($filename,'F');
            }
        } else {
            Think\Storage::put($filename,$value,'F');
            // 缓存数据
            $_cache[$name]  =   $value;
            return null;
        }
    }
    // 获取缓存数据
    if (isset($_cache[$name]))
        return $_cache[$name];
    if (Think\Storage::has($filename,'F')){
        $value      =   Think\Storage::read($filename,'F');
        $_cache[$name]  =   $value;
    } else {
        $value          =   false;
    }
    return $value;
}


//产生随机字符
function random($length, $numeric = 0) {
    PHP_VERSION < '4.2.0' ? mt_srand((double)microtime() * 1000000) : mt_srand();
    $seed = base_convert(md5(print_r($_SERVER, 1).microtime()), 16, $numeric ? 10 : 35);
    $seed = $numeric ? (str_replace('0', '', $seed).'012340567890') : ($seed.'zZ'.strtoupper($seed));
    $hash = '';
    $max = strlen($seed) - 1;
    for($i = 0; $i < $length; $i++) {
        $hash .= $seed[mt_rand(0, $max)];
    }
    return $hash;
}

/**
 * 获取isms参数配置
 * @param  [type] $key [description]
 * @return [type]      [description]
 */
function getIsms($key = NULL){
    $conf = F('isms');
    return $conf[$key];
}

//压缩格式
function compressionFormat($compressionFormat, $xml_str){
    if ($compressionFormat == 1)
    {
        if(!is_dir(DATA_PATH  . 'file/xml_zip')) mkdir(DATA_PATH  . 'file/xml_zip', 0777, true);
        $zip = new ZipArchive();
        $zipname = DATA_PATH  . 'file/xml_zip/xml_str'.time().'.zip';
        $res = $zip->open($zipname, ZipArchive::CREATE);

        if ($res === TRUE) {
            $zip->addFromString(time().rand(0,9).'.xml', $xml_str);
            $zip->close();
        } else {
           return  false;
        }

        $xml_str = file_get_contents($zipname);

        @unlink($zipname);
    }

    return $xml_str;
}

//hash格式
function hashFormat($hashAlgorithm, $xml_str){
    if ($hashAlgorithm == 1)
    {
        $xml_hash = md5($xml_str/*, true*/);
    }
    elseif ($hashAlgorithm == 2)
    {
        $xml_hash = sha1($xml_str, true);
    }
    else
    {
        $xml_hash = $xml_str;
    }

    return $xml_hash;
}

// aes加密
function xmlAes($encryptAlgorithm, $encrypt_key, $encrypt_iv, $xml_str)
{
    //加载aes
    if ($encryptAlgorithm == 1)
    {
        $aes = strlen($encrypt_key) == 16 ? 'aes-128-cbc' : 'aes-256-cbc';
        $xml_str = base64_encode(openssl_encrypt($xml_str, $aes, $encrypt_key, true, $encrypt_iv));
    }

    return $xml_str;
}
// aes解密
function xmlDeaes($encryptAlgorithm, $encrypt_key, $encrypt_iv, $xml_str)
{
    //加载aes
    if ($encryptAlgorithm == 1)
    {
        $xml_str = base64_decode($xml_str);
        $aes = strlen($encrypt_key) == 16 ? 'aes-128-cbc' : 'aes-256-cbc';
        $xml_str = openssl_decrypt($xml_str, $aes, $encrypt_key, true, $encrypt_iv);
    }

    return $xml_str;
}

/**
 * 字符串截取，支持中文和其他编码
 * static 
 * access public
 * @param string $str 需要转换的字符串
 * @param string $start 开始位置
 * @param string $length 截取长度
 * @param string $charset 编码格式
 * @param string $suffix 截断显示字符
 * return string
 */
function msubstr($str, $start=0, $length, $charset="utf-8", $suffix=true) {
    if(function_exists("mb_substr"))
        $slice = mb_substr($str, $start, $length, $charset);
    elseif(function_exists('iconv_substr')) {
        $slice = iconv_substr($str,$start,$length,$charset);
        if(false === $slice) {
            $slice = '';
        }
    }else{
        $re['utf-8']   = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|[\xe0-\xef][\x80-\xbf]{2}|[\xf0-\xff][\x80-\xbf]{3}/";
        $re['gb2312'] = "/[\x01-\x7f]|[\xb0-\xf7][\xa0-\xfe]/";
        $re['gbk']    = "/[\x01-\x7f]|[\x81-\xfe][\x40-\xfe]/";
        $re['big5']   = "/[\x01-\x7f]|[\x81-\xfe]([\x40-\x7e]|\xa1-\xfe])/";
        preg_match_all($re[$charset], $str, $match);
        $slice = join("",array_slice($match[0], $start, $length));
    }
    return $suffix ? $slice.'...' : $slice;
}

/**
     * 从du读取日志
     * @param  integer $pageSize   [description]
     * @param  integer $startIndex [description]
     * @param  integer $commandId  [description]
     * @param  integer $houseId    [description]
     * @param  string  $startTime  [description]
     * @param  string  $endTime    [description]
     * @param  string  $srcIp      [description]
     * @param  string  $dstIp      [description]
     * @param  integer $srcPort    [description]
     * @param  integer $dstPort    [description]
     * @param  integer $protocol   [description]
     * @param  string  $xmlUrl     [description]
     * @return [type]              [description]
     */
    function logsFromDu($pageSize = 0, $startIndex = 0, $commandId = 0, $idcId = '', $houseId = 0, $startTime = '', $endTime = '', $srcStartIp = '', $srcEndIp = '', $dstStartIp = '', $dstEndIp = '', $srcPort = 0, $dstPort = 0, $protocol = 0, $xmlUrl = '', $duUrl = ''){
        if(!$commandId || !$duUrl) return false;

        $time = date('Y-m-d H:i:s');
        $startTime = $startTime ?: $time;
        
        $duxml = '<logQuery>';
        $duxml .= '<size>'. $pageSize .'</size>';
        $duxml .= '<startIndex>'. $startIndex .'</startIndex>';
        $duxml .= '<commandId>'. $commandId .'</commandId>';
        $duxml .= '<idcId>'. $idcId .'</idcId>';
        $duxml .= '<commandInfo>';
        $duxml .= '<houseId>'. $houseId .'</houseId>';
        $duxml .= '<startTime>'. $startTime .'</startTime>';
        if($endTime){
            $duxml .= '<endTime>'. $endTime .'</endTime>';    
        }
        if($srcStartIp){
            $duxml .= '<srcIp>';
            $duxml .= '<startIp>'. $srcStartIp .'</startIp>';
            $duxml .= '<endIp>'. $srcEndIp ?: $srcStartIp .'</endIp>';
            $duxml .= '</srcIp>';
        }
        if($dstStartIp){
            $duxml .= '<destIp>';
            $duxml .= '<startIp>'. $dstStartIp .'</startIp>';
            $duxml .= '<endIp>'. $dstEndIp ?: $dstStartIp .'</endIp>';
            $duxml .= '</destIp>';
        }
        if($srcPort){
            $duxml .= '<srcPort>'. $srcPort .'</srcPort>';
        }
        if($dstPort){
            $duxml .= '<destPort>'. $dstPort .'</destPort>';
        }
        if($protocol){
            $duxml .= '<protocolType>'. $protocol .'</protocolType>';
        }
        if($xmlUrl){
            $duxml .= '<url>'. base64_encode($xmlUrl) .'</url>';
        }
        $duxml .= '</commandInfo>';
        $duxml .= '<timeStamp>'. $time .'</timeStamp>';
        $duxml .= '</logQuery>';

        $msg = '暂无数据';
        $list = [];
        try{
            $duxml = base64_encode($duxml);
            $response = (new \Org\Net\Http())->doPost($duUrl, $duxml);
            $data = (array) simplexml_load_string($response);

            if($data['code'] == 0){
                $tmp = (array) simplexml_load_string(base64_decode($data['data']));

                $list['count'] = (int) $tmp['result']->totalLogAmount;
                /*$tmpData = array_map(function($val){
                    return (array) $val;
                }, $tmp['log']);*/
                foreach($tmp['log'] as $key=>$val){
                    $val = (array) $val;
                    $list['data'][$key]['id'] = $val['logId'];
                    if(is_ipv4($val['srcIp'])){
                        $list['data'][$key]['src_ipv4'] = ip2long($val['srcIp']);
                    }
                    else{
                        $list['data'][$key]['src_ipv6'] = ipv62char($val['srcIp']);
                    }
                    if(is_ipv4($val['destIp'])){
                        $list['data'][$key]['dst_ipv4'] = ip2long($val['destIp']);
                    }
                    else{
                        $list['data'][$key]['dst_ipv6'] = ipv62char($val['destIp']);
                    }
                    $list['data'][$key]['src_port'] = $val['srcPort'];
                    $list['data'][$key]['dst_port'] = $val['destPort'];
                    $list['data'][$key]['url'] = base64_decode($val['url']);
                    $list['data'][$key]['protocol'] = intval($val['protocolType']);
                    $list['data'][$key]['add_time'] = strtotime($val['accessTime']);
                }
            }
            else{
                $msg = logsErrcode($data['code']);
            }
        }
        catch(\Think\Exception $e){
            $msg = $e->getMessage();
        }

        return ['list'=>$list, 'msg'=>$msg];
    }

    /**
     * du错误码
     * @return [type] [description]
     */
    function logsErrcode($code = 0){
        $error = [
            0 => '操作成功',
            1 => '服务器解析请求体错误',
            2 => '服务器 Base64 解码错误',
            3 => '服务器解析 XML 格式错误',
            4 => '服务器验证 XML 字段错误',
            5 => '服务器 URL 解码错误',
            6 => '服务器查询数据错误',
            7 => '服务器构建查询语句错误',
            8 => '服务器解析查询数据错误'
        ];

        return isset($error[$code]) ? $error[$code] : '';
    }