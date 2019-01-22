<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/12/22
 * Time: 11:42
 */

namespace app\api\controller;


use app\common\model\UserLinesRecord;
use think\Controller;
use app\common\model\UserOfferPrice;
use app\common\model\UserOfferAgent;
use app\common\model\Product;
use app\common\model\User;
use app\common\model\UserOfferSettime;
use think\Request;

class Offerprice extends Controller
{
    /**
     * 创建普通出价
     */
    public function create(Request $request)
    {
        $param = $request->param();
        $userInfo = User::where(['user_id' => $param['user_id']])->limit(1)->find();
        if ($userInfo['user_lines'] < $param['offer_money']) {
            $this->result('', 400, '竞拍额度不足！');
        }
        //产品信息
        $prodInfo = Product::limit(1)->find($param['product_id']);
        //最高的一条出价记录
        $offerPriceInfo = UserOfferPrice::where([
            'product_id' => $param['product_id']
        ])->order([
            'offer_money' => 'desc',
            'offer_id' => 'desc'
        ])->limit(1)->find();
        if ($offerPriceInfo['offer_money'] >= $param['offer_money']) {
            $this->result([], 400, '出价必须高于目前出最高价！');
        }
        $result = UserOfferPrice::create([
            'user_id' => $param['user_id'],
            'product_id' => $param['product_id'],
            'offer_money' => $param['offer_money'],
            'offer_add_time' => time(),
        ]);
        //为创建普通出价的用户添加一条竞拍额度使用流水记录
        UserLinesRecord::create([
            'user_id' => $param['user_id'],
            'offer_id' => $result['offer_id'],
            'product_id' => $param['product_id'],
            'type' => 2,
            'money' => -$param['offer_money'],
            'record_add_time' => time(),
        ]);
        //对应用户减去相应的竞拍额度
        User::where(['user_id' => $param['user_id']])->setDec('user_lines', $param['offer_money']);
        //目前最高代理价
        $agentInfo = UserOfferAgent::where(['product_id' => $param['product_id']])->order(['offer_money' => 'desc'])->limit(1)->find();
        if ($agentInfo['offer_money'] >= ($param['offer_money'] + $prodInfo['product_times'])) {
            $agentRes = UserOfferPrice::create([
                'user_id' => $agentInfo['user_id'],
                'product_id' => $param['product_id'],
                'is_agent' => 2,
                'offer_money' => $param['offer_money'] + $prodInfo['product_times'],
                'offer_add_time' => time(),
            ]);
            //为创建普通出价的用户添加一条竞拍额度使用流水记录
            UserLinesRecord::create([
                'user_id' => $agentInfo['user_id'],
                'offer_id' => $agentRes['offer_id'],
                'product_id' => $param['product_id'],
                'type' => 2,
                'money' => -$agentRes['offer_money'],
                'record_add_time' => time(),
            ]);
            //对应用户减去相应的竞拍额度
            User::where(['user_id' => $agentInfo['user_id']])->setDec('user_lines', $agentRes['offer_money']);
        }
        $this->result($result, 200, 'success');
    }

    /**
     * 创建代理出价
     */
    public function createAgent(Request $request)
    {
        $param = $request->param();
        $userInfo = User::where(['user_id' => $param['user_id']])->limit(1)->find();
        if ($userInfo['user_lines'] < $param['offer_money']) {
            $this->result('', 400, '竞拍额度不足！');
        }
        $nowMoney = UserOfferAgent::where([
            'product_id' => $param['product_id']
        ])->order([
            'offer_money' => 'desc',
            'offer_agent_id' => 'desc'
        ])->limit(1)->find();
        if ($nowMoney['offer_money'] >= $param['offer_money']) {
            $this->result([], 400, '出价必须高于目前出最高代理价！');
        }
        $result = UserOfferAgent::create([
            'user_id' => $param['user_id'],
            'product_id' => $param['product_id'],
            'offer_money' => $param['offer_money'],
            'offer_add_time' => time(),
        ]);
        $this->result($result, 200, 'success');
    }

    /*
     * 创建定时出价
     */
    public function createTime(Request $request)
    {
        $param = $request->param();
        $prodInfo = Product::limit(1)->find($param['product_id']);
        $offerInfo = UserOfferPrice::where([
            'product_id' => $param['product_id']
        ])->order([
            'offer_money' => 'desc',
            'offer_id' => 'desc'
        ])->limit(1)->find();
        UserOfferSettime::create([
            'user_id' => $param['user_id'],
            'product_id' => $param['product_id'],
            'offer_money' => $offerInfo['offer_money'] + $prodInfo['product_times'],
            'happen_time' => $prodInfo['product_end_time'] - 30,//30s前出价
            'add_time' => time(),
        ]);
    }

    /**
     * 某件商品的出价记录
     */
    public function offerPriceHistory(Request $request)
    {
        $param = $request->param();
        $data = UserOfferPrice::with(['User' => function ($query) {
            $query->field('user_id,nick_name');
        }])->where(['product_id' => $param['id']])
            ->order(['offer_money' => 'desc', 'offer_add_time' => 'asc'])
            ->select();
        foreach ($data as $key => $value) {
            $data[$key]['offer_add_time'] = date('Y-m-d H:i:s', $value['offer_add_time']);
        }
        $this->result(compact('data'), 200, 'success');
    }
}