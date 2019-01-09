<?phpini_set('date.timezone', 'Asia/Shanghai');error_reporting(E_ERROR);require_once "WxPay.Api.php";require_once 'WxPay.Notify.php';use app\common\model\ProdList;use app\common\model\Product;use app\common\model\ProdListBetween;use app\common\model\Coupon;use app\common\model\UserGetProd;class WxPayNotifyBuy extends WxPayNotify{    //查询订单    public function Queryorder($transaction_id)    {        $input = new WxPayOrderQuery();        $input->SetTransaction_id($transaction_id);        $result = WxPayApi::orderQuery($input);        if (array_key_exists("return_code", $result)            && array_key_exists("result_code", $result)            && $result["return_code"] == "SUCCESS"            && $result["result_code"] == "SUCCESS") {            //todo 1.更改并获取最新的订单信息。            $time = time();            $ProdList = new ProdList();            $prodListInfo = $ProdList->where([                'list_id' => $result['attach'],                'is_pay' => 1            ])->limit(1)->find();            $prodListInfo->is_pay = 2;            $prodListInfo->transaction_id = $result['transaction_id'];            $prodListInfo->list_pay_time = $time;            $prodListInfo->save();            //todo 2.更改订单中间表的信息。            $ProdListBetween = new ProdListBetween();            $ProdListBetweenInfo = $ProdListBetween->where([                'list_id' => $result['attach'],                'is_pay' => 1            ])->select();            $ProdListBetweenInfo->is_pay = 2;            $ProdListBetweenInfo->transaction_id = $result['transaction_id'];            $ProdListBetweenInfo->pay_time = $time;            $ProdListBetweenInfo->save();            //todo 3.如果用了优惠券付款，则将优惠券状态改为已用。            if (!empty($prodListInfo['coupon_id'])) {                Coupon::where(['coupon_id' => $prodListInfo['coupon_id']])->update(['coupon_status' => 2]);            }            //todo 4.如果是竞拍商品，则将用户得标商品标的状态改为已付款。            $ProdListBetweenInfo->toArray();            //todo END 返回 true ,否则会重复回调。            return true;        }        return false;    }    //重写回调处理函数    public function NotifyProcess($data, &$msg)    {        $notfiyOutput = array();        if (!array_key_exists("transaction_id", $data)) {            $msg = "输入参数不正确";            return false;        }        //查询订单，判断订单真实性        if (!$this->Queryorder($data["transaction_id"])) {            $msg = "订单查询失败";            return false;        }        return true;    }}