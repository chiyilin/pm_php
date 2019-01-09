<?php
/**
 * 快递100物流查询类
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2019/1/8
 * Time: 14:50
 * 1、管理后台地址：https://www.kuaidi100.com/user/     账号：dajitianxia 密码：dajitianxia2019
 *
 * 2、订阅推送接口
 *
 * Key：HqoIXdJK8609
 *
 * 3、实时查询接口
 *
 * （1）key：HqoIXdJK8609
 *
 * （2）customer：E78A2D80047B3FD188F365DCF215DDA2
 *
 * 4、智能判断接口
 *
 * key：HqoIXdJK8609
 *
 * 5、电子面单接口
 *
 * （1）key：HqoIXdJK8609
 *
 * （2）secret：2c85205c0d39440dbfa4c26abc126513
 *
 * 6、云打印接口
 *
 * Key：HqoIXdJK8609
 */

use app\common\Curl;
use app\common\model\KdSetting;

class Kd100
{
    private $Curl;
    #快递单号
    private $num;
    private $key;
    private $customer;
    private $secret;

    public function __construct()
    {
        $this->Curl = new Curl();
        $setting = KdSetting::limit(1)->find();
        $this->key = $setting['key'];
        $this->customer = $setting['customer'];
        $this->secret = $setting['secret'];
    }

    private function getComCode()
    {
        $url = "http://www.kuaidi100.com/autonumber/auto?num=" . $this->num . "&key=" . $this->key;
        $result = $this->Curl->get($url);
        $resultArr = json_decode($result, true);
        $comCodeArr = array_column($resultArr, 'comCode');
        return $comCodeArr;
    }

    public function getOrderTracesByJson($num)
    {
        $this->num = $num;
        //参数设置
        $post_data = [];
        $post_data["customer"] = $this->customer;
        $key = $this->key;
        $url = "https://poll.kuaidi100.com/poll/query.do";
        //循环可能的快递公司
        foreach ($this->getComCode() as $value) {
            $post_data["param"] = json_encode([
                "com" => $value,
                "num" => $this->num,
            ]);
            $post_data["sign"] = md5($post_data["param"] . $key . $post_data["customer"]);
            $post_data["sign"] = strtoupper($post_data["sign"]);
            $o = "";
            foreach ($post_data as $k => $v) {
                $o .= "$k=" . urlencode($v) . "&";        //默认UTF-8编码格式
            }
            $post_data = substr($o, 0, -1);
            $result = $this->Curl->post($url, $post_data);
            $resultArr = json_decode($result, true);
            if ($resultArr['message'] == 'ok') {
                return $result;
                break;
            }
        }
    }
}