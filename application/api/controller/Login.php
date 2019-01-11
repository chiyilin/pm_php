<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/9/3
 * Time: 16:07
 */

namespace app\api\controller;


use app\common\Curl;
use app\common\model\Staff;
use app\common\model\User;
use app\common\model\ConfigFx;
use app\common\model\Config as ConfigModel;
use think\Config;
use think\Controller;
use think\Loader;
use app\common\model\Setting;

class Login extends Controller
{
    public function login()
    {
        $config = ConfigModel::limit(1)->field('appid,appsecret')->find();
        $curl = new Curl();
        $url = "https://api.weixin.qq.com/sns/jscode2session?appid=" . $config['appid'] . "&secret=" . $config['appsecret'] . "&js_code=" . input('param.code') . "&grant_type=authorization_code";
//        $url = "https://api.weixin.qq.com/sns/jscode2session?appid=wx1c9d8a9f9886abf5&secret=6c24faa055e4dac50c9b86be3dbfa48f&js_code=" . input('param.code') . "&grant_type=authorization_code";
//        halt($url);
        $getResult = $curl->get($url);
        $resData = json_decode($getResult, true);
        $userInfo = User::where(['openid' => $resData['openid']])->limit(1)->find();
        if (!$userInfo) {
            $userInfo = User::create([
                'openid' => $resData['openid'],
            ]);
        }
        $this->result($userInfo, 200, 'openid-insert');
    }

    /**
     * 新用户注册
     */
    public function register()
    {
        $Setting = Setting::limit(1)->find();
        $param = input('param.');
        $data = [
            'nick_name' => $param['nick_name'],
            'face' => $param['face'],
            'user_sex' => $param['sex'],
            'user_lines' => $Setting['default_lines'],
            'user_add_time' => time(),
        ];
        $result = User::update($data, ['openid' => $param['openid']]);
        $userInfo = User::where(['openid' => $param['openid']])->limit(1)->find();
        $this->result($userInfo, 200, 'success');
    }

    /**
     * 查看是否已经登陆
     */
    public function authCheck()
    {
        $openid = input('param.openid');
        $userInfo = User::with('useraddress,usersmrz')->where('openid', $openid)->find();
        if ($userInfo) {
            $userInfo['member_end_time_str'] = date('Y/m/d H:i:s', $userInfo['member_end_time']);
            $this->result($userInfo, 200, '已经获取用户信息');
        } else {
            $this->result([], 400, '之前没登陆');
        }
    }
}