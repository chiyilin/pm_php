<?php
ini_set('date.timezone','Asia/Shanghai');
error_reporting(E_ERROR);

require_once "WxPay.Api.php";
require_once 'WxPay.Notify.php';
use app\common\model\User;
use app\common\model\UserRecord;
use app\common\model\MemberPrice;

class WxPayNotifyMember extends WxPayNotify
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
            $res=UserRecord::where(['is_pay'=>1,'order_number'=>$result['out_trade_no']])
                ->update([
                    'is_pay'=>2,
                    'transaction_id'=>$result['transaction_id']
                ]);
            if($res){
                $UserRecordInfo=UserRecord::where(['is_pay'=>2,'order_number'=>$result['out_trade_no']])->find();
//                User::update(['member'=>2,'member_end_time'=>$UserRecordInfo['end_time']],['user_id'=>$UserRecordInfo['user_id']]);
                $Info=MemberPrice::find($UserRecordInfo['member_price_id']);
                User::update(['fxs_level'=>$Info['level']],['user_id'=>$UserRecordInfo['user_id']]);
            }
            /**
             * 分销
             */
            Gift($UserRecordInfo['user_id'],$UserRecordInfo['member_pay_money']);

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


