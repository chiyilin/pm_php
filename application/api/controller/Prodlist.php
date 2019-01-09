<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/9/11
 * Time: 9:25
 */

namespace app\api\controller;

use app\common\model\Config as ConfigModel;
use think\Config;
use think\Controller;
use app\common\model\ProdList as ProdListModel;
use app\common\model\ProdListComment;
use think\Loader;
use app\common\model\ProdListBetween;
use think\Request;


class ProdList extends Controller
{
    /**
     * 已经到手的藏品
     */
    public function onHandProdList(Request $request)
    {
        $param = $request->param();
        $onHandData = ProdListBetween::where(['user_id' => $param['user_id'], 'is_pay' => 5])->order(['add_time' => ' desc'])->select();
        foreach ($onHandData as $key => $item) {
            $onHandData[$key]['product_info'] = unserialize($item['product_info']);
//            $onHandData[$key]['add_time'] = date('Y-m-d H:i:s', $item['add_time']);
//            $onHandData[$key]['pay_time'] = date('Y-m-d H:i:s', $item['pay_time']);
            $onHandData[$key]['on_hand_time_str'] = date('Y-m-d H:i:s', $item['on_hand_time']);
        }
        $this->result(compact('onHandData'), 200, 'success');
    }

    /**
     * 订单详情
     */
    public function details(Request $request)
    {
        $param = $request->param();
        $data = ProdListBetween::limit(1)->find($param['id']);
        $data['product_info'] = unserialize($data['product_info']);
        $data['add_time'] = $data['add_time'] ? date('Y-m-d H:i:s', $data['add_time']) : null;
        $data['pay_time'] = $data['pay_time'] ? date('Y-m-d H:i:s', $data['pay_time']) : null;
        $data['on_hand_time'] = $data['on_hand_time'] ? date('Y-m-d H:i:s', $data['on_hand_time']) : null;
//        halt($data->toArray());
        $config = Config::get('status');
        $this->result(compact('data', 'config'), 200, 'success');
    }

    /**
     * 快递100查询快递信息
     * @param Request $request
     * @return string
     */
    public function getOrderExpressInfo(Request $request)
    {
        $param = $request->param();
        $data = ProdListBetween::where(['between_id' => $param['between_id']])->limit(1)->field('tracking_number')->find();
        if (!empty($data['tracking_number'])) {
            Loader::import('KdApiSearch.Kd100', EXTEND_PATH);
            $Kd100 = new \Kd100();
            $res = $Kd100->getOrderTracesByJson($data['tracking_number']);
            $resArr = json_decode($res, true);
            $state = [
                '在途中',
                '已揽收',
                '疑难',
                '已签收',
                '退签',
                '同城派送中',
                '退回',
                '转单',
            ];
            $image = "https://cdn.kuaidi100.com/images/all/56/" . $resArr['com'] . ".png";
            $this->result(compact('state', 'image', 'resArr'), 200, 'success');
//        echo json_encode(compact('state', 'image', 'resArr'));
        } else {
//        $str = '{"message":"ok","nu":"3387798869530","ischeck":"1","condition":"F00","com":"shentong","status":"200","state":"3","data":[{"time":"2018-12-03 17:33:06","ftime":"2018-12-03 17:33:06","context":"值班室签收-已签收"},{"time":"2018-12-03 14:19:33","ftime":"2018-12-03 14:19:33","context":"北京朝阳十里河公司-业务员刘立强(18612570784,)-派件中"},{"time":"2018-12-03 13:53:10","ftime":"2018-12-03 13:53:10","context":"已到达-北京朝阳十里河公司"},{"time":"2018-12-03 09:20:53","ftime":"2018-12-03 09:20:53","context":"北京市内分拨中心-已发往-北京朝阳十里河公司"},{"time":"2018-12-02 16:53:29","ftime":"2018-12-02 16:53:29","context":"北京转运中心-已装袋发往-北京市内分拨中心"},{"time":"2018-11-30 22:24:10","ftime":"2018-11-30 22:24:10","context":"浙江宁波转运中心-已装袋发往-北京转运中心"},{"time":"2018-11-30 19:27:38","ftime":"2018-11-30 19:27:38","context":"浙江慈溪公司-已装袋发往-浙江宁波新航空部"},{"time":"2018-11-30 19:21:24","ftime":"2018-11-30 19:21:24","context":"浙江慈溪公司-已进行装袋扫描"},{"time":"2018-11-30 19:21:24","ftime":"2018-11-30 19:21:24","context":"浙江慈溪公司-已发往-浙江宁波转运中心"},{"time":"2018-11-30 19:10:32","ftime":"2018-11-30 19:10:32","context":"浙江慈溪公司-浙江慈溪公司(0574-63197892)-已收件"}]}';
            $str = '{"state":["\u5728\u9014\u4e2d","\u5df2\u63fd\u6536","\u7591\u96be","\u5df2\u7b7e\u6536","\u9000\u7b7e","\u540c\u57ce\u6d3e\u9001\u4e2d","\u9000\u56de","\u8f6c\u5355"],"image":"https:\/\/cdn.kuaidi100.com\/images\/all\/56\/huitongkuaidi.png","resArr":{"message":"ok","nu":"70348608789265","ischeck":"1","condition":"F00","com":"huitongkuaidi","status":"200","state":"3","data":[{"time":"2019-01-06 12:36:25","ftime":"2019-01-06 12:36:25","context":"\u7b7e\u6536|\u5317\u4eac\u5e02\u3010\u897f\u5927\u671b\u8def\u5357\u533a\u3011\uff0c\u62cd\u7167\u7b7e\u6536 \u5df2\u7b7e\u6536"},{"time":"2019-01-06 08:49:56","ftime":"2019-01-06 08:49:56","context":"\u6d3e\u4ef6|\u5317\u4eac\u5e02\u3010\u897f\u5927\u671b\u8def\u5357\u533a\u3011\uff0c\u3010\u5434\u6c38\u6653\/15911099112\u3011\u6b63\u5728\u6d3e\u4ef6"},{"time":"2019-01-06 08:48:56","ftime":"2019-01-06 08:48:56","context":"\u5230\u4ef6|\u5230\u5317\u4eac\u5e02\u3010\u897f\u5927\u671b\u8def\u5357\u533a\u3011"},{"time":"2019-01-05 20:21:19","ftime":"2019-01-05 20:21:19","context":"\u53d1\u4ef6|\u5317\u4eac\u5e02\u3010\u5317\u4eac\u8f6c\u8fd0\u4e2d\u5fc3\u3011\uff0c\u6b63\u53d1\u5f80\u3010\u897f\u5927\u671b\u8def\u5357\u533a\u3011"},{"time":"2019-01-05 18:34:54","ftime":"2019-01-05 18:34:54","context":"\u5230\u4ef6|\u5230\u5317\u4eac\u5e02\u3010\u5317\u4eac\u8f6c\u8fd0\u4e2d\u5fc3\u3011"},{"time":"2019-01-04 20:36:20","ftime":"2019-01-04 20:36:20","context":"\u53d1\u4ef6|\u9752\u5c9b\u5e02\u3010\u9752\u5c9b\u8f6c\u8fd0\u4e2d\u5fc3\u3011\uff0c\u6b63\u53d1\u5f80\u3010\u5317\u4eac\u8f6c\u8fd0\u4e2d\u5fc3\u3011"},{"time":"2019-01-04 20:34:03","ftime":"2019-01-04 20:34:03","context":"\u5230\u4ef6|\u5230\u9752\u5c9b\u5e02\u3010\u9752\u5c9b\u8f6c\u8fd0\u4e2d\u5fc3\u3011"},{"time":"2019-01-04 17:37:02","ftime":"2019-01-04 17:37:02","context":"\u53d1\u4ef6|\u9752\u5c9b\u5e02\u3010\u9752\u5c9b\u9ec4\u5c9b\u4e8c\u90e8\u3011\uff0c\u6b63\u53d1\u5f80\u3010\u9752\u5c9b\u8f6c\u8fd0\u4e2d\u5fc3\u3011"},{"time":"2019-01-04 14:49:42","ftime":"2019-01-04 14:49:42","context":"\u6536\u4ef6|\u9752\u5c9b\u5e02\u3010\u9752\u5c9b\u9ec4\u5c9b\u4e8c\u90e8\u3011\uff0c\u3010\u9ec4\u5c9b\u4e8c\u90e8\/18561878412\u3011\u5df2\u63fd\u6536"}]}}';
            return $this->result(json_decode($str, true), 200, 'success');
            $this->result([], 400, '暂无单号信息~');

        }
    }

    public function expressInfo()
    {
        Loader::import('KdApiSearch.KdApiSearch', EXTEND_PATH, '.class.php');

        $KdApiSearch = new \KdApiSearch();
        //韵达快递
        $requestData = "{'OrderCode':'','ShipperCode':'YD','LogisticCode':'3816950621035'}";
        //邮政包裹
        $requestData = "{'OrderCode':'','ShipperCode':'YZPY','LogisticCode':'9893697968452'}";
        //天天快递 （注：仅支持付费开通的在途监控接口<8001/8008>查询）
        $requestData = "{'OrderCode':'','ShipperCode':'HHTT','LogisticCode':'669549436693'}";
        //顺丰（注：仅支持通过快递鸟下单接口<1007/1001>返回的顺丰单号查询）"
        $requestData = "{'OrderCode':'','ShipperCode':'SF','LogisticCode':'289354759176'}";
        //申通快递 （注：仅支持付费开通的在途监控接口<8001/8008>查询）
        $requestData = "{'OrderCode':'','ShipperCode':'STO','LogisticCode':'3387798869530'}";
        //百世快递
        $requestData = "{'OrderCode':'','ShipperCode':'HTKY','LogisticCode':'70348608789265'}";
        $data = [
            'OrderCode' => '',
            'ShipperCode' => 'HTKY',
            'LogisticCode' => '70348608789265'
        ];
        halt($KdApiSearch->getOrderTracesByJson($data));
    }

    /*
     * 我的课程-评价发布【已购产品列表】
     */
    public function pingjiafb()
    {
        $list_id = input('param.list_id') ? input('param.list_id') : '';
        $res = ProdListModel::with('user,product,productbanner,producttaoc,producttaocbanner')->where('list_id', $list_id)->limit(1)->find();
        $res['list_add_time'] = date('Y-m-d H:i:s', $res['list_add_time']);
        $this->result($res, 200, 'success');
    }

    /**
     * 已购服务列表
     */
    public function productList()
    {
        // echo input('param.user_id');die();
        $start = input('param.start') * input('param.size');
        $size = input('param.size');
        $res = ProdListModel::with('product,productclass,productbanner')->where(['is_pay' => ['>=', 2], 'user_id' => input('param.user_id')])->order('list_add_time desc')->limit($start, $size)->select();
        foreach ($res as $key => $value) {
            $res[$key]['list_add_time_str'] = date('Y/m/d H:i:s', $value['list_add_time']);
        }
        $this->result($res, 200, 'success!@');
    }

    /**
     * 单条回复信息的信息
     */
    public function CommentInfo()
    {
        $res = ProdListComment::with('product,user,producttaoc')->where('list_comment_id', input('param.id'))->find();
//        halt($res->toArray());
        $this->result($res, 200, 'success!');
    }
}