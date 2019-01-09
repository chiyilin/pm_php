<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/10/8
 * Time: 12:05
 */

namespace app\api\controller;

use app\common\model\Jfproduct as JfproductModel;
use app\common\model\ProductBanner;
use app\common\model\User;

use app\common\WxPay;
use think\Config;
use think\Controller;

class Jfproduct extends Controller
{
    /**
     * 积分产品展示
     */
    public function index(){
        $jfproduct=JfproductModel::with('jfproductbanner')->order('jfproduct_sort')->select();
        $user=User::with('useraddress')->where('user_id',input('param.user_id'))->limit(1)->find();
        $this->result([
                'jfproduct'=>$jfproduct,
                'user'=>$user,
            ],200,'success');
    }
    public function jfproduct(){
        $JfproductModel=JfproductModel::with('jfproductbanner')->where('jfproduct_id',input('param.jfproduct_id'))->limit(1)->find();
        $user=User::with('useraddress')->where('user_id',input('param.user_id'))->limit(1)->find();
        $this->result([
                'jfproduct'=>$JfproductModel,
                'user'=>$user,
            ],200,'success');
    }
    /**
     * 产品购买生成订单
     */
    public function addList(){
        $data=ProdList::create([
            'user_id'=>input('param.user_id'),
            'order_number'=>order_number(),
            'product_id'=>input('param.product_id'),
            'product_class_id'=>input('param.product_class_id'),
            'list_type'=>input('param.list_type'),
            'agent_id'=>input('param.agent_id'),
            'pay_money'=>input('param.pay_money'),
            'list_add_time'=>time(),
        ]);
        if(input('param.pay_money')==0){
            ProdList::update(['is_pay'=>2],['list_id'=>$data['list_id']]);
            $this->result($data,400,'eroor');
        }
        $config=Config::get('admin')['list_type'];
        $WxPay=new WxPay();
        $param=[
            'fee'=>$data['pay_money'],
            'body'=>$config[$data['list_type']-1],
            'openid'=>input('param.openid'),
            'out_trade_no'=>$data['order_number'],
            'notify_url'=>'https://www.zrqygw.cn/public/api/notify/buynotify.html',
        ];
        $WxPay->Wx_Pay($param);
        // $this->result($data,200,'success');

    }
    /**
     * 产品评论
     */
    public function talk(){
        $id =input('param.id');
        $producttalk=ProdListComment::with('user,prodlistcommentimg')->where('product_id',$id)->order('list_comment_add_time desc')->select();
        foreach($producttalk as $key=>$value){
            $producttalk[$key]['list_comment_add_time_str']=date('Y-m-d H:i:s',$value['list_comment_add_time']);
        }
        $data=[
            'producttalk'=>$producttalk
        ];
        $this->result($data,200,'success');
    }
    // public function common(){
    //     $start=input('param.start')*input('param.size');
    //     $size=input('param.size');
    //     $res=ProdListComment::with('user,prodlistcommentimg')->where('product_id',input('param.product_id'))->order('list_comment_add_time desc')->limit($start,$size)->select();
    //     foreach ($res as $key => $value) {
    //         $res[$key]['list_comment_add_time_str']=date('Y/m/d H:i:s',$value['list_comment_add_time']);
    //     }
    //     $this->result($res,200,'success');
    // }
}