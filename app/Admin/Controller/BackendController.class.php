<?php
namespace Admin\Controller;

use Think\Controller;

class BackendController extends Controller{
	// 设备名称
	public $product_name = '';
	// 设备型号
	public $product_model = '';
	// 产品序列号
    public $serial = '';
    // 当前版本
    public $version = '';
    // 更新时间
    public $upgrade_time = '';
	// 权限菜单
	// protected $_auth_menu = array(); 
	public function __construct(){
	    parent::__construct();
	    $this->serial = FW('license', '', ROOT_PATH . '/etc/');
		$this->version = FW('version', '', ROOT_PATH . '/etc/');
		$this->upgrade_time = FW('update', '', ROOT_PATH . '/etc/');
		$this->product_name = FW('product_name', '', ROOT_PATH . '/etc/');
		$this->product_model = FW('product_model', '', ROOT_PATH . '/etc/');
		$this->assign('product_name', $this->product_name);
		$this->assign('version', $this->version);
		if(MODULE_NAME == 'Admin' && CONTROLLER_NAME != 'Login'){
			//授权验证
	    	// \Think\Hook::listen('action_auth');
		}
		//登录验证
	    $this->checkUserLogin();
	    //权限验证
	    $this->checkAuth();
	    $this->leftMenu();
	}

	//验证用户是否登陆
	protected function checkUserLogin() {
		//不需要验证登录
		$handler = CONTROLLER_NAME.'/'.ACTION_NAME;
		$no_login = ['Index/homePage', 'Resource/createDomainIpTables', 'Resource/deleteDomainIpTables', 'Safe/record'];
		if(in_array($handler, $no_login)){
			return true;
		}
		$admin = session('admin_id');
		$islogin = 0;
		$session_option =  C('SESSION_OPTIONS');
		if(empty($admin)){
			//cookie登录
			if (cookie('user_auth')) {
				list($username, $password) = explode(':', (new \Think\Crypt())->decrypt(cookie('user_auth'), 'appbeian'));
				$userinfo = M('sys_users')->where(['uname'=>$username, 'upwd'=>$password])->find();
				if($userinfo){
					$userinfo['rules'] = M('sys_auth')->where(['id'=>$userinfo['rid']])->getField('rules');
					session('admin_id', $userinfo['uid']);
					session('admin_rid', $userinfo['rid']);
		            session('admin_name', $userinfo['uname']);
		            session('admin_rules', $userinfo['rules']);
		            session('lastlogintime', $userinfo['lastlogintime']);
            		session('lastloginip', $userinfo['lastloginip']);
            		session('login_start_time', time());
            		$islogin = 1;
				}
			}
		}
		//手动设置session有效期
		elseif((time() - session('login_start_time')) > $session_option['expire']){
			session_destroy();
		}
		else{
			$islogin = 1;
		}
		//已登录
		if($islogin){
			if(CONTROLLER_NAME == 'Login' && ACTION_NAME == 'index'){
				$login_url = U('Login/index');
				$url = ($_SERVER["HTTP_REFERER"] && strpos($login_url, $_SERVER['HTTP_REFERER'])) ? $_SERVER["HTTP_REFERER"] : 'Index/index';

				$this->redirect($url);
			}
		}
		else{
			if(CONTROLLER_NAME != 'Login'){
				$this->redirect('Admin/Login/index');
			}
		}
	}

	/**
	 * 权限判断
	 */
	protected function checkAuth(){
		$uri = CONTROLLER_NAME . '/' .ACTION_NAME;
		$auth = new \Think\Auth;
		//不需要权限判断的页面
		$withoutAuth = ['Login/verify', 'Login/index', 'Login/exitLogin', 'Index/index', 'Index/homePage', 'Resource/createDomainIpTables', 'Resource/deleteDomainIpTables', 'Safe/record'];
		if(session('admin_rules') != 'all' && !in_array($uri, $withoutAuth) && !$auth->check($uri, session('admin_id'))){
			$this->error('您无权限访问此页面');
		}
	}

	/**
	 *左侧菜单
	 */
	protected function leftMenu(){
        $all_menu = F('authMenu');
		if(!$all_menu){
			$all_menu = $this->getSubMenu();
			if($all_menu){
				F('authMenu', $all_menu);
			}
		}
		$auth = new \Think\Auth;
        //菜单显示 
        if(session('admin_rules') != 'all'){
        	foreach ($all_menu as $key => $value) {
        		$count = 0;
	            if(isset($value['sub']) && !empty($value['sub'])){
	                foreach ($value['sub'] as $kk => $vv) {
	 					//验证权限 
	                    if(!$auth->check($vv['name'], session('admin_id'))){
	                        unset($all_menu[$key]['sub'][$kk]);
	                        $count ++;
	                    }
	                }
	            }
	            if($count == count($value['sub'])){
	            	unset($all_menu[$key]);
	            }
	        }
        }
        
        $this->assign('admin_name', session('admin_name'));
        $this->assign('menu', $all_menu);
	}

	/**
     * 退出登录
     */
    public function exitLogin(){
        session('admin_id', null);
		session('admin_rid', null);
        session('admin_name', null);
        session('admin_rules', null);
        session('lastlogintime', null);
		session('lastloginip', null);
		session('login_start_time', null);
        cookie('user_auth', null);

        $this->redirect('Admin/Login/index');
    }

    /**
	 * ajax响应
	 * @param  integer $code [description]
	 * @param  string  $msg  [description]
	 * @param  array   $data [description]
	 * @return [type]        [description]
	 */
	protected function ajaxResponse($code = 0, $msg = '', $data = []){
		$response = ['code'=>0, 'msg'=>'', 'data'=>[]];

		if($code) $response['code'] = $code;

		if($msg) $response['msg'] = $msg;

		if($data) $response['data'] = $data;

		$this->ajaxReturn($response);
	}

	/**
	 * 递归实现子类
	 */
	protected  function getSubMenu($pid = 0, $condition = []){
		$field = 'id,pid,name,title,icon,create_time,status,sort';
        $where['pid'] = $pid;
        $where = $condition ? array_merge($where, $condition) : $where;

        $data = M('auth_rule')->field($field)->where($where)->order('sort')->select();

        if (!empty($data)) {
            foreach ($data as $key => $val) {
            	$data[$key]['sub'] = $this->getSubMenu($val['id'], $condition);
            }
        }
        return $data;
    }

	
}