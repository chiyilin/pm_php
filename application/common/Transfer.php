<?php
/**
 * @php 根据用户 openid 提现
 *
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/9/25
 * Time: 15:40
 */

namespace app\common;
header("content-type:text/html;charset=utf-8");
use think\Controller;
use think\Config;

class Transfer extends Controller
{

    function transfer($openid,$money,$desc='陈氏梅花针'){
        $cert=ROOT_PATH.'/weixinpay/cert/apiclient_cert.pem';
        $key=ROOT_PATH.'/weixinpay/cert/apiclient_key.pem';
        $config=Config::get('miniapp');
        $webdata = array(
            'mch_appid' => $config['AppID'],//wx小程序的appid
            'mchid'     => $config['MchID'],//wx商户平台商户号
            'nonce_str' => md5(time()),//随机字符串
            'partner_trade_no'=> date('YmdHis'), //商户订单号，需要唯一
            'openid' => $openid,//转账用户的openid
            'check_name'=> 'NO_CHECK', //OPTION_CHECK不强制校验真实姓名, FORCE_CHECK：强制 NO_CHECK：
            'amount' => $money*100, //付款金额单位为分
            'desc'   => $desc,//企业付款描述信息
            'spbill_create_ip' => request()->ip(),//获取IP
        );
        foreach ($webdata as $k => $v) {
            $tarr[] =$k.'='.$v;
        }
        sort($tarr);
        $sign = implode($tarr, '&');
        $sign .= '&key='.$config['MchKey'];//wx商户平台商户密钥
        $webdata['sign']=strtoupper(md5($sign));
        $wget = $this->ArrToXML($webdata);//数组转XML
        $pay_url = 'https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers';//api地址
        $res = $this->postData($pay_url,$wget,$cert,$key);//发送数据
        if(!$res){
            return array('status'=>1, 'msg'=>"Can't connect the server" );
        }
        $content = simplexml_load_string($res, 'SimpleXMLElement', LIBXML_NOCDATA);
//        dump($content);die();
        if(strval($content->return_code) == 'FAIL'){
            return array('status'=>1, 'msg'=>strval($content->return_msg));
        }
        if(strval($content->result_code) == 'FAIL'){
            return array('status'=>1, 'msg'=>strval($content->err_code).':'.strval($content->err_code_des));
        }
        // $rdata = array(
        //     'mch_appid'        => strval($content->mch_appid),
        //     'mchid'            => strval($content->mchid),
        //     'device_info'      => strval($content->device_info),
        //     'nonce_str'        => strval($content->nonce_str),
        //     'result_code'      => strval($content->result_code),
        //     'partner_trade_no' => strval($content->partner_trade_no),
        //     'payment_no'       => strval($content->payment_no),
        //     'payment_time'     => strval($content->payment_time),
        // );
        // return $rdata;
        return array('status'=>2,'msg'=>'success');
    }

    //发送数据
    function postData($url,$postfields,$certurl,$keyurl){
        $ch = curl_init();
        $params[CURLOPT_URL] = $url;    //请求url地址
        $params[CURLOPT_HEADER] = false; //是否返回响应头信息
        $params[CURLOPT_RETURNTRANSFER] = true; //是否将结果返回
        $params[CURLOPT_FOLLOWLOCATION] = true; //是否重定向
        $params[CURLOPT_POST] = true;
        $params[CURLOPT_POSTFIELDS] = $postfields;
        $params[CURLOPT_SSL_VERIFYPEER] = false;
        $params[CURLOPT_SSL_VERIFYHOST] = false;
        //以下是证书相关代码
        $params[CURLOPT_SSLCERTTYPE] = 'PEM';
//        $params[CURLOPT_SSLCERT] = getcwd().'/plugins/payment/weixin/cert/apiclient_cert.pem';//绝对路径
        $params[CURLOPT_SSLCERT] = $certurl;//绝对路径
        $params[CURLOPT_SSLKEYTYPE] = 'PEM';
//        $params[CURLOPT_SSLKEY] = getcwd().'/plugins/payment/weixin/cert/apiclient_key.pem';//绝对路径
        $params[CURLOPT_SSLKEY] = $keyurl;//绝对路径
        curl_setopt_array($ch, $params); //传入curl参数
        $content = curl_exec($ch); //执行
        curl_close($ch); //关闭连接
        return $content;
    }
    public function ArrToXML($arr){
        if(!is_array($arr) || count($arr) == 0){
            return '';
        }
        $xml="<xml>";
        foreach ($arr as $key=>$val){
            if (is_numeric($val)){
                $xml.="<".$key.">".$val."</".$key.">";
            }else{
                $xml.="<".$key."><![CDATA[".$val."]]></".$key.">";
            }
        }
        $xml.="</xml>";
        return $xml;
    }


}