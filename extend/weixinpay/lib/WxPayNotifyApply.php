<?php
ini_set('date.timezone','Asia/Shanghai');
error_reporting(E_ERROR);

require_once "WxPay.Api.php";
require_once 'WxPay.Notify.php';
use app\common\model\Lists;
use app\common\model\UserBill;
use app\common\model\User;
use app\common\model\Baokao;

class WxPayNotifyApply extends WxPayNotify
{
    //查询订单
    public function Queryorder($transaction_id)
    {
        $input = new WxPayOrderQuery();
        $input->SetTransaction_id($transaction_id);
        $result = WxPayApi::orderQuery($input);
        if(array_key_exists("return_code", $result)
            && array_key_exists("result_code", $result)
            && $result["return_code"] == "SUCCESS"
            && $result["result_code"] == "SUCCESS")
        {

            $res=Lists::where(['is_pay'=>1,'order_number'=>$result['out_trade_no']])
                ->update([
                    'is_pay'=>2,
                    'transaction_id'=>$result['transaction_id']
                ]);

            $listInfo=Lists::where(['order_number'=>$result['out_trade_no']])->find();
            Baokao::where('baokao_id',$listInfo['baokao_id'])->setInc('member_num');
            /**
             * 小程序消息
             */
//            UserBill::create([
//                'user_id'=>$listInfo['user_id'],
//                'baokao_id'=>$listInfo['baokao_id'],
//                'bill_money'=>$listInfo['pay_money'],
//                'bill_type'=>3,
//                'bill_add_time'=>time(),
//            ]);
            /**
             * 分销
             */
//            Gift($listInfo['user_id'],$listInfo['pay_money']);
            /**
             * 模板消息
             */

            $userInfo = User::with('usersmrz')->find($listInfo['user_id']);
            $BaokaoInfo=Baokao::find($listInfo['baokao_id']);
            $data = [
                'openid' => $userInfo['openid'],
                'template_id' => 'wYipb6O-ifJ5Y1UKTo6X6RCzPlau1PcKJJz8ORO6OPU',
                'form_id' => $listInfo['prepay_id'],
                'keywordArr' => [
                    'keyword1' => ['value' => $BaokaoInfo['baokao_name']],
                    'keyword2' => ['value' => date('Y-m-d H:i',$BaokaoInfo['baokao_start_time']).'至'.date('Y-m-d H:i',$BaokaoInfo['baokao_end_time'])],
                    'keyword3' => ['value' => $userInfo['usersmrz']['smrz_name']],
                    'keyword4' => ['value' => $userInfo['usersmrz']['smrz_mobile']],
                    'keyword5' => ['value' => '备注！'],
                ]
            ];
            action('api/Templatesend/send', $data);

            return true;
        }
        return false;
    }


    //重写回调处理函数
    public function NotifyProcess($data, &$msg)
    {
        $notfiyOutput = array();

        if(!array_key_exists("transaction_id", $data)){
            $msg = "输入参数不正确";
            return false;
        }
        //查询订单，判断订单真实性
        if(!$this->Queryorder($data["transaction_id"])){
            $msg = "订单查询失败";
            return false;
        }
        return true;
    }
}


