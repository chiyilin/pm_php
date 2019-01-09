<?php
/**
 * Created by PhpStorm.
 * User: Y_Lin
 * Date: 2018/9/4
 * Time: 14:03
 */

namespace app\api\controller;

use app\common\model\Layer as LayerModel;
use app\common\model\LayerStar;
use think\Config;
use think\Controller;

class Layer extends Controller
{
    /**
     * 律师详情
     */
    public function details(){
        $detalis=LayerModel::get(input('param.layer_id'));
        $config=Config::get('admin');
        $detalis['layer_level_name']=$config['layer_level'][$detalis['layer_level']];
        $this->result($detalis,200,'律师详情获取成功');
    }
    /**
     * 律师点赞
     */
    public function star(){
        $layer_id=input('param.layer_id');
        $user_id=input('param.user_id');
        $beforStar=LayerStar::where(['layer_id'=>$layer_id,'user_id'=>$user_id])->count();
        if($beforStar==0){
            $layer=new LayerModel();
            $layerInfo=$layer->where('layer_id',$layer_id)->find();
            $layerInfo->layer_stat_num=$layerInfo->layer_stat_num+1;
            $layerInfo->save();
            LayerStar::create(['layer_id'=>$layer_id,'user_id'=>$user_id,'add_time'=>time()]);
            $this->result(['nowStar'=>$layerInfo->layer_stat_num],200,'点赞');
        }else{
            $this->result([],400,'已经赞过了');
        }
    }
}