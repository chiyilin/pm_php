<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/10/31
 * Time: 10:59
 */

namespace app\api\controller;

use app\common\Curl;

use think\Controller;
use think\Config;
use app\common\model\User;

class Share extends Controller
{
    /**
     * 获取access_token
     * GET https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET
     */
    public function getAccessToken()
    {
        $config = Config::get('miniapp');
        $curl = new Curl();

        $res = $curl->get('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=' . $config["AppID"] . '&secret=' . $config["AppSecret"] . '');
        $resultObj = json_decode($res);
        return $resultObj->access_token;
    }

    /**
     * 生成小程序码
     * POST https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token=ACCESS_TOKEN
     */
    public function getwxacodeunlimit()
    {
        $userInfo = User::find(input('param.user_id'));
        $curl = new Curl();
        $url = "https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token=";
        $url .= $this->getAccessToken();
//        $data = '{"scene": "1"}';
        $data = [
            'scene' => $userInfo['user_id'],
        ];
//        halt();
        $res = $curl->post($url, json_encode($data));
        //dump($res);
        $dir = ROOT_PATH . '/public/uploads/eweima';
        $path = $dir . "/";
//        create_dirs($path, 0777);
//        mkdir(ROOT_PATH.$path);
        $file_name = $userInfo['user_id'] . time() . ".png";
        file_put_contents($path . $file_name, $res);
        $resUrl = getHttpHost() . '/' . 'uploads/eweima/' . $file_name;
        $userInfo->share_image=$resUrl;
        $userInfo->save();
        $this->result(compact('userInfo'), 200, 'success');
    }


}