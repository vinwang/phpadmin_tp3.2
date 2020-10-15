<?php
namespace Admin\Model;

use Think\Model;

class SysusersModel extends Model{
	protected $tableName = 'sys_users';

    /**
     * 登录
     * @param  string  $username [description]
     * @param  string  $password [description]
     * @param  integer $remember [description]
     * @return [type]            [description]
     */
	public function login($username = '', $password = '', $remember = 0){

		// $password = md5('appbeian_'.md5($password));
        $password = md5('appbeian_'.$password);

		$userinfo = $this->where(['uname'=>$username, 'upwd'=>$password])->find();

		if($userinfo){
            $lastloginip = get_client_ip(1);
            if($userinfo['allowips'] || $userinfo['allowipv6']){
            
                $ipv4 = unserialize($userinfo['allowips']);
                $ipv6 = unserialize($userinfo['allowipv6']);
                if($ipv4){
                    if(!in_array(long2ip($lastloginip),$ipv4)) return 1;
                }
                if($ipv6){
                    if(!in_array(long2ip($lastloginip),$ipv6)) return 1;
                }

            } 
            $lastlogintime = time();

            $this->where(array('uname'=>$username))->save(array('loginfail'=>0,'lastlogintime'=>$lastlogintime,'lastloginip'=>$lastloginip));
            //用户组权限
            $userinfo['rules'] = M('sys_auth')->where(['id'=>$userinfo['rid']])->getField('rules');
            
            session('admin_id', $userinfo['uid']);
            session('admin_rid', $userinfo['rid']);
            session('admin_name', $userinfo['uname']);
            session('admin_rules', $userinfo['rules']);
            session('lastlogintime', $userinfo['lastlogintime']);
            session('lastloginip', $userinfo['lastloginip']);
            session('login_start_time', time());
            writeAppLog(1, "登录系统管理界面"); 

            //记住密码
            if(intval($remember) == 1){
                $user_auth_str = $username.':'.$password;
                $user_auth = (new \Think\Crypt())->encrypt($user_auth_str, 'appbeian');
                //7天有效期
                cookie('user_auth', $user_auth, 7*24*3600);
            }

            return $userinfo;
		}

		return false;
	}
	
}