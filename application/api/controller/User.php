<?php

namespace app\api\controller;

use think\Config;
use think\Controller;
use app\common\model\ProdList;
use app\common\model\User as UserModel;
use app\common\model\UserSmrz as UserSmrzModel;
use app\common\model\UserAddress;
use app\common\model\UserCollection;
use app\common\model\Product;
use app\common\model\UserDeposit;
use app\common\model\UserBill;
use app\common\model\ProdListComment;
use app\common\model\UserMessage;
use app\common\model\ConfigFx;
use app\common\model\State;
use app\common\model\UserGetProd;

use think\Request;

class User extends Controller
{
    /**
     * 个人中心首页
     */
    public function mine(Request $request)
    {
        $param = $request->param();
        $user_id = $param['user_id'];
        $userinfo = UserModel::where('user_id', $user_id)->find();
        $myProdInfo = [
            //代付款（已得标未付款）
            'countGetProd' => UserGetProd::where(['user_id' => $user_id, 'is_pay' => 1])->count(),
            //已经支付的订单
            'countExpressProd' => ProdList::where(['user_id' => $user_id, 'is_pay' => 2])->count(),
            //待收货订单
            'countConfirmProd' => ProdList::where(['user_id' => $user_id, 'is_pay' => 3])->count(),
        ];
        $this->result(compact('userinfo', 'myProdInfo'), 200, 'success');
    }

    /**
     * 获取用户信息
     */
    public function userInfo()
    {
        $user_id = input('param.user_id');
        $userinfo = UserModel::where('user_id', $user_id)->find();
        $this->result($userinfo, 200, 'success');
    }

    /**
     *  分销规则、权益说明
     */
    public function state()
    {
        $data = State::find(input('param.id'));
        $this->result($data, 200, 'success');
    }

    /**
     * 个人中心首页
     */
    /*    public function mine()
        {
    //        halt(input('param.user_id'));
            $config = Config::get('miniapp')['fxs'];
    //        halt($config);
            $countComment = ProdListComment::where(['list_comment_fid' => input('param.user_id'), 'is_read' => 1])->count();
            $Message = UserMessage::where(['user_id' => input('param.user_id'), 'message_status' => 1])->count();
            $countMessage = $countComment + $Message;
            $this->result(compact('config', 'countMessage'), 200, 'success');
        }*/

    /**
     * 用户修改信息
     */
    public function edit()
    {
        //性别 电话 修改      在user 表内
        $res = UserModel::where('user_id', input('param.user_id'))->update([
            'user_sex' => input('param.user_sex'),
            'user_mobile' => input('param.user_mobile'),
        ]);
        //判断用户是否实名注册        检测实名认证表
        $one = UserSmrzModel::where('user_id', input('param.user_id'))->find();
        if ($one) {
            $resu = UserSmrzModel::where('user_id', input('param.user_id'))->update(['smrz_name' => input('smrz_name')]);
        } else {
            $resu = UserSmrzModel::create([
                'user_id' => input('param.user_id'),
                'smrz_name' => input('param.smrz_name'),
                'smrz_addtime' => time(),
            ]);
        }
        //判断用户是否设置收货地址      检测地址表
        $two = UserAddress::where('userid', input('param.user_id'))->find();
        if ($two) {
            $resul = UserAddress::where('userid', input('param.user_id'))->update([
                'sheng' => input('param.sheng'),
                'shi' => input('param.shi'),
                'qu' => input('param.qu'),
                'addxiang' => input('param.addxiang')
            ]);
        } else {
            $resul = UserAddress::create([
                'userid' => input('param.user_id'),
                'sheng' => input('param.sheng'),
                'shi' => input('param.shi'),
                'qu' => input('param.qu'),
                'addxiang' => input('param.addxiang')
            ]);
        }
        $this->result($resul, 200, 'success');
    }

    /**
     * 我的收藏展示
     */
    public function collection()
    {
//        halt(input('param.'));
        $res = UserCollection::with(['product' => function ($query) {
            $query->field('product_name,product_id,product_cover,product_money,cover_introduce,product_zysx');
        }])->where('user_id', input('user_id'))
            ->field('collection_id,product_id')
            ->limit((input('param.limit/a')[0] - 1) * input('param.limit/a')[1], input('param.limit/a')[1])
            ->select();
        $this->result($res, 200, 'success');
//        halt($res->toArray());


        if (count($res) == '') {
            $data = '';
        }
        for ($i = 0; $i < count($res); $i++) {
            $data[$i] = Product::with('product_banner')->where('product_id', $res[$i]['product_id'])->find();
        }
        $this->result($data, 200, 'success');
    }

    /**
     * 用户商品添加收藏
     */
    public function prodCollection(Request $request)
    {
        $param = $request->param();
        $UserCollection = new UserCollection();
        if (!empty($param['isdel'])) {
            $res = $UserCollection->where([
                'product_id' => $param['product_id'],
                'user_id' => $param['user_id'],
            ])->delete();
            $msg = 'del';
        } else {
            $data = [
                'product_id' => $param['product_id'],
                'user_id' => $param['user_id'],
                'collection_time' => time(),
            ];
            $res = $UserCollection->save($data);
            $msg = 'add';
        }
        $this->result(compact('msg'), 200, 'success');
    }

    /**
     * 新增收获地址
     */
    public function createAddr()
    {
        $param = input('param.');
//        halt($param);
        $res = UserAddress::create([
            'user_id' => $param['user_id'],
            'address_name' => $param['address_name'],
            'address_phone' => $param['address_phone'],
            'sheng' => $param['sheng'],
            'shi' => $param['shi'],
            'qu' => $param['qu'],
            'more_addr' => $param['more_addr'],
            'address_default' => $param['address_default'],
            'address_add_time' => time(),
        ]);
        $this->result($res, 200, 'success');
    }


    public function editAddr()
    {
        $param = input('param.');
//        halt($param);
        $res = UserAddress::update([
            'address_name' => $param['address_name'],
            'address_phone' => $param['address_phone'],
            'sheng' => $param['sheng'],
            'shi' => $param['shi'],
            'qu' => $param['qu'],
            'more_addr' => $param['more_addr'],
            'address_default' => $param['address_default'],
        ], [
            'address_id' => $param['address_id'],
        ]);
        $this->result($res, 200, 'success');
    }

    /**
     * 用户某条收货地址信息
     */
    public function addrInfo()
    {
        $addrInfo = UserAddress::find(input('param.id'));
        $this->result($addrInfo, 200, 'success');
    }

    /**
     * 修改默认
     */
    public function defaultAddr()
    {
        $param = input('param.');
        $addrInfo = UserAddress::find($param['address_id']);
        if ($param['address_default'] == 2) {
            UserAddress::where(['user_id' => $addrInfo['user_id']])->update([
                'address_default' => 1
            ]);
        }
        $addrInfo->address_default = $param['address_default'];
        $res = $addrInfo->save();
        $this->result($res, 200, 'success');
    }

    /**
     * 用户收货地址列表展示
     */
    public function addrList()
    {
        $data = UserAddress::where(['user_id' => input('param.user_id')])->order('address_default desc,address_add_time desc')->select();
        $this->result($data, 200, 'success');
    }

    /**
     * 用户删除收货地址
     */
    public function delAddr()
    {
        $res = UserAddress::destroy(input('param.id'));
        $this->result($res, 200, 'success');
    }
//     /**
//      * 会员充值
//      */
//     public function memberRecharge(){
//         $config=Config::get('admin');
//         $this->result($config['memberPrice'],200,'success');
//     }
//     /**
//      * 会员充值微信支付统一下单
//      */
//     public function doMemberRecharge(){
//         $param=input('param.');
//         $config=Config::get('admin');
//         //对应商品的详细信息
//         $memberPriceInfo=$config['memberPrice'][$param['index']];
//         $data=[
//             'agent_id'=>$param['agent_id'],
//             'user_id'=>$param['user_id'],
//             'member_pay_money'=>$memberPriceInfo['price'],
//             'service_time'=>$memberPriceInfo['time']/(86400*30),
//             'service_name'=>$memberPriceInfo['name'],
//             'order_number'=>order_number(),
//             'user_record_add_time'=>time(),
//         ];
//         $userInfo=UserModel::get($param['user_id']);
//         $data['begin_time']=$userInfo['member_end_time']==0?time():$userInfo->member_end_time;
//         $data['end_time']=$data['begin_time']+$memberPriceInfo['time'];
//         $userInfo->member_end_time=$data['end_time'];
//         $res=UserRecord::create($data);
//         $WxPay=new WxPay();
//         $param=[
//             'fee'=>$memberPriceInfo['price'],
//             'body'=>$memberPriceInfo['name'],
//             'openid'=>$userInfo['openid'],
//             'out_trade_no'=>$data['order_number'],
//             'notify_url'=>'https://www.zrqygw.cn/public/api/notify/memberrechargenotify.html',
//         ];
//         $WxPay->Wx_Pay($param);
// //        return $this->result($res,200,'充值记录添加成功');
//     }

//     /**
//      * 意见反馈提交
//      */
//     public function userIdea(){
//         $data=[
//             'agent_id'=>input('param.agent_id'),
//             'user_id'=>input('param.user_id'),
//             'idea_content'=>input('param.idea_content'),
//             'idea_add_time'=>time()
//         ];
//         $res=UserIdea::create($data);
//         $this->result($res,200,'成功');
//     }

//     /**
//      * 查看会员充值记录
//      */
//     public function rechargeHistory(){
//         $res=UserRecord::where([
//             'user_id'=>input('param.user_id'),'is_pay'=>2
//         ])
//             ->field('begin_time,end_time,member_pay_money,user_record_add_time,service_name')
//             ->order('user_record_add_time desc')
//             ->select();
//         foreach ($res as $key=>$value){
//             $res[$key]['begin_time']=date('Y年m月d日 H:i:s',$value['begin_time']);
//             $res[$key]['end_time']=date('Y年m月d日 H:i:s',$value['end_time']);
//             $res[$key]['user_record_add_time']=date('Y年m月d日 H:i:s',$value['user_record_add_time']);
//         }
//         $this->result($res,200,'success');
//     }

//     /**
//      * 查询微信支付订单（废弃）
//      */
//     public function test(){
//         require_once ROOT_PATH.'weixinpay/lib/WxPay.Api.php';
//         $input = new \WxPayOrderQuery();
//         $input->SetOut_trade_no(input('param.order'));
//         $WxPayApi=new \WxPayApi();
//         $res=$WxPayApi->orderQuery($input);
//         if(!empty($res['trade_state'])){
//             $res=UserRecord::where(['is_pay'=>1,'order_number'=>input('param.order')])
//                 ->update([
//                     'is_pay'=>2,
//                     'transaction_id'=>$res['transaction_id']
//                 ]);
//             if($res){
//                 $UserRecordInfo=UserRecord::where(['is_pay'=>2,'order_number'=>input('param.order')])->find();
//                 UserModel::update(['member_end_time'=>$UserRecordInfo['end_time']],['user_id'=>$UserRecordInfo['user_id']]);
//             }
//         }
//     }
}