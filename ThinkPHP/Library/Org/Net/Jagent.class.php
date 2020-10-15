<?php
namespace Org\Net;

class Jagent
{
    private $_server;
    private $_port;

    public function __construct($options = null)
    {
        if ($options == null)
        {
            $this->_server = "127.0.0.1";
            $this->_port = 80;
        }
        else
        {
            $this->_server = $options['server'];
            $this->_port = $options['port'];
        }
    }

    //设置系统时间
    //TRUE 成功，FALSE 失败
    public function set_time($ts) {
        $ret = FALSE;
        if(empty($ts)){
            return $ret;
        }
        $time = date('Y-m-d H:i:s', $ts);
        $time_file = '/lysrv/cu/web/etc/time.txt';
        $len = file_put_contents($time_file, $time);
        if($len){
            @exec("sh ./etc/set_time.sh", $output, $status);
            if(!$status){
                $ret = TRUE;
            }
        }

        return $ret;
    }

    //Internet时间同步
    //TRUE 成功，FALSE 失败
    public function set_nettime($ntp_server="asia.pool.ntp.org") {
        $ret = FALSE;
        if (empty($ntp_server)) {
            return $ret;
        }
        exec("sudo ntpdate ".$ntp_server, $output, $status);
        if(!$status){
            $ret = TRUE;
        }
        return $ret;
    }

    /**
     * 重写发送指令
     * @param  [type] $commandid   [description]
     * @param  [type] $commandtype [description]
     * @param  [type] $type        [description]
     * @return [type]              [description]
     */
    public function send_command_info($commandid, $commandtype, $type, $service = 0){

        if($service){
            $url = $service;
            $url .= '/index.php?m=Command&c=Commandaction&a=index&commandid='.$commandid.'&commandtype='.$commandtype.'&type='.$type;

            require_once __DIR__ . '/Http.class.php';

            return Http::doGet($url);
        }
        else{
            R('Command/Commandaction/index', ['commandid'=>$commandid, 'commandtype'=>$commandtype, 'type'=>$type]);
        }

        return true;
    }
}
?>
