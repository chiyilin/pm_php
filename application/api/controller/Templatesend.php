<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/10/15
 * Time: 10:25
 */

namespace app\api\controller;

use think\Config;
use think\Controller;
use app\common\model\User;
use app\common\model\Lists;
use app\common\Curl;
use app\common\model\ProdList;
use app\common\model\Product;

class Templatesend extends Controller
{
    /**
     * 查看所有模板消息
     */
    public function temMessage()
    {
        //获取微信接口调用凭证
        $accessToken = action('api/share/getAccessToken');
        $curl = new Curl();
        $url = 'https://api.weixin.qq.com/cgi-bin/wxopen/template/list?access_token=' . $accessToken;
        $data = json_encode([
            'offset' => 0,
            'count' => 20,
        ]);
        $res = $curl->post($url, $data);
        return json_decode($res)->list;
    }

    /**
     * 发送模板消息
     */
    public function send($openid, $template_id, $form_id, $keywordArr, $page = 'pages/index/index')
    {
//        $form_id = input('param.form_id') ? input('param.form_id') : input('param.prepay_id');
        //获取微信接口调用凭证
        $accessToken = action('api/share/getAccessToken');
        $curl = new Curl();
        $url = 'https://api.weixin.qq.com/cgi-bin/message/wxopen/template/send?access_token=' . $accessToken;
//        $data = json_encode([
//            'touser' => 'opUgV0RfEy_keN4JFrJGunIjAZdY',
//            'template_id' => 'pPLjmL51AczmK3ynKmJ2jP5vHbJq-TOYufIOegk1kUQ',
//            'form_id' => 'wx03155849944146e90c6db45d0854267980',
////            'form_id'=>input('param.form_id'),
//            'data' => [
//                'keyword1' => ['value' => 1],
//                'keyword2' => ['value' => 2],
//                'keyword3' => ['value' => 3],
//                'keyword4' => ['value' => 4],
//            ]
//        ]);
        $data = json_encode([
            'touser' => $openid,
            'template_id' => $template_id,
            'form_id' => $form_id,
            'data' => $keywordArr,
            'page' => $page //用户点击模板消息后的跳转页面
        ]);
        return $res = $curl->post($url, $data);

    }

    public function test2()
    {
        $listInfo = ProdList::find(184);
        $userInfo = User::find($listInfo['user_id']);
        $productTableArr = Product::find($listInfo['product_id']);
        $data = [
            'openid' => $userInfo['openid'],
            'template_id' => 'vNZK6PN-OUFUHzmkadXzujtcjZjeIpuLGPiFyFBpJ6Q',
            'form_id' => $listInfo['prepay_id'],
            'keywordArr' => [
                'keyword1' => ['value' => $listInfo['order_number']],
                'keyword2' => ['value' => $productTableArr['product_name']],
                'keyword3' => ['value' => $listInfo['pay_money']],
                'keyword4' => ['value' => '已付款'],
                'keyword5' => ['value' => '备注！'],
            ]
        ];
        $res = action('api/Templatesend/send', $data);
        dump($res);
    }

    /**
     * 获取用户信息
     */
    public function userInfo()
    {
        $user_id = input('param.user_id');
        $userinfo = UserModel::with('useraddress,usersmrz')->where('user_id', $user_id)->find();
        $userinfo['member_end_time_str'] = date('Y/m/d H:i:s', $userinfo['member_end_time']);
        if (empty($userinfo['useraddress'])) {
            $userinfo['useraddress'] = ['sheng' => '北京市', 'shi' => '北京市', 'qu' => '朝阳区', 'addxiang' => '详细地址'];
        }
        if (empty($userinfo['usersmrz'])) {
            $userinfo['usersmrz'] = 0;
        }
        $this->result($userinfo, 200, 'success');
    }
}