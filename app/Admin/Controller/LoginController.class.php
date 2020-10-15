<?php
namespace Admin\Controller;

class LoginController extends BackendController{ 
    public function index(){  
        if (IS_AJAX) {
            //登陆处理
            $name = I('post.name');
            $pass = I('post.password');
            $remember_me=I('post.remember_me');
            
            //锁定次数
            $lock_key = $name.'_lock';
            $lock = S($lock_key);
            $lock = $lock ? $lock : 0;

            /*if($lock > 4){
                $this->ajaxResponse('1','账户已锁定，请一分钟后重试');
            }*/

            if(empty($name) || empty($pass)){
                S($lock_key, $lock+1, ['expire'=>60]);
                $this->writeSysLog(18, "用户名或密码输入错误", $name);
                $this->ajaxResponse('1','用户名或密码输入错误');
            }
            //  验证码   
            if(!$this->check($_REQUEST['verify'])){
                S($lock_key, $lock+1, ['expire'=>60]);
                $this->writeSysLog(18, "验证码输入错误", $name);
                $this->ajaxResponse('1','验证码输入错误');
            }   

            //登陆验证
            if (!checkUsernameFormat($name)) {
                S($lock_key, $lock+1, ['expire'=>60]);
                $this->writeSysLog(18, "异常登录，非法用户名", $name);
                $this->ajaxResponse('1','异常登录，非法用户名');
            }

            $userinfo = D('Sysusers')->login($name, $pass, $remember_me);

            if($userinfo ==1){
                S($lock_key, $lock+1, ['expire'=>60]);
                $this->writeSysLog(18, "对不起，您登陆的IP不在允许的范围内", $name); 
                $this->ajaxResponse('1','对不起，您登陆的IP不在允许的范围内'); 
            }
            
            if(!$userinfo){
                S($lock_key, $lock+1, ['expire'=>60]);
                $this->writeSysLog(18, "异常登录，用户名或密码错误", $name);
                $this->ajaxResponse('1','异常登录，用户名或密码错误'); 
            } 
            
            S($lock_key, NULL);
            $url = $_SERVER["HTTP_REFERER"] ? $_SERVER["HTTP_REFERER"] : U('Index/index');

            $this->ajaxResponse('0','登录成功', ['url'=>$url]);

        }   
        $this->assign('user_name',cookie('uname'));
        $this->assign('user_pwd',cookie('upwd')); 
        $this->display('index');
    }

    /**
     * 验证码
     * @return [type] [description]
     */
    public function verify(){
        $config =    array(
            'fontSize'    =>    16,    // 验证码字体大小
            'length'      =>    4,     // 验证码位数
            'useNoise'    =>    false, // 关闭验证码杂点
            'imageW'      =>    120,    //验证码宽度
            'imageH'      =>    40,    //验证码高度
            'useCurve'    =>    false,  //关闭混淆曲线
        );
        ob_clean();
        $Verify = new \Think\Verify($config);
        $Verify->entry();
    }
    
    private function check($code, $id = ''){
        $verify = new \Think\Verify();    
        return $verify->check($code, $id);
    }

    private function writeSysLog($model, $logdes, $uname = '')
    {
        $roleid = M('sys_users')->where(['uname'=>$uname])->getField('rid');
        $set = array(
            'model'      => $model,
            'logdes'     => $logdes,
            'logcmd'     => '',
            'uid'         => 0,
            'urid'        => $roleid ? $roleid : 0,
            'uname'        => $uname,
            'ulogipv4'     => sprintf("%u", ip2long(getonlineip())),
            'add_time'    => time()
        );

        M('sys_log')->add($set);
    }  
}