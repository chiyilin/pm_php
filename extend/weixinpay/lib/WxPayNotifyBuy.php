<?php
ini_set('date.timezone', 'Asia/Shanghai');
error_reporting(E_ERROR);

require_once "WxPay.Api.php";
require_once 'WxPay.Notify.php';

use app\common\model\ProdList;
use app\common\model\Homework;
use app\common\model\UserHomework;
use app\common\model\Product;

use app\common\model\ConfigFx;
use app\common\model\UserMessage;
use app\common\model\User;
use app\common\model\UserBill;

use app\common\Curl;


class WxPayNotifyBuy extends WxPayNotify
{
    //查询订单
    public function Queryorder($transaction_id)
    {
        $input = new WxPayOrderQuery();
        $input->SetTransaction_id($transaction_id);
        $result = WxPayApi::orderQuery($input);
        if (array_key_exists("return_code", $result)
            && array_key_exists("result_code", $result)
            && $result["return_code"] == "SUCCESS"
            && $result["result_code"] == "SUCCESS") {
            ProdList::where(['order_number' => $result['out_trade_no']])->update(['is_pay' => 2, 'transaction_id' => $result['transaction_id']]);

            $listInfo = ProdList::where('order_number', $result['out_trade_no'])->find();
            Product::where('product_id', $listInfo['product_id'])->setInc('product_subscribe');

            /**
             * 小程序消息
             */
//            UserBill::create([
//                'user_id'=>$listInfo['user_id'],
//                'product_id'=>$listInfo['product_id']?$listInfo['product_id']:null,
//                'taoc_id'=>$listInfo['taoc_id']?$listInfo['taoc_id']:null,
//                'bill_money'=>$listInfo['pay_money'],
//                'bill_type'=>3,
//                'bill_add_time'=>time(),
//            ]);
            /**
             * 下发作业
             */
            $productIdArr = $data = [];
            if (empty($listInfo['taoc_id'])) {
                $productIdArr = [$listInfo['product_id']];
            } else {
                $TaocanProd = Product::where('taoc_id', $listInfo['taoc_id'])->select();
                $productIdArr = array_column($TaocanProd->toArray(), 'product_id');
            }
            $homeWorkInfo = Homework::where('product_id', 'in', $productIdArr)->select();
            foreach ($homeWorkInfo as $key => $value) {
                $data[$key]['user_id'] = $listInfo['user_id'];
                $data[$key]['homework_id'] = $value['homework_id'];
                $data[$key]['product_id'] = $value['product_id'];
                $data[$key]['taoc_id'] = $listInfo['taoc_id'] ? $listInfo['taoc_id'] : null;
                $data[$key]['homework_status'] = 1;
                $data[$key]['add_time'] = time();
            }
            $UserHomeWork = new UserHomework();
            $UserHomeWork->saveAll($data);

            /**
             * 分销
             */
            Gift($listInfo['user_id'],$listInfo['pay_money']);
            /*$list_id = $listInfo['list_id'];
            $prodListInfo = ProdList::with('user')->find($list_id)->toArray();
            if (empty($prodListInfo['user']['user_fid'])) {
                return true;
            }
            $fidChainArr = array_slice(unserialize($prodListInfo['user']['fid_chain']), -2);
            $fidChainCount = count($fidChainArr);
            $config = ConfigFx::find()->toArray();
            $config['fxs'] = json_decode($config['fxs'], true);
            $messageData = [];
            foreach ($fidChainArr as $key => $value) {
                $temUserInfo = User::find($value);
                if (!empty($temUserInfo)) {
                    $messageData[$key] = [
                        'user_id' => $value,
                        'message_title' => '获得一个红包！',
                        'message_content' => '请及时查看！！',
                        'message_add_time' => time(),
                    ];
                    $temFxData = $config['fxs'][$temUserInfo['fxs_level']];
                    if ($fidChainCount > 1 && $key == 0) {
                        $times = $temFxData['two'];
                    } else {
                        $times = $temFxData['one'];
                    }
                    $timesMoney = $prodListInfo['pay_money'] * $times * 0.01;
                    $basicMoney = ($timesMoney) - rand(0, $timesMoney);
                    if (mt_rand(1, 100) <= $config['probability']) {
                        //获得现金
                        $messageData[$key]['message_type'] = 2;
                        $messageData[$key]['money'] = $basicMoney * $config['money_times'];
                    } else {
                        //获得积分
                        $messageData[$key]['message_type'] = 3;
                        $messageData[$key]['money'] = $basicMoney * $config['integral_times'];
                    }
                }
            }
            if(!empty($messageData)){
                $UserMessage = new UserMessage();
                $UserMessage->saveAll($messageData);
            }*/


            /**
             * 付款成功模板通知
             */

            $userInfo = User::find($listInfo['user_id']);
            $productTableArr = Product::find($listInfo['product_id']);
            $data = [
                'openid' => $userInfo['openid'],
                'template_id' => 'vNZK6PN-OUFUHzmkadXzujtcjZjeIpuLGPiFyFBpJ6Q',
                'form_id' => $listInfo['prepay_id'],
                'keywordArr' => [
                    'keyword1' => ['value' => $listInfo['order_number']],
                    'keyword2' => ['value' => $productTableArr['product_name']],
                    'keyword3' => ['value' => $listInfo['pay_money'] . '元'],
                    'keyword4' => ['value' => '已付款'],
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

        if (!array_key_exists("transaction_id", $data)) {
            $msg = "输入参数不正确";
            return false;
        }
        //查询订单，判断订单真实性
        if (!$this->Queryorder($data["transaction_id"])) {
            $msg = "订单查询失败";
            return false;
        }
        return true;
    }
}


