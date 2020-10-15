<?php
namespace Admin\Behaviors;

class authBehavior extends \Think\Behavior {

    public function run(&$param){
    	$result = $this->getDataFromServer();

    	if($result['code']) die($result['msg']);
    }

    //模拟前台请求服务器api接口
   private function getDataFromServer(){
        $serial = FW('license', '', ROOT_PATH . '/etc/');
       
        $mac = $this->GetMacAddr(PHP_OS);
        
        $data = [
            'code'=>$serial, 
            'mac'=>$mac,
            'p' => 'idc'
        ];
        
        $url = 'http://101.251.68.215:12310/index.php?m=admin&c=doauth';

        $rs = \Org\Net\Http::doPost($url, $data);
        
        $result = json_decode($rs, true);
        
        return $result;
    }

    /*
     * 获取MAC地址 begin
     * 
     */
    private function GetMacAddr($os_type) {

        switch ($os_type) { 
            case "solaris":
                break;
            case "unix":
                break;
            case "aix":
                break;
            default:
                $return_array = $this->forLinux();
            break;
        }
        $temp_array = array();
        foreach ($return_array as $value) {
            if (preg_match("/[0-9a-f][0-9a-f][:-]" . "[0-9a-f][0-9a-f][:-]" . "[0-9a-f][0-9a-f][:-]" . "[0-9a-f][0-9a-f][:-]" . "[0-9a-f][0-9a-f][:-]" . "[0-9a-f][0-9a-f]/i", $value, $temp_array)) {
                $mac_addr = $temp_array[0];
                break;
            }
        }
        unset($temp_array);
        return $mac_addr;
    } 

    private function forLinux() {
        @exec("sudo ifconfig -a", $return_array);
        return $return_array;
    }
}
